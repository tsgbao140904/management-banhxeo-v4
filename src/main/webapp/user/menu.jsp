<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Menu - Bánh Xèo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
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
                    <c:choose>
                        <c:when test="${not empty menu.imageUrl}">
                            <img src="${pageContext.request.contextPath}/${menu.imageUrl}" class="card-img-top" alt="${menu.name}"
                                 onerror="this.src='${pageContext.request.contextPath}/images/default.jpg'; this.onerror=null;">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/images/default.jpg" class="card-img-top" alt="Hình ảnh mặc định">
                        </c:otherwise>
                    </c:choose>
                    <div class="card-body">
                        <h5 class="card-title">${menu.name}</h5>
                        <p class="card-text">${menu.price} VNĐ</p>
                        <input type="number" class="form-control mb-2" id="quantity_${menu.menuId}" min="1" value="1" aria-label="Số lượng món ${menu.name}">
                        <button class="btn btn-primary add-to-cart" data-menu-id="${menu.menuId}" aria-label="Thêm món ${menu.name} vào giỏ hàng">Thêm vào giỏ</button>
                        <button class="btn btn-outline-danger like-btn" data-menu-id="${menu.menuId}" aria-label="Thích món ${menu.name}"><i class="bi bi-heart"></i> (${menu.likes})</button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <a href="${pageContext.request.contextPath}/user/cart" class="btn btn-success mt-3" aria-label="Xem giỏ hàng">Xem Giỏ Hàng</a>
</div>
<br>
<jsp:include page="/WEB-INF/jsp/footer.jsp" />
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

    document.querySelectorAll('.like-btn').forEach(button => {
        button.addEventListener('click', () => {
            const menuId = button.getAttribute('data-menu-id');
            fetch('${pageContext.request.contextPath}/user/like-menu?menuId=' + menuId)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        button.innerHTML = `<i class="bi bi-heart-fill"></i> (${data.likes})`;
                    } else {
                        alert(data.message);
                    }
                });
        });
    });
</script>
</body>
</html>