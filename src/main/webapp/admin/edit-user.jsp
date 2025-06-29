<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Người Dùng - Bánh Xèo Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; font-family: 'Nunito', sans-serif; }
        .content { margin-left: 250px; padding: 20px; }
        .alert { position: relative; }
        .alert .close-btn { position: absolute; right: 10px; top: 5px; cursor: pointer; }
    </style>
</head>
<body>
<div class="content">
    <h3 class="text-primary mb-4">Chỉnh Sửa Người Dùng</h3>

    <!-- Hiển thị thông báo -->
    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.message}
            <span class="close-btn" onclick="this.parentElement.style.display='none';">×</span>
        </div>
        <c:remove var="message" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.error}
            <span class="close-btn" onclick="this.parentElement.style.display='none';">×</span>
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/user-management" method="post" class="mb-4">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="userId" value="${editUser.userId}">
        <div class="row g-3">
            <div class="col-md-3"><input type="text" class="form-control" name="username" value="${editUser.username}" required></div>
            <div class="col-md-2"><input type="password" class="form-control" name="password" placeholder="Mật khẩu" required></div>
            <div class="col-md-3"><input type="email" class="form-control" name="email" value="${editUser.email}" required></div>
            <div class="col-md-2">
                <select name="role" class="form-select" required>
                    <option value="USER" ${editUser.role == 'USER' ? 'selected' : ''}>User</option>
                    <option value="ADMIN" ${editUser.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                </select>
            </div>
            <div class="col-md-2"><button type="submit" class="btn btn-primary w-100">Cập nhật</button></div>
        </div>
    </form>

    <a href="${pageContext.request.contextPath}/admin/user-management" class="btn btn-secondary">Quay lại</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Tự động ẩn thông báo sau 3 giây
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(() => alert.style.display = 'none', 500);
        });
    }, 3000);
</script>
</body>
</html>