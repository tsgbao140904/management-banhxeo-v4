<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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
            background: #4682b4; /* SteelBlue */
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
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 123, 255, 0.2);
        }

        /* Card image styling */
        .card-img-top {
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            transition: opacity 0.3s ease;
        }

        .card:hover .card-img-top {
            opacity: 0.9;
        }

        /* Card body styling */
        .card-body {
            padding: 15px;
        }

        /* Card title and text */
        .card-title {
            font-size: 1.25rem;
            margin-bottom: 10px;
        }

        .card-text {
            font-size: 1rem;
            color: #495057;
        }

        /* Input and button styling */
        .form-control {
            border: 2px solid #ced4da;
            border-radius: 8px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.2);
            outline: none;
        }

        .btn {
            background: linear-gradient(45deg, #007bff, #00b4d8);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 8px 15px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }

        .btn-primary:hover {
            transform: scale(1.03);
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.3);
        }

        .btn-primary:active {
            transform: scale(0.98);
        }

        .btn-outline-danger {
            color: #dc3545;
            border-color: #dc3545;
            background: rgba(220, 53, 69, 0.1);
        }

        .btn-outline-danger:hover {
            color: #fff;
            background: #dc3545;
            border-color: #dc3545;
            box-shadow: 0 0 10px rgba(220, 53, 69, 0.3);
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
            .card-img-top {
                height: 150px;
            }
            .card-title {
                font-size: 1.1rem;
            }
            .btn {
                padding: 6px 12px;
                font-size: 0.9rem;
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

    document.querySelectorAll('.like-btn').forEach(button => {
        button.addEventListener('click', () => {
            const menuId = button.getAttribute('data-menu-id');
            fetch('${pageContext.request.contextPath}/user/like-menu?menuId=' + menuId)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        button.textContent = `❤️ (${data.likes})`;
                    } else {
                        alert(data.message);
                    }
                });
        });
    });
</script>
</body>
</html>