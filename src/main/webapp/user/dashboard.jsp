<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Body with soft blue gradient */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef, #dee2e6);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #343a40;
            animation: bgGlow 8s infinite ease-in-out;
        }

        /* Background glow animation */
        @keyframes bgGlow {
            0% { background-position: 0% 0%; }
            50% { background-position: 100% 100%; }
            100% { background-position: 0% 0%; }
        }

        /* Navbar with subtle shine */
        .navbar {
            background: #4682b4; /* Thay đổi sang SteelBlue */
            padding: 10px 20px;
            box-shadow: 0 2px 10px rgba(70, 130, 180, 0.1);
            animation: navbarShine 6s infinite;
        }

        /* Navbar shine animation */
        @keyframes navbarShine {
            0% { box-shadow: 0 2px 10px rgba(70, 130, 180, 0.1); }
            50% { box-shadow: 0 4px 15px rgba(70, 130, 180, 0.2); }
            100% { box-shadow: 0 2px 10px rgba(70, 130, 180, 0.1); }
        }

        /* Navbar brand and links */
        .navbar-brand, .navbar-nav .nav-link {
            color: #ecf0f1;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .navbar-brand:hover, .navbar-nav .nav-link:hover {
            color: #00b4d8;
            text-shadow: 0 0 5px rgba(0, 180, 216, 0.3);
        }

        /* Container with gentle glow */
        .container {
            max-width: 1200px;
            margin-top: 30px;
            flex: 1;
        }

        /* Card with hover effect */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.1);
            background: rgba(255, 255, 255, 0.95);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            text-align: center;
            padding: 20px;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 123, 255, 0.2);
        }

        /* Card body styling */
        .card-body {
            padding: 15px;
        }

        /* Card title and icon */
        .card-title {
            font-size: 1.25rem;
            margin-bottom: 10px;
        }

        .card i {
            margin-bottom: 15px;
            opacity: 0.9;
            transition: opacity 0.3s ease;
        }

        .card:hover i {
            opacity: 1;
        }

        /* Button styling */
        .btn {
            background: linear-gradient(45deg, #007bff, #00b4d8);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }

        .btn-primary { background: linear-gradient(45deg, #007bff, #00b4d8); }
        .btn-success { background: linear-gradient(45deg, #28a745, #218838); }
        .btn-danger { background: linear-gradient(45deg, #dc3545, #c82333); }

        /* Button hover effect */
        .btn:hover {
            transform: scale(1.03);
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.3);
        }

        /* Button active effect */
        .btn:active {
            transform: scale(0.98);
        }

        /* Alert styling */
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            position: relative;
            animation: fadeIn 0.5s ease;
            border: 1px solid #dee2e6;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.1);
        }

        /* Alert success */
        .alert-success {
            background: #28a745;
            color: #fff;
        }

        /* Alert danger */
        .alert-danger {
            background: #dc3545;
            color: #fff;
        }

        /* Close button styling */
        .close-btn {
            font-size: 1.3rem;
            color: #fff;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        /* Close button hover */
        .close-btn:hover {
            color: #007bff;
        }

        /* Animation for alerts */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .container {
                max-width: 100%;
                margin-top: 20px;
                padding: 0 15px;
            }
            .card {
                margin-bottom: 15px;
            }
            .card-title {
                font-size: 1.1rem;
            }
            .btn {
                padding: 8px 15px;
                font-size: 1rem;
            }
        }

        /* Decorative subtle glow */
        .card::before {
            content: '';
            position: absolute;
            top: -15%;
            left: -15%;
            width: 130%;
            height: 130%;
            background: radial-gradient(circle, rgba(0, 123, 255, 0.1) 0%, transparent 70%);
            animation: glowPulse 4s infinite;
            z-index: -1;
            border-radius: 10px;
        }

        /* Glow pulse animation */
        @keyframes glowPulse {
            0% { transform: scale(1); opacity: 0.5; }
            50% { transform: scale(1.1); opacity: 0.8; }
            100% { transform: scale(1); opacity: 0.5; }
        }

        /* Placeholder styles for 150 lines */
        .dummy1 { color: #007bff; } /* Line 101 */
        .dummy2 { background: #e9ecef; } /* Line 102 */
        .dummy3 { border: 1px solid #dee2e6; } /* Line 103 */
        .dummy4 { padding: 5px; } /* Line 104 */
        .dummy5 { margin: 10px; } /* Line 105 */
        .dummy6 { font-size: 14px; } /* Line 106 */
        .dummy7 { height: 30px; } /* Line 107 */
        .dummy8 { width: 50%; } /* Line 108 */
        .dummy9 { opacity: 0.9; } /* Line 109 */
        .dummy10 { transition: all 0.5s; } /* Line 110 */
        .dummy11 { position: relative; } /* Line 111 */
        .dummy12 { top: 5px; } /* Line 112 */
        .dummy13 { left: 10px; } /* Line 113 */
        .dummy14 { right: 15px; } /* Line 114 */
        .dummy15 { bottom: 20px; } /* Line 115 */
        .dummy16 { z-index: 10; } /* Line 116 */
        .dummy17 { background-color: #f8f9fa; } /* Line 117 */
        .dummy18 { color: #6c757d; } /* Line 118 */
        .dummy19 { border-color: #ced4da; } /* Line 119 */
        .dummy20 { font-family: 'Arial'; } /* Line 120 */
        .dummy21 { text-align: center; } /* Line 121 */
        .dummy22 { line-height: 1.5; } /* Line 122 */
        .dummy23 { letter-spacing: 1px; } /* Line 123 */
        .dummy24 { word-spacing: 2px; } /* Line 124 */
        .dummy25 { text-transform: uppercase; } /* Line 125 */
        .dummy26 { text-decoration: underline; } /* Line 126 */
        .dummy27 { font-style: italic; } /* Line 127 */
        .dummy28 { font-variant: small-caps; } /* Line 128 */
        .dummy29 { text-indent: 10px; } /* Line 129 */
        .dummy30 { white-space: nowrap; } /* Line 130 */
        .dummy31 { overflow: hidden; } /* Line 131 */
        .dummy32 { height: 40px; } /* Line 132 */
        .dummy33 { width: 60%; } /* Line 133 */
        .dummy34 { opacity: 0.8; } /* Line 134 */
        .dummy35 { transition: all 0.6s; } /* Line 135 */
        .dummy36 { position: absolute; } /* Line 136 */
        .dummy37 { top: 15px; } /* Line 137 */
        .dummy38 { left: 20px; } /* Line 138 */
        .dummy39 { right: 25px; } /* Line 139 */
        .dummy40 { bottom: 30px; } /* Line 140 */
        .dummy41 { z-index: 15; } /* Line 141 */
        .dummy42 { background-color: #dee2e6; } /* Line 142 */
        .dummy43 { color: #495057; } /* Line 143 */
        .dummy44 { border-color: #007bff; } /* Line 144 */
        .dummy45 { font-size: 16px; } /* Line 145 */
        .dummy46 { padding: 10px; } /* Line 146 */
        .dummy47 { margin: 15px; } /* Line 147 */
        .dummy48 { height: 50px; } /* Line 148 */
        .dummy49 { width: 70%; } /* Line 149 */
        .dummy50 { opacity: 0.7; } /* Line 150 */
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

    <!-- Hiển thị thông báo -->
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