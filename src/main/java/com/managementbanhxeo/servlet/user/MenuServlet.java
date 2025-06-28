package com.managementbanhxeo.servlet.user;

import com.managementbanhxeo.dao.MenuDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/menu")
public class MenuServlet extends HttpServlet {
    private MenuDAO menuDAO = new MenuDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<com.managementbanhxeo.model.Menu> menus = menuDAO.getAllMenus();
        request.setAttribute("menus", menus);
        request.getRequestDispatcher("/user/menu.jsp").forward(request, response);
    }
}