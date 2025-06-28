package com.managementbanhxeo.servlet.admin;

import com.managementbanhxeo.dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/admin/report")
public class ReportServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        int month = request.getParameter("month") != null ? Integer.parseInt(request.getParameter("month")) : 0;
        int year = request.getParameter("year") != null ? Integer.parseInt(request.getParameter("year")) : 2025;

        double totalRevenue = orderDAO.getTotalRevenue(month, year);
        Map<String, Double> profitLoss = orderDAO.getProfitLoss(month, year);
        Map<String, Double[]> expenses = orderDAO.getMonthlyExpenses(month, year);

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("profitLoss", profitLoss);
        request.setAttribute("monthlyRevenue", expenses.get("income"));
        request.setAttribute("monthlyIncome", expenses.get("income"));
        request.setAttribute("monthlyExpenses", expenses.get("expense"));

        request.getRequestDispatcher("/admin/report.jsp").forward(request, response);
    }
}