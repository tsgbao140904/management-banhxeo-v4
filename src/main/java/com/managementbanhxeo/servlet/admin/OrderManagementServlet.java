package com.managementbanhxeo.servlet.admin;

import com.managementbanhxeo.dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/order-management")
public class OrderManagementServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Bổ sung xử lý xóa đơn hàng
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            orderDAO.deleteOrder(orderId);
            request.getSession().setAttribute("message", "Xóa đơn hàng thành công!");
            response.sendRedirect(request.getContextPath() + "/admin/order-management");
            return;
        }

        List<com.managementbanhxeo.model.Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/admin/order-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            orderDAO.updateOrderStatus(orderId, status);
            request.getSession().setAttribute("message", "Cập nhật trạng thái đơn hàng thành công!");
            response.sendRedirect(request.getContextPath() + "/admin/order-management");
        }
    }
}