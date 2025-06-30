package com.managementbanhxeo.servlet.user;

import com.managementbanhxeo.dao.OrderDAO;
import com.managementbanhxeo.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/user/cart/delete")
public class CartDeleteServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            int userId = user.getUserId();
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            orderDAO.deleteCartItem(userId, menuId);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Xóa món khỏi giỏ hàng thành công!");
            System.out.println("Xóa món ID " + menuId + " khỏi giỏ hàng của user ID " + userId);
        } else {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Vui lòng đăng nhập!");
        }
    }
}