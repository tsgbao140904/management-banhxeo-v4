<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Người Dùng - Bánh Xèo Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Nunito', sans-serif; padding: 20px; background-color: #f8f9fa; }
    </style>
</head>
<body>
<h3 class="text-primary">Sửa Thông Tin Người Dùng</h3>
<form action="${pageContext.request.contextPath}/admin/user-management" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="userId" value="${editUser.userId}">
    <div class="mb-3"><input type="text" class="form-control" name="username" value="${editUser.username}" required></div>
    <div class="mb-3"><input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu mới (nếu đổi)"></div>
    <div class="mb-3"><input type="email" class="form-control" name="email" value="${editUser.email}" required></div>
    <div class="mb-3">
        <select name="role" class="form-select">
            <option value="USER" ${editUser.role == 'USER' ? 'selected' : ''}>Người dùng</option>
            <option value="ADMIN" ${editUser.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
        </select>
    </div>
    <button type="submit" class="btn btn-success">Cập nhật</button>
    <a href="${pageContext.request.contextPath}/admin/user-management" class="btn btn-secondary">Hủy</a>
</form>
</body>
</html>