<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .login-container { max-width: 400px; margin-top: 100px; }
        .alert { position: relative; }
        .alert .close-btn { position: absolute; right: 10px; top: 5px; cursor: pointer; }
    </style>
</head>
<body>
<div class="container">
    <div class="login-container mx-auto p-4 border rounded shadow-sm bg-white">
        <h2 class="text-center mb-4 text-primary">Đăng Nhập</h2>

        <!-- Hiển thị thông báo -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.message}
                <span class="close-btn" onclick="this.parentElement.style.display='none';">&times;</span>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>
        <c:if test="${not empty requestScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${requestScope.error}
                <span class="close-btn" onclick="this.parentElement.style.display='none';">&times;</span>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Tên đăng nhập</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Đăng Nhập</button>
        </form>
        <p class="mt-3 text-center">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="text-success">Đăng ký</a></p>
    </div>
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