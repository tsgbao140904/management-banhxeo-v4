<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: 'Poppins', sans-serif; }
        .navbar { background-color: #2c3e50; }
        .navbar-brand, .navbar-nav .nav-link { color: #ecf0f1; }
        .navbar-nav .nav-link:hover { background-color: #34495e; border-radius: 5px; }
        .container { max-width: 1200px; margin-top: 30px; }
        .card { border: none; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); }
        .card:hover { transform: translateY(-5px); transition: transform 0.2s; }
        .total { font-size: 1.5rem; font-weight: bold; }
        .alert { position: relative; }
        .alert .close-btn { position: absolute; right: 10px; top: 5px; cursor: pointer; }
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/user/cart">Giỏ Hàng</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">Đăng Xuất</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <h2 class="mb-4 text-primary">Giỏ Hàng</h2>

    <!-- Hiển thị thông báo -->
    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.message}
            <span class="close-btn" onclick="this.parentElement.style.display='none';">&times;</span>
        </div>
        <c:remove var="message" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.error}
            <span class="close-btn" onclick="this.parentElement.style.display='none';">&times;</span>
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <div class="card">
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Tên Món</th>
                    <th>Số Lượng</th>
                    <th>Giá</th>
                    <th>Tổng</th>
                    <th>Hành Động</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="total" value="0" />
                <c:forEach var="item" items="${cartItems}">
                    <tr>
                        <td>${item.name}</td>
                        <td>${item.quantity}</td>
                        <td>${item.price} VNĐ</td>
                        <td>${item.quantity * item.price} VNĐ</td>
                        <c:set var="total" value="${total + (item.quantity * item.price)}" />
                        <td><button class="btn btn-danger btn-sm">Xóa</button></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="mb-3">
                <label for="note" class="form-label">Ghi chú (nếu có):</label>
                <textarea class="form-control" id="note" name="note" rows="3" placeholder="Nhập ghi chú cho đơn hàng (ví dụ: giao hàng nhanh, yêu cầu đặc biệt...)"></textarea>
            </div>
            <p class="total text-success">Tổng cộng: ${total} VNĐ</p>
            <button class="btn btn-success" onclick="checkout(${total})">Thanh Toán</button>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function checkout(total) {
        const note = document.getElementById('note').value;
        if (confirm('Xác nhận thanh toán ' + total + ' VNĐ?\nGhi chú: ' + (note || 'Không có'))) {
            fetch('${pageContext.request.contextPath}/user/checkout', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'total=' + total + '&note=' + encodeURIComponent(note)
            }).then(response => {
                if (response.ok) {
                    alert('Thanh toán thành công, chờ admin duyệt!');
                    window.location.href = '${pageContext.request.contextPath}/user/dashboard';
                } else {
                    alert('Thanh toán thất bại!');
                }
            });
        }
    }

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