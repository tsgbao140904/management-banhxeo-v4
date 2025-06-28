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
        response.setContentType("application/json;charset=UTF-8");
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            int userId = user.getUserId();
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            orderDAO.addToCart(userId, menuId, quantity);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Thêm vào giỏ hàng thành công!\"}");
            System.out.println("Thêm món ID " + menuId + " vào giỏ hàng cho user ID " + userId);
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng đăng nhập!\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            int userId = user.getUserId();
            List<com.managementbanhxeo.model.Menu> cartItems = orderDAO.getCartItems(userId);
            request.setAttribute("cartItems", cartItems);
            request.getRequestDispatcher("/user/cart.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}