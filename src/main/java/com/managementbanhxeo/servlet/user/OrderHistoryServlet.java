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

@WebServlet("/user/order-history")
public class OrderHistoryServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            int userId = user.getUserId();
            int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
            int pageSize = 10;

            List<com.managementbanhxeo.model.Order> orders = orderDAO.getOrdersByUserId(userId, page, pageSize);
            int totalItems = orderDAO.getTotalOrdersByUserId(userId);
            int totalPages = (int) Math.ceil((double) totalItems / pageSize);

            request.setAttribute("orders", orders);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("/user/order-history.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}