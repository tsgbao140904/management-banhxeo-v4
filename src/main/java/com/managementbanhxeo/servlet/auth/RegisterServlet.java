package com.managementbanhxeo.servlet.auth;

import com.managementbanhxeo.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        boolean isRegistered = userDAO.registerUser(username, password, email);
        if (isRegistered) {
            request.getSession().setAttribute("message", "Đăng ký thành công, chuyển hướng đến đăng nhập!");
            System.out.println("Đăng ký thành công cho username: " + username);
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.getSession().setAttribute("error", "Đăng ký thất bại. Username hoặc email có thể đã tồn tại hoặc có lỗi!");
            response.sendRedirect(request.getContextPath() + "/register");
        }
    }
}