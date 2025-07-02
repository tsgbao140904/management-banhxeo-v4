<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng - Bánh Xèo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
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
                        <td>
                            <div class="quantity-controls">
                                <button class="btn btn-sm quantity-btn" data-menu-id="${item.menuId}" data-action="decrease" aria-label="Giảm số lượng món ${item.name}">-</button>
                                <input type="number" class="quantity-input" id="quantity-${item.menuId}" value="${item.quantity}" min="0" aria-label="Số lượng món ${item.name}">
                                <button class="btn btn-sm quantity-btn" data-menu-id="${item.menuId}" data-action="increase" aria-label="Tăng số lượng món ${item.name}">+</button>
                            </div>
                        </td>
                        <td>${item.price} VNĐ</td>
                        <td id="total-${item.menuId}">${item.quantity * item.price} VNĐ</td>
                        <c:set var="total" value="${total + (item.quantity * item.price)}" />
                        <td>
                            <button class="btn btn-danger btn-sm" onclick="deleteItem(${item.menuId})" aria-label="Xóa món ${item.name} khỏi giỏ hàng">Xóa</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="mb-3">
                <label for="note" class="form-label">Ghi chú (nếu có):</label>
                <textarea class="form-control" id="note" name="note" rows="3" placeholder="Nhập ghi chú cho đơn hàng (ví dụ: giao hàng nhanh, yêu cầu đặc biệt...)" aria-label="Ghi chú đơn hàng"></textarea>
            </div>
            <p class="total text-success" id="grand-total">Tổng cộng: ${total} VNĐ</p>
            <c:if test="${total <= 0}">
                <p class="text-danger">Giỏ hàng trống, không thể thanh toán!</p>
                <button class="btn btn-success" onclick="checkout()" disabled aria-label="Thanh toán (không khả dụng)">Thanh Toán</button>
            </c:if>
            <c:if test="${total > 0}">
                <button class="btn btn-success" onclick="checkout()" aria-label="Thanh toán đơn hàng">Thanh Toán</button>
            </c:if>
        </div>
    </div>
</div>
<br>
<jsp:include page="/WEB-INF/jsp/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let currentTotal = ${total};

    async function checkout() {
        const note = document.getElementById('note').value;
        if (confirm('Xác nhận thanh toán ' + currentTotal + ' VNĐ?\nGhi chú: ' + (note || 'Không có'))) {
            const response = await fetch('${pageContext.request.contextPath}/user/checkout', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'total=' + currentTotal + '¬e=' + encodeURIComponent(note)
            });
            if (response.ok) {
                alert('Thanh toán thành công, chờ admin duyệt!');
                window.location.href = '${pageContext.request.contextPath}/user/dashboard';
            } else {
                const text = await response.text();
                alert('Thanh toán thất bại: ' + text);
            }
        }
    }

    function deleteItem(menuId) {
        if (confirm('Xác nhận xóa món này khỏi giỏ hàng?')) {
            fetch('${pageContext.request.contextPath}/user/cart/delete', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'menuId=' + menuId
            }).then(response => {
                if (response.ok) {
                    response.text().then(text => {
                        alert(text);
                        location.reload();
                    });
                } else {
                    alert('Xóa thất bại!');
                }
            }).catch(error => alert('Lỗi kết nối: ' + error));
        }
    }

    async function updateQuantity(menuId, newQuantity) {
        try {
            const response = await fetch('${pageContext.request.contextPath}/user/cart', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=update&menuId=' + menuId + '&quantity=' + newQuantity
            });
            if (response.ok) {
                const newQty = await response.text();
                const quantityInput = document.getElementById('quantity-' + menuId);
                const totalElement = document.getElementById('total-' + menuId);
                const price = parseFloat(document.querySelector('#total-' + menuId).closest('tr').cells[2].textContent) || 0;
                quantityInput.value = newQty;
                totalElement.textContent = (newQty * price) + ' VNĐ';
                updateGrandTotal();
                if (parseInt(newQty) <= 0) {
                    deleteItem(menuId);
                }
            } else {
                alert('Cập nhật thất bại!');
                location.reload();
            }
        } catch (error) {
            alert('Lỗi kết nối: ' + error.message);
            location.reload();
        }
    }

    function debounce(func, delay) {
        let debounceTimeout;
        return function (...args) {
            clearTimeout(debounceTimeout);
            debounceTimeout = setTimeout(() => func.apply(this, args), delay);
        };
    }

    document.querySelectorAll('.quantity-btn').forEach(button => {
        button.addEventListener('click', debounce(async (e) => {
            const menuId = e.target.getAttribute('data-menu-id');
            const action = e.target.getAttribute('data-action');
            const quantityInput = document.getElementById('quantity-' + menuId);
            let newQuantity = parseInt(quantityInput.value) || 0;
            if (action === 'decrease') newQuantity--;
            else if (action === 'increase') newQuantity++;
            if (newQuantity >= 0) await updateQuantity(menuId, newQuantity);
            else quantityInput.value = 0;
        }, 50));
    });

    function updateGrandTotal() {
        let grandTotal = 0;
        document.querySelectorAll('[id^="total-"]').forEach(element => {
            grandTotal += parseFloat(element.textContent) || 0;
        });
        currentTotal = grandTotal;
        document.getElementById('grand-total').textContent = 'Tổng cộng: ' + grandTotal + ' VNĐ';
    }

    window.onload = function() {
        updateGrandTotal();
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.style.display = 'none', 500);
            });
        }, 3000);
    };
</script>
</body>
</html>