package com.managementbanhxeo.servlet.admin;

import com.managementbanhxeo.dao.MenuDAO;
import com.managementbanhxeo.model.Menu;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

@WebServlet("/admin/menu-management")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Giới hạn 5MB
public class MenuManagementServlet extends HttpServlet {
    private MenuDAO menuDAO = new MenuDAO();
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            Menu menu = menuDAO.getMenuById(menuId);
            if (menu != null) {
                Set<String> categories = menuDAO.getAllCategories();
                request.setAttribute("categories", categories);
                request.setAttribute("editMenu", menu);
                request.getRequestDispatcher("/admin/edit-menu.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("error", "Món ăn không tồn tại!");
                response.sendRedirect(request.getContextPath() + "/admin/menu-management");
            }
            return;
        } else if ("delete".equals(action)) {
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            try {
                menuDAO.deleteMenu(menuId);
                System.out.println("Đã xóa món ăn ID: " + menuId);
                request.getSession().setAttribute("message", "Xóa món ăn thành công!");
            } catch (Exception e) {
                System.out.println("Lỗi khi xóa món ăn ID " + menuId + ": " + e.getMessage());
                request.getSession().setAttribute("error", "Xóa món ăn thất bại: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/menu-management");
            return;
        }

        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 10;
        String search = request.getParameter("search");
        String category = request.getParameter("category");

        Set<String> categories = menuDAO.getAllCategories();
        List<Menu> menus = menuDAO.getMenus(search, category, page, pageSize);
        int totalItems = menuDAO.getTotalMenus(search, category);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        request.setAttribute("categories", categories);
        request.setAttribute("menus", menus);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("category", category);
        request.getRequestDispatcher("/admin/menu-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            try {
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                Part imagePart = request.getPart("image");
                String category = request.getParameter("category");
                String imageUrl = handleImageUpload(imagePart);
                Menu menu = new Menu(name, price, imageUrl, 0, category);
                menu.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));
                menuDAO.addMenu(menu);
                request.getSession().setAttribute("message", "Thêm món ăn thành công!");
            } catch (Exception e) {
                request.getSession().setAttribute("error", "Thêm món ăn thất bại: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/menu-management");
        } else if ("update".equals(action)) {
            try {
                int menuId = Integer.parseInt(request.getParameter("menuId"));
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                Part imagePart = request.getPart("image");
                String category = request.getParameter("category");
                Menu menu = menuDAO.getMenuById(menuId);
                if (menu != null) {
                    menu.setName(name);
                    menu.setPrice(price);
                    menu.setCategory(category);
                    if (imagePart != null && imagePart.getSize() > 0) {
                        String newImageUrl = handleImageUpload(imagePart);
                        menu.setImageUrl(newImageUrl);
                    }
                    menuDAO.updateMenu(menu);
                    request.getSession().setAttribute("message", "Cập nhật món ăn thành công!");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("error", "Cập nhật món ăn thất bại: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/menu-management");
        }
    }

    private String handleImageUpload(Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) return null;
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);
        return UPLOAD_DIR + "/" + fileName;
    }
}