<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Menu - Bánh Xèo Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; font-family: 'Nunito', sans-serif; }
        .sidebar { width: 250px; position: fixed; top: 0; left: 0; height: 100vh; background-color: #2c3e50; padding-top: 20px; }
        .sidebar a { color: #ecf0f1; padding: 10px 15px; text-decoration: none; display: block; }
        .sidebar a:hover, .sidebar a.active { background-color: #34495e; color: #ffffff; }
        .content { margin-left: 250px; padding: 20px; }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="text-center mb-4"><h4 class="text-white">Bánh Xèo Admin</h4></div>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/order-management"><i class="fas fa-shopping-cart me-2"></i> Quản Lý Đơn Hàng</a>
    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/menu-management"><i class="fas fa-utensils me-2"></i> Quản Lý Menu</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/report"><i class="fas fa-chart-line me-2"></i> Báo Cáo</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-management"><i class="fas fa-users me-2"></i> Quản Lý Người Dùng</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Đăng Xuất</a>
</div>
<div class="content">
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <h3 class="text-primary">Quản Lý Menu</h3>
        <div class="dropdown">
            <button class="btn btn-secondary dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fas fa-user me-2"></i> Admin
            </button>
            <ul class="dropdown-menu" aria-labelledby="userDropdown">
                <li><a class="dropdown-item" href="#">Hồ sơ</a></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
            </ul>
        </div>
    </div>
    <form action="${pageContext.request.contextPath}/admin/menu-management" method="get" class="mb-4">
        <div class="row g-3">
            <div class="col-md-4"><input type="text" class="form-control" name="search" value="${param.search}" placeholder="Tìm theo tên món"></div>
            <div class="col-md-3">
                <select name="category" class="form-select">
                    <option value="">Tất cả danh mục</option>
                    <option value="Bánh Xèo" ${param.category == 'Bánh Xèo' ? 'selected' : ''}>Bánh Xèo</option>
                    <option value="Nước Uống" ${param.category == 'Nước Uống' ? 'selected' : ''}>Nước Uống</option>
                    <option value="Khác" ${param.category == 'Khác' ? 'selected' : ''}>Khác</option>
                </select>
            </div>
            <div class="col-md-2"><button type="submit" class="btn btn-primary w-100">Lọc</button></div>
        </div>
    </form>
    <form action="${pageContext.request.contextPath}/admin/menu-management" method="post" enctype="multipart/form-data" class="mb-4">
        <input type="hidden" name="action" value="add">
        <div class="row g-3">
            <div class="col-md-4"><input type="text" class="form-control" name="name" placeholder="Tên món" required></div>
            <div class="col-md-3"><input type="number" class="form-control" name="price" placeholder="Giá" step="1000" required></div>
            <div class="col-md-3"><input type="file" class="form-control" name="image" accept="image/*" required></div>
            <div class="col-md-2"><button type="submit" class="btn btn-primary w-100">Thêm Món</button></div>
        </div>
    </form>
    <table class="table table-striped">
        <thead class="table-dark">
        <tr>
            <th>Tên Món</th>
            <th>Giá</th>
            <th>Ảnh</th>
            <th>Lượt Thích</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="menu" items="${menus}">
            <tr>
                <td>${menu.name}</td>
                <td>${menu.price} VNĐ</td>
                <td><img src="${pageContext.request.contextPath}/uploads/${menu.imageUrl}" alt="${menu.name}" style="max-width: 100px;"></td>
                <td>${menu.likes}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/menu-management?action=edit&menuId=${menu.menuId}" class="btn btn-warning btn-sm">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/menu-management?action=delete&menuId=${menu.menuId}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa món ${menu.name}?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 1}">
                <li class="page-item"><a class="page-link" href="?page=${currentPage - 1}&search=${param.search}&category=${param.category}">Trước</a></li>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${currentPage == i ? 'active' : ''}"><a class="page-link" href="?page=${i}&search=${param.search}&category=${param.category}">${i}</a></li>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <li class="page-item"><a class="page-link" href="?page=${currentPage + 1}&search=${param.search}&category=${param.category}">Sau</a></li>
            </c:if>
        </ul>
    </nav>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>