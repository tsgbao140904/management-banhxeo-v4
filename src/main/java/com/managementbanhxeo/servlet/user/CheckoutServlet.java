package com.managementbanhxeo.servlet.user;

import com.managementbanhxeo.dao.OrderDAO;
import com.managementbanhxeo.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/user/checkout")
public class CheckoutServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            int userId = user.getUserId();
            double totalAmount = Double.parseDouble(request.getParameter("total"));
            String note = request.getParameter("note") != null ? request.getParameter("note") : "";
            try {
                orderDAO.checkout(userId, totalAmount, note);
                request.getSession().setAttribute("message", "Thanh toán thành công, chờ admin duyệt!");
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Thanh toán thành công, chờ admin duyệt!");
                System.out.println("Thanh toán thành công cho user ID " + userId + " với tổng " + totalAmount + " và ghi chú: " + note);
            } catch (Exception e) {
                request.getSession().setAttribute("error", "Thanh toán thất bại: " + e.getMessage());
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Thanh toán thất bại: " + e.getMessage());
                System.out.println("Lỗi thanh toán cho user ID " + userId + ": " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/user/cart"); // Quay lại giỏ hàng để cập nhật
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}