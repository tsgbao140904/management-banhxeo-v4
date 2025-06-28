package com.managementbanhxeo.servlet.user;

import com.managementbanhxeo.dao.MenuDAO;
import com.managementbanhxeo.model.Menu;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.google.gson.Gson;

@WebServlet("/user/like-menu")
public class LikeMenuServlet extends HttpServlet {
    private MenuDAO menuDAO = new MenuDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        try {
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            Menu menu = menuDAO.getMenuById(menuId); // Sử dụng getMenuById thay vì getAllMenus để tối ưu
            if (menu != null) {
                int newLikes = menu.getLikes() + 1;
                menuDAO.updateLikes(menuId, newLikes);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write(new Gson().toJson(new Response(true, newLikes)));
                System.out.println("Thả tim thành công cho món ID " + menuId);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write(new Gson().toJson(new Response(false, 0)));
                System.out.println("Lỗi: Không tìm thấy món ID " + menuId);
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(new Gson().toJson(new Response(false, 0, "ID món không hợp lệ!")));
            System.out.println("Lỗi: ID món không hợp lệ - " + e.getMessage());
        }
    }

    private static class Response {
        private boolean success;
        private int likes;
        private String message;

        public Response(boolean success, int likes) {
            this.success = success;
            this.likes = likes;
            this.message = success ? "Thả tim thành công!" : "Không tìm thấy món!";
        }

        public Response(boolean success, int likes, String message) {
            this.success = success;
            this.likes = likes;
            this.message = message;
        }
    }
}