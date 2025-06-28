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
import java.io.IOException;
import java.nio.file.Paths;
import java.io.File;

@WebServlet("/admin/menu-management")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB
public class MenuManagementServlet extends HttpServlet {
    private MenuDAO menuDAO = new MenuDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            String menuIdParam = request.getParameter("menuId");
            if (menuIdParam != null && !menuIdParam.isEmpty()) {
                try {
                    int menuId = Integer.parseInt(menuIdParam);
                    Menu menu = menuDAO.getMenuById(menuId);
                    if (menu != null) {
                        request.setAttribute("editMenu", menu);
                        request.getRequestDispatcher("/admin/edit-menu.jsp").forward(request, response);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/menu-management?error=notfound");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/admin/menu-management?error=invalidid");
                }
                return;
            }
        } else if ("delete".equals(action)) {
            String menuIdParam = request.getParameter("menuId");
            if (menuIdParam != null && !menuIdParam.isEmpty()) {
                try {
                    int menuId = Integer.parseInt(menuIdParam);
                    menuDAO.deleteMenu(menuId);
                } catch (NumberFormatException e) {
                    System.out.println("Lỗi: menuId không hợp lệ - " + e.getMessage());
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/menu-management");
            return;
        }

        String search = request.getParameter("search");
        String category = request.getParameter("category");
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 10;

        java.util.List<Menu> menus = menuDAO.getMenus(search, category, page, pageSize);
        int totalItems = menuDAO.getTotalMenus(search, category);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

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
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            Part filePart = request.getPart("image");
            String fileName = uploadImage(filePart);
            Menu menu = new Menu(name, price, fileName, 0, "");
            menuDAO.addMenu(menu);
            response.sendRedirect(request.getContextPath() + "/admin/menu-management");
        } else if ("update".equals(action)) {
            String menuIdParam = request.getParameter("menuId");
            if (menuIdParam != null && !menuIdParam.isEmpty()) {
                try {
                    int menuId = Integer.parseInt(menuIdParam);
                    String name = request.getParameter("name");
                    double price = Double.parseDouble(request.getParameter("price"));
                    Part filePart = request.getPart("image");
                    String fileName = filePart != null && filePart.getSize() > 0 ? uploadImage(filePart) : null;
                    Menu menu = new Menu(menuId, name, price, fileName != null ? fileName : menuDAO.getMenuById(menuId).getImageUrl(), 0, "");
                    menuDAO.updateMenu(menu);
                } catch (NumberFormatException | IOException e) {
                    System.out.println("Lỗi: Cập nhật menu thất bại - " + e.getMessage());
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/menu-management");
        }
    }

    private String uploadImage(Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) return null;
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        filePart.write(uploadPath + File.separator + fileName);
        System.out.println("Uploaded file to: " + uploadPath + File.separator + fileName);
        return fileName;
    }
}