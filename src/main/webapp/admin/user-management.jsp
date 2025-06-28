<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Người Dùng - Bánh Xèo Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body { background-color: #f8f9fa; font-family: 'Nunito', sans-serif; }
        .sidebar { width: 250px; position: fixed; top: 0; left: 0; height: 100vh; background-color: #2c3e50; padding-top: 20px; }
        .sidebar a { color: #ecf0f1; padding: 10px 15px; text-decoration: none; display: block; }
        .sidebar a:hover, .sidebar a.active { background-color: #34495e; color: #ffffff; }
        .content { margin-left: 250px; padding: 20px; }
        .table { background: #ffffff; border-radius: 10px; }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="text-center mb-4"><h4 class="text-white">Bánh Xèo Admin</h4></div>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/order-management"><i class="fas fa-shopping-cart me-2"></i> Quản Lý Đơn Hàng</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/menu-management"><i class="fas fa-utensils me-2"></i> Quản Lý Menu</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/report"><i class="fas fa-chart-line me-2"></i> Báo Cáo</a>
    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/user-management"><i class="fas fa-users me-2"></i> Quản Lý Người Dùng</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Đăng Xuất</a>
</div>
<div class="content">
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <h3 class="text-primary">Quản Lý Người Dùng</h3>
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
    <form action="${pageContext.request.contextPath}/admin/user-management" method="post" class="mb-4">
        <input type="hidden" name="action" value="add">
        <div class="row g-3">
            <div class="col-md-3"><input type="text" class="form-control" name="username" placeholder="Tên đăng nhập" required></div>
            <div class="col-md-3"><input type="password" class="form-control" name="password" placeholder="Mật khẩu" required></div>
            <div class="col-md-3"><input type="email" class="form-control" name="email" placeholder="Email" required></div>
            <div class="col-md-2">
                <select name="role" class="form-select">
                    <option value="USER">Người dùng</option>
                    <option value="ADMIN">Admin</option>
                </select>
            </div>
            <div class="col-md-1"><button type="submit" class="btn btn-primary w-100">Thêm</button></div>
        </div>
    </form>
    <table class="table table-striped">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên Đăng Nhập</th>
            <th>Email</th>
            <th>Vai Trò</th>
            <th>Ngày Tạo</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.userId}</td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td>${user.role}</td>
                <td><fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" /></td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/user-management?action=edit&userId=${user.userId}" class="btn btn-warning btn-sm">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/user-management?action=delete&userId=${user.userId}" class="btn btn-danger btn-sm delete-user" data-user-id="${user.userId}" data-username="${user.username}">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 1}">
                <li class="page-item"><a class="page-link" href="?page=${currentPage - 1}">Trước</a></li>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${currentPage == i ? 'active' : ''}"><a class="page-link" href="?page=${i}">${i}</a></li>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <li class="page-item"><a class="page-link" href="?page=${currentPage + 1}">Sau</a></li>
            </c:if>
        </ul>
    </nav>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.querySelectorAll('.delete-user').forEach(button => {
        button.addEventListener('click', (e) => {
            e.preventDefault();
            const userId = button.getAttribute('data-user-id');
            const username = button.getAttribute('data-username');
            Swal.fire({
                title: 'Xác nhận xóa',
                text: `Bạn có chắc muốn xóa người dùng ${username}?`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Xóa',
                cancelButtonText: 'Hủy'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = button.getAttribute('href');
                }
            });
        });
    });
</script>
</body>
</html>