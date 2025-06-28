<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { background-color: #f8f9fa; font-family: 'Poppins', sans-serif; }
        .navbar { background-color: #2c3e50; }
        .navbar-brand, .navbar-nav .nav-link { color: #ecf0f1; }
        .navbar-nav .nav-link:hover { background-color: #34495e; border-radius: 5px; }
        .container { max-width: 1200px; margin-top: 30px; }
        .card { border: none; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); }
        .card-img-top { height: 200px; object-fit: cover; border-top-left-radius: 10px; border-top-right-radius: 10px; }
        .card:hover { transform: translateY(-5px); transition: transform 0.2s; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/user/dashboard">Bánh Xèo</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/user/menu">Xem Menu</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/order-history">Lịch Sử Mua Hàng</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/cart">Giỏ Hàng</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">Đăng Xuất</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <h2 class="mb-4 text-primary">Menu</h2>
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="menu" items="${menus}">
            <div class="col">
                <div class="card h-100">
                    <img src="${pageContext.request.contextPath}/uploads/${menu.imageUrl}" class="card-img-top" alt="${menu.name}">
                    <div class="card-body">
                        <h5 class="card-title">${menu.name}</h5>
                        <p class="card-text">${menu.price} VNĐ</p>
                        <input type="number" class="form-control mb-2" id="quantity_${menu.menuId}" min="1" value="1">
                        <button class="btn btn-primary add-to-cart" data-menu-id="${menu.menuId}">Thêm vào giỏ</button>
                        <button class="btn btn-outline-danger like-btn" data-menu-id="${menu.menuId}"><i class="bi bi-heart"></i> (${menu.likes})</button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <a href="${pageContext.request.contextPath}/user/cart" class="btn btn-success mt-3">Xem Giỏ Hàng</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', () => {
            const menuId = button.getAttribute('data-menu-id');
            const quantity = document.getElementById('quantity_' + menuId).value;
            fetch('${pageContext.request.contextPath}/user/cart', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'menuId=' + menuId + '&quantity=' + quantity
            }).then(response => response.text()).then(data => alert(data));
        });
    });
</script>
</body>
</html>