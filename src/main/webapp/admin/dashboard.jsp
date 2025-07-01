<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Bánh Xèo Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        .card {
            margin-bottom: 20px;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.1);
            background: #fff;
        }

        .card-header {
            background: #4682b4;
            color: #ffffff;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            padding: 15px;
            font-weight: 600;
        }

        .card-body {
            padding: 20px;
            text-align: center;
        }

        .card-title {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .card-text {
            font-size: 1rem;
            color: #495057;
        }

        .chart-container {
            margin: 20px 0;
            height: 300px;
            position: relative;
            border-radius: 10px;
        }

        .dropdown button {
            background: #4682b4;
            border: none;
            color: #ffffff;
            padding: 8px 15px;
            transition: background-color 0.3s ease;
        }

        .dropdown button:hover {
            background: #5a9bd4;
        }

        .dropdown-menu {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .dropdown-item {
            color: #343a40;
            transition: background-color 0.3s ease;
        }

        .dropdown-item:hover {
            background: #e9ecef;
            color: #007bff;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
            }
            .content {
                margin-left: 200px;
                padding: 15px;
            }
            .card-title {
                font-size: 1.2rem;
            }
            .card-text {
                font-size: 0.9rem;
            }
            .chart-container {
                height: 250px;
            }
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="text-center mb-4"><h4 class="text-white">Bánh Xèo Admin</h4></div>
    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/order-management"><i class="fas fa-shopping-cart me-2"></i> Quản Lý Đơn Hàng</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/menu-management"><i class="fas fa-utensils me-2"></i> Quản Lý Menu</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/report"><i class="fas fa-chart-line me-2"></i> Báo Cáo</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-management"><i class="fas fa-users me-2"></i> Quản Lý Người Dùng</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Đăng Xuất</a>
</div>
<div class="content">
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <h3>Dashboard</h3>
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
    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-header">Tổng Đơn Hàng</div>
                <div class="card-body text-center"><h3 class="card-title">${totalOrders}</h3><p class="card-text">${orderGrowth}% so với tháng trước</p></div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-header">Tổng Doanh Thu</div>
                <div class="card-body text-center"><h3 class="card-title"><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol=" VNĐ" /></h3><p class="card-text">${revenueGrowth}% so với tháng trước</p></div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-header">Số Món Trong Menu</div>
                <div class="card-body text-center"><h3 class="card-title">${menuCount}</h3><p class="card-text">${newMenuCount} món mới</p></div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8">
            <div class="card chart-container"><canvas id="salesChart"></canvas></div>
        </div>
        <div class="col-md-4">
            <div class="card chart-container"><canvas id="categoryChart"></canvas></div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const salesData = { labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6'], datasets: [{ label: 'Doanh Thu (VNĐ)', data: [<c:forEach var="rev" items="${monthlyRevenue}">${rev},</c:forEach>0], borderColor: '#2c3e50', borderWidth: 2, fill: false }] };
    const categoryData = { labels: ['Bánh Xèo', 'Nước Uống', 'Khác'], datasets: [{ data: [<c:forEach var="cat" items="${categoryCounts}">${cat},</c:forEach>0], backgroundColor: ['#3498db', '#e74c3c', '#2ecc71'], borderWidth: 1 }] };
    new Chart(document.getElementById('salesChart'), { type: 'line', data: salesData, options: { scales: { y: { beginAtZero: true } }, plugins: { legend: { display: true } } } });
    new Chart(document.getElementById('categoryChart'), { type: 'pie', data: categoryData, options: { plugins: { legend: { position: 'right' } } } });
</script>
</body>
</html>