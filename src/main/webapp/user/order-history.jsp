<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Mua Hàng - Bánh Xèo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <!-- Thêm Font Awesome cho các icon -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #343a40;
        }

        .navbar {
            background: #4682b4;
            padding: 10px 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand, .navbar-nav .nav-link {
            color: #ecf0f1;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .navbar-brand:hover, .navbar-nav .nav-link:hover {
            color: #00b4d8;
        }

        .container {
            max-width: 1200px;
            margin-top: 30px;
            flex: 1;
        }

        .table {
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .table th {
            background: #007bff;
            color: #fff;
            text-align: center;
            padding: 10px;
            font-weight: 600;
        }

        .table td {
            vertical-align: middle;
            text-align: center;
            padding: 10px;
            border-top: 1px solid #dee2e6;
        }

        .details-table {
            margin-top: 10px;
            font-size: 0.9em;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
        }

        .details-table td {
            padding: 5px;
            border: none;
        }

        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #dee2e6;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        .alert-success {
            background: #28a745;
            color: #fff;
        }

        .alert-danger {
            background: #dc3545;
            color: #fff;
        }

        .close-btn {
            font-size: 1.3rem;
            color: #fff;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .close-btn:hover {
            color: #007bff;
        }

        .pagination {
            justify-content: center;
        }

        .page-item .page-link {
            color: #007bff;
            background: #fff;
            border: 1px solid #dee2e6;
        }

        .page-item.active .page-link {
            background: #007bff;
            color: #fff;
            border-color: #007bff;
        }

        .page-item .page-link:hover {
            background: #e9ecef;
            color: #0056b3;
        }

        @media (max-width: 768px) {
            .container {
                max-width: 100%;
                margin-top: 20px;
                padding: 0 15px;
            }
            .table th, .table td {
                font-size: 0.9rem;
                padding: 8px;
            }
            .details-table {
                font-size: 0.8em;
            }
        }
    </style>
</head>
<br>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/user/dashboard">Bánh Xèo</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/menu">Xem Menu</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/user/order-history">Lịch Sử Mua Hàng</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/cart">Giỏ Hàng</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">Đăng Xuất</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <h2 class="text-center mb-4">Lịch Sử Mua Hàng</h2>

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

    <table class="table table-striped">
        <thead class="table-dark">
        <tr>
            <th>ID Đơn Hàng</th>
            <th>Chi Tiết Món</th>
            <th>Tổng Đơn</th>
            <th>Trạng Thái</th>
            <th>Ghi Chú</th>
            <th>Ngày Đặt</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td>${order.orderId}</td>
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
                <td>${order.status}</td>
                <td>${order.note}</td>
                <td>${order.orderDate}</td>
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
</br>
<jsp:include page="/WEB-INF/jsp/footer.jsp" /> <!-- Import footer.jsp -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
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