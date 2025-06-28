package com.managementbanhxeo.servlet.admin;

import com.managementbanhxeo.dao.UserDAO;
import com.managementbanhxeo.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet("/admin/user-management")
public class UserManagementServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            User user = userDAO.getUserById(userId);
            if (user != null) {
                request.setAttribute("editUser", user);
                request.getRequestDispatcher("/admin/edit-user.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/user-management?error=notfound");
            }
            return;
        } else if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userDAO.deleteUser(userId);
            response.sendRedirect(request.getContextPath() + "/admin/user-management");
            return;
        }

        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 10;

        java.util.List<User> users = userDAO.getAllUsers(page, pageSize);
        int totalItems = userDAO.getTotalUsers();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        request.setAttribute("users", users);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/admin/user-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            User user = new User(username, password, role, email);
            userDAO.addUser(user);
            response.sendRedirect(request.getContextPath() + "/admin/user-management");
        } else if ("update".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            User user = new User(userId, username, password, role, email, new Date());
            userDAO.updateUser(user);
            response.sendRedirect(request.getContextPath() + "/admin/user-management");
        }
    }
}