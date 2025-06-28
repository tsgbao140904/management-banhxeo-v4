<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Món Ăn - Bánh Xèo Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Nunito', sans-serif; padding: 20px; background-color: #f8f9fa; }
    </style>
</head>
<body>
<h3 class="text-primary">Sửa Thông Tin Món Ăn</h3>
<form action="${pageContext.request.contextPath}/admin/menu-management" method="post" enctype="multipart/form-data">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="menuId" value="${editMenu.menuId}">
    <div class="mb-3"><input type="text" class="form-control" name="name" value="${editMenu.name}" required></div>
    <div class="mb-3"><input type="number" class="form-control" name="price" value="${editMenu.price}" step="1000" required></div>
    <div class="mb-3"><input type="file" class="form-control" name="image"></div>
    <button type="submit" class="btn btn-success">Cập nhật</button>
    <a href="${pageContext.request.contextPath}/admin/menu-management" class="btn btn-secondary">Hủy</a>
</form>
</body>
</html>