package com.managementbanhxeo.servlet.auth;

import com.managementbanhxeo.dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
        if (session != null) {
            Integer userId = (Integer) session.getAttribute("userId"); // Giả sử userId được lưu trong session
            if (userId != null) {
                orderDAO.clearCart(userId); // Xóa giỏ hàng
                System.out.println("Xóa giỏ hàng thành công cho user ID " + userId + " khi đăng xuất");
            }
            session.invalidate(); // Hủy session
            request.getSession().setAttribute("message", "Đăng xuất thành công!");
            System.out.println("Đăng xuất thành công!");
        }
        response.sendRedirect(request.getContextPath() + "/login");
    }
}