package com.managementbanhxeo.dao;

import com.managementbanhxeo.config.DBConfig;
import com.managementbanhxeo.model.Menu;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

public class MenuDAO {
    public List<Menu> getAllMenus() {
        List<Menu> menus = new ArrayList<>();
        String sql = "SELECT * FROM menu ORDER BY created_at DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Menu menu = new Menu(rs.getInt("menu_id"), rs.getString("name"), rs.getDouble("price"),
                        rs.getString("image_url"), rs.getInt("likes"), rs.getString("category"));
                menu.setCreatedAt(rs.getTimestamp("created_at"));
                menus.add(menu);
            }
            System.out.println("Lấy danh sách menu thành công!");
        } catch (SQLException e) {
            System.out.println("Lỗi: Lấy danh sách menu thất bại - " + e.getMessage());
        }
        return menus;
    }

    public Set<String> getAllCategories() {
        Set<String> categories = new TreeSet<>();
        String sql = "SELECT DISTINCT category FROM menu WHERE category IS NOT NULL";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String category = rs.getString("category");
                if (category != null && !category.trim().isEmpty()) {
                    categories.add(category);
                }
            }
            System.out.println("Lấy danh sách danh mục thành công!");
        } catch (SQLException e) {
            System.out.println("Lỗi: Lấy danh sách danh mục thất bại - " + e.getMessage());
        }
        return categories;
    }

    public List<Menu> getMenus(String search, String category, int page, int pageSize) {
        List<Menu> menus = new ArrayList<>();
        String sql = "SELECT * FROM menu WHERE 1=1";
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND name LIKE ?";
        }
        if (category != null && !category.trim().isEmpty()) {
            sql += " AND category = ?";
        }
        sql += " ORDER BY created_at DESC LIMIT ? OFFSET ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search.trim() + "%");
            }
            if (category != null && !category.trim().isEmpty()) {
                ps.setString(paramIndex++, category.trim());
            }
            ps.setInt(paramIndex++, pageSize);
            ps.setInt(paramIndex, (page - 1) * pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Menu menu = new Menu(rs.getInt("menu_id"), rs.getString("name"), rs.getDouble("price"),
                        rs.getString("image_url"), rs.getInt("likes"), rs.getString("category"));
                menu.setCreatedAt(rs.getTimestamp("created_at"));
                menus.add(menu);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi: Lấy danh sách menu với bộ lọc thất bại - " + e.getMessage());
        }
        return menus;
    }

    public int getTotalMenus(String search, String category) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM menu WHERE 1=1";
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND name LIKE ?";
        }
        if (category != null && !category.trim().isEmpty()) {
            sql += " AND category = ?";
        }
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search.trim() + "%");
            }
            if (category != null && !category.trim().isEmpty()) {
                ps.setString(paramIndex, category.trim());
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi: Đếm tổng số menu thất bại - " + e.getMessage());
        }
        return total;
    }

    public void addMenu(Menu menu) {
        String sql = "INSERT INTO menu (name, price, image_url, likes, category, created_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, menu.getName());
            ps.setDouble(2, menu.getPrice());
            ps.setString(3, menu.getImageUrl());
            ps.setInt(4, menu.getLikes());
            ps.setString(5, menu.getCategory());
            ps.setTimestamp(6, new Timestamp(menu.getCreatedAt().getTime()));
            ps.executeUpdate();
            System.out.println("Thêm menu thành công!");
        } catch (SQLException e) {
            System.out.println("Lỗi: Thêm menu thất bại - " + e.getMessage());
        }
    }

    public void updateLikes(int menuId, int likes) {
        String sql = "UPDATE menu SET likes = ? WHERE menu_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, likes);
            ps.setInt(2, menuId);
            ps.executeUpdate();
            System.out.println("Cập nhật lượt thích thành công!");
        } catch (SQLException e) {
            System.out.println("Lỗi: Cập nhật lượt thích thất bại - " + e.getMessage());
        }
    }

    public void deleteMenu(int menuId) {
        String sql = "DELETE FROM menu WHERE menu_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, menuId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Xóa món ID " + menuId + " thành công!");
            } else {
                System.out.println("Không tìm thấy món ID " + menuId + " để xóa!");
            }
        } catch (SQLException e) {
            System.out.println("Lỗi: Xóa menu thất bại - " + e.getMessage());
        }
    }

    public Menu getMenuById(int menuId) {
        Menu menu = null;
        String sql = "SELECT * FROM menu WHERE menu_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, menuId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                menu = new Menu(rs.getInt("menu_id"), rs.getString("name"), rs.getDouble("price"),
                        rs.getString("image_url"), rs.getInt("likes"), rs.getString("category"));
                menu.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi: Lấy menu theo ID thất bại - " + e.getMessage());
        }
        return menu;
    }

    public void updateMenu(Menu menu) {
        String sql = "UPDATE menu SET name = ?, price = ?, image_url = ?, likes = ?, category = ? WHERE menu_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, menu.getName());
            ps.setDouble(2, menu.getPrice());
            ps.setString(3, menu.getImageUrl());
            ps.setInt(4, menu.getLikes());
            ps.setString(5, menu.getCategory());
            ps.setInt(6, menu.getMenuId());
            ps.executeUpdate();
            System.out.println("Cập nhật menu thành công!");
        } catch (SQLException e) {
            System.out.println("Lỗi: Cập nhật menu thất bại - " + e.getMessage());
        }
    }

    public void addCategory(String categoryName) {
        Set<String> existingCategories = getAllCategories();
        if (!existingCategories.contains(categoryName)) {
            Menu sampleMenu = new Menu("Món mẫu " + categoryName, 10000.0, null, 0, categoryName);
            sampleMenu.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            addMenu(sampleMenu);
            System.out.println("Thêm danh mục '" + categoryName + "' thành công với món mẫu!");
        } else {
            System.out.println("Danh mục '" + categoryName + "' đã tồn tại!");
        }
    }

    // Phương thức mới để xóa danh mục
    public void deleteCategory(String categoryName) {
        Set<String> existingCategories = getAllCategories();
        if (existingCategories.contains(categoryName)) {
            String sql = "DELETE FROM menu WHERE category = ?";
            try (Connection conn = DBConfig.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, categoryName);
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Xóa danh mục '" + categoryName + "' và các món liên quan thành công!");
                } else {
                    System.out.println("Không có món nào thuộc danh mục '" + categoryName + "' để xóa!");
                }
            } catch (SQLException e) {
                System.out.println("Lỗi: Xóa danh mục '" + categoryName + "' thất bại - " + e.getMessage());
            }
        } else {
            System.out.println("Danh mục '" + categoryName + "' không tồn tại!");
        }
    }
}