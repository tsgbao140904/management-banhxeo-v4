<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Báo Cáo Doanh Thu - Bánh Xèo Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { background-color: #f8f9fa; font-family: 'Nunito', sans-serif; }
        .sidebar { width: 250px; position: fixed; top: 0; left: 0; height: 100vh; background-color: #2c3e50; padding-top: 20px; }
        .sidebar a { color: #ecf0f1; padding: 10px 15px; text-decoration: none; display: block; }
        .sidebar a:hover, .sidebar a.active { background-color: #34495e; color: #ffffff; }
        .content { margin-left: 250px; padding: 20px; }
        .chart-container { margin: 20px 0; height: 300px; }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="text-center mb-4"><h4 class="text-white">Bánh Xèo Admin</h4></div>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/order-management"><i class="fas fa-shopping-cart me-2"></i> Quản Lý Đơn Hàng</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/menu-management"><i class="fas fa-utensils me-2"></i> Quản Lý Menu</a>
    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/report"><i class="fas fa-chart-line me-2"></i> Báo Cáo</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-management"><i class="fas fa-users me-2"></i> Quản Lý Người Dùng</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Đăng Xuất</a>
</div>
<div class="content">
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <h3 class="text-primary">Báo Cáo Doanh Thu</h3>
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
    <div class="mb-3">
        <form action="${pageContext.request.contextPath}/admin/report" method="get" class="row g-2">
            <div class="col-auto"><select name="month" class="form-select"><option value="0">Tất cả</option><c:forEach var="i" begin="1" end="12"><option value="${i}" ${param.month == i ? 'selected' : ''}>${i}</option></c:forEach></select></div>
            <div class="col-auto"><select name="year" class="form-select"><c:forEach var="y" begin="2023" end="2025"><option value="${y}" ${param.year == y ? 'selected' : ''}>${y}</option></c:forEach></select></div>
            <div class="col-auto"><button type="submit" class="btn btn-primary">Lọc</button></div>
        </form>
    </div>
    <div class="card mb-4 bg-success text-white">
        <div class="card-body"><fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" type="currency" currencySymbol=" VNĐ" /></div>
    </div>
    <div class="card chart-container"><canvas id="revenueChart"></canvas></div>
    <div class="card chart-container"><canvas id="profitLossChart"></canvas></div>
    <div class="card chart-container"><canvas id="expenseChart"></canvas></div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const revenueData = { labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6'], datasets: [{ label: 'Doanh Thu (VNĐ)', data: [<c:forEach var="rev" items="${monthlyRevenue}">${rev},</c:forEach>0], borderColor: '#2c3e50', borderWidth: 2, fill: false }] };
    const profitLossData = { labels: ['Lợi Nhuận', 'Lỗ'], datasets: [{ data: [<c:out value="${profitLoss.profit}" default="0" />, <c:out value="${profitLoss.loss}" default="0" />], backgroundColor: ['#3498db', '#e74c3c'] }] };
    const expenseData = { labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6'], datasets: [{ label: 'Thu (VNĐ)', data: [<c:forEach var="inc" items="${monthlyIncome}">${inc},</c:forEach>0], borderColor: '#3498db', fill: false }, { label: 'Chi (VNĐ)', data: [<c:forEach var="exp" items="${monthlyExpenses}">${exp},</c:forEach>0], borderColor: '#e74c3c', fill: false }] };
    new Chart(document.getElementById('revenueChart'), { type: 'bar', data: revenueData, options: { scales: { y: { beginAtZero: true } }, plugins: { legend: { display: true } } } });
    new Chart(document.getElementById('profitLossChart'), { type: 'pie', data: profitLossData, options: { plugins: { legend: { position: 'top' } } } });
    new Chart(document.getElementById('expenseChart'), { type: 'line', data: expenseData, options: { scales: { y: { beginAtZero: true } }, plugins: { legend: { display: true } } } });
</script>
</body>
</html>