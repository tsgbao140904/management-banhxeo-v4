package com.managementbanhxeo.dao;

import com.managementbanhxeo.config.DBConfig;
import com.managementbanhxeo.model.Menu;
import com.managementbanhxeo.model.Order;
import com.managementbanhxeo.model.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDAO {
    public void addToCart(int userId, int menuId, int quantity) {
        String sql = "INSERT INTO cart (user_id, menu_id, quantity) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE quantity = VALUES(quantity)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, menuId);
            ps.setInt(3, quantity);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Thêm vào giỏ hàng thành công cho user ID " + userId + ", món ID " + menuId);
            } else {
                System.out.println("Thêm vào giỏ hàng thất bại hoặc không có thay đổi cho user ID " + userId + ", món ID " + menuId);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi: Thêm vào giỏ hàng thất bại - " + e.getMessage());
        }
    }

    public List<Menu> getCartItems(int userId) {
        List<Menu> cartItems = new ArrayList<>();
        String sql = "SELECT m.*, c.quantity FROM menu m JOIN cart c ON m.menu_id = c.menu_id WHERE c.user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Menu menu = new Menu(
                            rs.getInt("menu_id"),
                            rs.getString("name"),
                            rs.getDouble("price"),
                            rs.getString("image_url"),
                            rs.getInt("likes"),
                            rs.getString("category")
                    );
                    menu.setQuantity(rs.getInt("quantity"));
                    cartItems.add(menu);
                }
                System.out.println("Lấy giỏ hàng thành công cho user ID " + userId + " với " + cartItems.size() + " món");
            }
        } catch (SQLException e) {
            System.out.println("Lỗi: Lấy giỏ hàng thất bại - " + e.getMessage());
        }
        return cartItems;
    }

    public void checkout(int userId, double totalAmount, String note) {
        Connection conn = null;
        try {
            conn = DBConfig.getConnection();
            conn.setAutoCommit(false);

            String sqlOrder = "INSERT INTO orders (user_id, total_amount, status, order_date, note) VALUES (?, ?, ?, NOW(), ?)";
            try (PreparedStatement psOrder = conn.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, userId);
                psOrder.setDouble(2, totalAmount);
                psOrder.setString(3, "CHOXACNHAN"); // Giá trị cố định, đảm bảo độ dài phù hợp
                psOrder.setString(4, note != null ? note : ""); // Thêm note, mặc định rỗng nếu null
                psOrder.executeUpdate();

                int orderId = 0;
                try (ResultSet rs = psOrder.getGeneratedKeys()) {
                    if (rs.next()) orderId = rs.getInt(1);
                }

                moveCartToOrderDetails(conn, userId, orderId);
                clearCart(conn, userId);
                conn.commit();
                System.out.println("Thanh toán thành công cho user ID " + userId + " với order ID " + orderId);
            }
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); System.out.println("Rollback thành công do lỗi: " + e.getMessage()); } catch (SQLException ex) { System.out.println("Rollback thất bại: " + ex.getMessage()); }
            }
            System.out.println("Lỗi: Thanh toán thất bại - " + e.getMessage());
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { System.out.println("Đóng kết nối thất bại: " + e.getMessage()); }
            }
        }
    }

    private void moveCartToOrderDetails(Connection conn, int userId, int orderId) throws SQLException {
        String sql = "INSERT INTO order_details (order_id, menu_id, quantity, price) SELECT ?, menu_id, quantity, (SELECT price FROM menu WHERE menu_id = cart.menu_id) FROM cart WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            ps.executeUpdate();
        }
    }

    private void clearCart(Connection conn, int userId) throws SQLException {
        String sql = "DELETE FROM cart WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        }
    }

    public List<Order> getOrdersByUserId(int userId, int page, int pageSize) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.username FROM orders o JOIN users u ON o.user_id = u.user_id WHERE o.user_id = ? ORDER BY o.order_date DESC LIMIT ? OFFSET ?";
        int offset = (page - 1) * pageSize;
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, pageSize);
            ps.setInt(3, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order(
                            rs.getInt("order_id"),
                            rs.getInt("user_id"),
                            rs.getDouble("total_amount"),
                            rs.getString("status"),
                            rs.getTimestamp("order_date"),
                            rs.getString("username"),
                            getOrderDetails(rs.getInt("order_id")),
                            rs.getString("note") // Thêm ánh xạ note
                    );
                    orders.add(order);
                }
            }
            System.out.println("Lấy danh sách đơn hàng thành công!");
        } catch (SQLException e) {
            System.out.println("Lỗi: Lấy danh sách đơn hàng thất bại - " + e.getMessage());
        }
        return orders;
    }

    public int getTotalOrdersByUserId(int userId) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM orders WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi: Đếm tổng số đơn hàng thất bại - " + e.getMessage());
        }
        return total;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.username FROM orders o JOIN users u ON o.user_id = u.user_id ORDER BY o.order_date DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getDouble("total_amount"),
                        rs.getString("status"),
                        rs.getTimestamp("order_date"),
                        rs.getString("username"),
                        getOrderDetails(rs.getInt("order_id")),
                        rs.getString("note") // Thêm ánh xạ note
                );
                orders.add(order);
            }
            System.out.println("Lấy tất cả đơn hàng thành công với " + orders.size() + " đơn");
        } catch (SQLException e) {
            System.out.println("Lỗi: Lấy tất cả đơn hàng thất bại - " + e.getMessage());
        }
        return orders;
    }

    private List<OrderDetail> getOrderDetails(int orderId) {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT od.*, m.name FROM order_details od JOIN menu m ON od.menu_id = m.menu_id WHERE od.order_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Menu menu = new Menu(rs.getInt("menu_id"), rs.getString("name"), rs.getDouble("price"), null, 0, null);
                    details.add(new OrderDetail(orderId, rs.getInt("menu_id"), rs.getInt("quantity"), rs.getDouble("price"), menu));
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi: Lấy chi tiết đơn hàng thất bại - " + e.getMessage());
        }
        return details;
    }

    public void updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Cập nhật trạng thái đơn hàng thành công!");
            } else {
                System.out.println("Cập nhật trạng thái thất bại: Không tìm thấy đơn hàng.");
            }
        } catch (SQLException e) {
            System.out.println("Lỗi: Cập nhật trạng thái đơn hàng thất bại - " + e.getMessage());
        }
    }

    public double getTotalRevenue() {
        double revenue = 0.0;
        String sql = "SELECT SUM(total_amount) as total FROM orders WHERE status = 'XACNHAN'";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) revenue = rs.getDouble("total");
            System.out.println("Tính doanh thu thành công: " + revenue);
        } catch (SQLException e) {
            System.out.println("Lỗi: Tính doanh thu thất bại - " + e.getMessage());
        }
        return revenue;
    }

    public double getTotalRevenue(int month, int year) {
        double total = 0;
        String sql = "SELECT SUM(total_amount) FROM orders WHERE (? IS NULL OR MONTH(order_date) = ?) AND YEAR(order_date) = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            if (month > 0) {
                stmt.setInt(1, month);
                stmt.setInt(2, month);
            } else {
                stmt.setNull(1, java.sql.Types.INTEGER);
                stmt.setNull(2, java.sql.Types.INTEGER);
            }
            stmt.setInt(3, year);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public Map<String, Double> getProfitLoss(int month, int year) {
        Map<String, Double> result = new HashMap<>();
        result.put("profit", 3000000.0); // Giả định
        result.put("loss", 500000.0);    // Giả định
        return result;
    }

    public Map<String, Double[]> getMonthlyExpenses(int month, int year) {
        Map<String, Double[]> result = new HashMap<>();
        Double[] income = {4000000.0, 6000000.0, 5000000.0, 7000000.0, 8000000.0, 6000000.0};
        Double[] expense = {3000000.0, 4500000.0, 4000000.0, 5500000.0, 6000000.0, 5000000.0};
        result.put("income", income);
        result.put("expense", expense);
        return result;
    }
}