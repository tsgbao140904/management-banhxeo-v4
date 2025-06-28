<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Đơn Hàng - Bánh Xèo Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; font-family: 'Nunito', sans-serif; }
        .sidebar { width: 250px; position: fixed; top: 0; left: 0; height: 100vh; background-color: #2c3e50; padding-top: 20px; }
        .sidebar a { color: #ecf0f1; padding: 10px 15px; text-decoration: none; display: block; }
        .sidebar a:hover, .sidebar a.active { background-color: #34495e; color: #ffffff; }
        .content { margin-left: 250px; padding: 20px; }
        .details-table { margin-top: 10px; font-size: 0.9em; }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="text-center mb-4"><h4 class="text-white">Bánh Xèo Admin</h4></div>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a>
    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/order-management"><i class="fas fa-shopping-cart me-2"></i> Quản Lý Đơn Hàng</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/menu-management"><i class="fas fa-utensils me-2"></i> Quản Lý Menu</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/report"><i class="fas fa-chart-line me-2"></i> Báo Cáo</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-management"><i class="fas fa-users me-2"></i> Quản Lý Người Dùng</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Đăng Xuất</a>
</div>

<div class="content">
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <h3 class="text-primary">Quản Lý Đơn Hàng</h3>
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

    <table class="table table-striped table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID Đơn Hàng</th>
            <th>Tên Tài Khoản</th>
            <th>Chi Tiết Món</th>
            <th>Tổng Đơn</th>
            <th>Trạng Thái</th>
            <th>Ghi Chú</th>
            <th>Ngày Đặt</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td>${order.orderId}</td>
                <td>${order.username}</td>
                <td>
                    <table class="table details-table">
                        <c:forEach var="detail" items="${order.orderDetails}">
                            <tr>
                                <td>${detail.menu.name}</td>
                                <td>${detail.quantity} x ${detail.price} VNĐ = ${detail.quantity * detail.price} VNĐ</td>
                            </tr>
                        </c:forEach>
                    </table>
                </td>
                <td><strong>${order.totalAmount}</strong> VNĐ</td>
                <td>
                    <select class="form-select status-update" data-order-id="${order.orderId}">
                        <option value="CHOXACNHAN" ${order.status == 'CHOXACNHAN' ? 'selected' : ''}>Chờ Xác Nhận</option>
                        <option value="XACNHAN" ${order.status == 'XACNHAN' ? 'selected' : ''}>Xác Nhận</option>
                        <option value="TUCHI" ${order.status == 'TUCHI' ? 'selected' : ''}>Từ Chối</option>
                    </select>
                </td>
                <td>${order.note}</td>
                <td>${order.orderDate}</td>
                <td></td>
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
    document.querySelectorAll('.status-update').forEach(select => {
        select.addEventListener('change', () => {
            if (confirm('Bạn có chắc chắn muốn cập nhật trạng thái?')) {
                const orderId = select.getAttribute('data-order-id');
                const status = select.value;
                fetch('${pageContext.request.contextPath}/admin/order-management', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'action=updateStatus&orderId=' + orderId + '&status=' + status
                }).then(response => {
                    if (response.ok) {
                        alert('Cập nhật trạng thái thành công!');
                        location.reload();
                    } else {
                        alert('Cập nhật thất bại!');
                    }
                });
            }
        });
    });
</script>
</body>
</html>