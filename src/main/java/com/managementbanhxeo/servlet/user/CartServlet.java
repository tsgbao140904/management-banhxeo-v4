package com.managementbanhxeo.servlet.user;

import com.managementbanhxeo.dao.OrderDAO;
import com.managementbanhxeo.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/cart")
public class CartServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");
        User user = (User) request.getSession().getAttribute("user");
        System.out.println("Received POST request for /user/cart with user: " + (user != null ? user.getUserId() : "null"));

        if (user != null) {
            String action = request.getParameter("action");
            int userId = user.getUserId();
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            System.out.println("Action: " + (action != null ? action : "null") + ", userId: " + userId + ", menuId: " + menuId + ", quantity: " + quantity);

            if (action == null || "add".equals(action)) { // Xử lý mặc định nếu action null
                try {
                    orderDAO.addToCart(userId, menuId, quantity);
                    response.setStatus(HttpServletResponse.SC_OK);
                    String msg = "Thêm vào giỏ hàng thành công! Món: " + menuId + ", Quantity: " + quantity;
                    response.getWriter().write(msg);
                    System.out.println(msg);
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    String errorMsg = "Lỗi khi thêm vào giỏ hàng: " + e.getMessage() + ". Menu ID: " + menuId + ", User ID: " + userId;
                    response.getWriter().write(errorMsg);
                    System.out.println(errorMsg);
                }
            } else if ("update".equals(action)) {
                if (quantity >= 0) {
                    try {
                        orderDAO.updateCartQuantity(userId, menuId, quantity);
                        response.setStatus(HttpServletResponse.SC_OK);
                        response.getWriter().write(String.valueOf(quantity));
                        System.out.println("Cập nhật số lượng món ID " + menuId + " cho user ID " + userId + " thành " + quantity);
                    } catch (Exception e) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write("Lỗi khi cập nhật số lượng: " + e.getMessage());
                    }
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Số lượng không thể âm!");
                }
            }
        } else {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Vui lòng đăng nhập!");
            System.out.println("Unauthorized access to /user/cart");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        User user = (User) request.getSession().getAttribute("user");
        System.out.println("Received GET request for /user/cart with user: " + (user != null ? user.getUserId() : "null"));

        if (user != null) {
            int userId = user.getUserId();
            List<com.managementbanhxeo.model.Menu> cartItems = orderDAO.getCartItems(userId);
            System.out.println("Retrieved " + cartItems.size() + " items for user ID " + userId);
            request.setAttribute("cartItems", cartItems);
            request.getRequestDispatcher("/user/cart.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
            System.out.println("Redirecting to login due to null user");
        }
    }
}