<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: 'Poppins', sans-serif; }
        .navbar { background-color: #2c3e50; }
        .navbar-brand, .navbar-nav .nav-link { color: #ecf0f1; }
        .navbar-nav .nav-link:hover { background-color: #34495e; border-radius: 5px; }
        .container { max-width: 1200px; margin-top: 30px; }
        .card { border: none; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); text-align: center; }
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/menu">Xem Menu</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/order-history">Lịch Sử Mua Hàng</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/cart">Giỏ Hàng</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">Đăng Xuất</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <h2 class="mb-4 text-primary">Dashboard Người Dùng</h2>
    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card bg-info text-white">
                <div class="card-body">
                    <i class="fas fa-utensils fa-2x mb-3 text-primary"></i>
                    <h5 class="card-title">Xem Menu</h5>
                    <a href="${pageContext.request.contextPath}/user/menu" class="btn btn-primary w-100">Đi tới</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card bg-warning text-white">
                <div class="card-body">
                    <i class="fas fa-history fa-2x mb-3 text-success"></i>
                    <h5 class="card-title">Lịch Sử Mua Hàng</h5>
                    <a href="${pageContext.request.contextPath}/user/order-history" class="btn btn-success w-100">Đi tới</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card bg-danger text-white">
                <div class="card-body">
                    <i class="fas fa-sign-out-alt fa-2x mb-3 text-danger"></i>
                    <h5 class="card-title">Đăng Xuất</h5>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger w-100">Đăng Xuất</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>