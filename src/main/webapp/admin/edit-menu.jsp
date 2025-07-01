<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Món Ăn - Bánh Xèo Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Nunito', sans-serif;
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            color: #343a40;
        }

        .sidebar {
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            background: #4682b4;
            padding-top: 20px;
            box-shadow: 2px 0 10px rgba(70, 130, 180, 0.2);
        }

        .sidebar a {
            color: #ecf0f1;
            padding: 10px 15px;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: #34495e;
            color: #ffffff;
        }

        .sidebar .text-center h4 {
            font-size: 1.5rem;
            margin-bottom: 20px;
        }

        .content {
            margin-left: 250px;
            padding: 20px;
            flex: 1;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
        }

        .form-control {
            border: 2px solid #ced4da;
            border-radius: 8px;
        }

        .form-control:focus {
            border-color: #007bff;
            outline: none;
        }

        .form-select {
            border: 2px solid #ced4da;
            border-radius: 8px;
        }

        .form-select:focus {
            border-color: #007bff;
            outline: none;
        }

        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #dee2e6;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.1);
        }

        .alert-success {
            background: #28a745;
            color: #fff;
        }

        .alert-danger {
            background: #dc3545;
            color: #fff;
        }

        .btn {
            padding: 10px 20px;
            font-weight: 600;
            border-radius: 8px;
        }

        .btn-success {
            background: #28a745;
            color: #fff;
        }

        .btn-success:hover {
            background: #218838;
        }

        .btn-secondary {
            background: #6c757d;
            color: #fff;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
            }
            .content {
                margin-left: 200px;
                padding: 15px;
            }
            .form-label {
                font-size: 0.9rem;
            }
            .form-control, .form-select {
                font-size: 0.9rem;
            }
            .btn {
                padding: 8px 15px;
                font-size: 0.9rem;
            }
        }
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
    <h3 class="text-primary mb-4">Sửa Thông Tin Món Ăn</h3>

    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="message" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/menu-management" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="menuId" value="${editMenu.menuId}">
        <div class="mb-3">
            <label for="name" class="form-label">Tên món ăn</label>
            <input type="text" class="form-control" id="name" name="name" value="${editMenu.name}" required>
        </div>
        <div class="mb-3">
            <label for="price" class="form-label">Giá (VNĐ)</label>
            <input type="number" class="form-control" id="price" name="price" value="${editMenu.price}" step="1000" required>
        </div>
        <div class="mb-3">
            <label for="image" class="form-label">Hình ảnh (tải lên nếu muốn thay đổi)</label>
            <input type="file" class="form-control" id="image" name="image">
            <small class="text-muted">Hình hiện tại: ${editMenu.imageUrl}</small>
        </div>
        <div class="mb-3">
            <label for="category" class="form-label">Danh mục</label>
            <select name="category" class="form-select" id="category" required>
                <option value="">Chọn danh mục</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat}" ${editMenu.category == cat ? 'selected' : ''}>${cat}</option>
                </c:forEach>
            </select>
        </div>
        <button type="submit" class="btn btn-success">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin/menu-management" class="btn btn-secondary">Hủy</a>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>