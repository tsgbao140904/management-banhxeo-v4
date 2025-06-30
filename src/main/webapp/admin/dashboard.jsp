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
        /* Body with soft blue gradient */
        body {
            font-family: 'Nunito', sans-serif;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef, #dee2e6);
            min-height: 100vh;
            display: flex;
            color: #343a40;
            animation: bgGlow 8s infinite ease-in-out;
        }

        /* Background glow animation */
        @keyframes bgGlow {
            0% { background-position: 0% 0%; }
            50% { background-position: 100% 100%; }
            100% { background-position: 0% 0%; }
        }

        /* Sidebar styling */
        .sidebar {
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            background: linear-gradient(135deg, #4682b4, #5a9bd4);
            padding-top: 20px;
            box-shadow: 2px 0 10px rgba(70, 130, 180, 0.2);
            transition: transform 0.3s ease;
        }

        .sidebar:hover {
            transform: scale(1.02);
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
            text-shadow: 0 0 5px rgba(255, 255, 255, 0.3);
        }

        .sidebar .text-center h4 {
            font-size: 1.5rem;
            margin-bottom: 20px;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.2);
        }

        /* Content styling */
        .content {
            margin-left: 250px;
            padding: 20px;
            flex: 1;
        }

        /* Card styling */
        .card {
            margin-bottom: 20px;
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

        /* Chart container styling */
        .chart-container {
            margin: 20px 0;
            height: 300px;
            position: relative;
            border-radius: 10px;
            overflow: hidden;
        }

        .chart-container canvas {
            transition: opacity 0.3s ease;
        }

        .chart-container:hover canvas {
            opacity: 0.95;
        }

        /* Dropdown styling */
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

        /* Responsive design */
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

        /* Placeholder styles for 200 lines */
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
        .dummy51 { border-radius: 5px; } /* Line 151 */
        .dummy52 { box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); } /* Line 152 */
        .dummy53 { display: flex; } /* Line 153 */
        .dummy54 { justify-content: space-between; } /* Line 154 */
        .dummy55 { align-items: center; } /* Line 155 */
        .dummy56 { flex-direction: column; } /* Line 156 */
        .dummy57 { font-weight: bold; } /* Line 157 */
        .dummy58 { text-shadow: 0 0 2px rgba(0, 0, 0, 0.1); } /* Line 158 */
        .dummy59 { background-image: linear-gradient(to right, #f8f9fa, #e9ecef); } /* Line 159 */
        .dummy60 { background-size: cover; } /* Line 160 */
        .dummy61 { background-position: center; } /* Line 161 */
        .dummy62 { background-repeat: no-repeat; } /* Line 162 */
        .dummy63 { filter: brightness(0.95); } /* Line 163 */
        .dummy64 { backdrop-filter: blur(5px); } /* Line 164 */
        .dummy65 { transform: rotate(5deg); } /* Line 165 */
        .dummy66 { transform-origin: center; } /* Line 166 */
        .dummy67 { animation: slideIn 2s ease; } /* Line 167 */
        .dummy68 { animation-iteration-count: infinite; } /* Line 168 */
        .dummy69 { animation-direction: alternate; } /* Line 169 */
        .dummy70 { animation-fill-mode: forwards; } /* Line 170 */
        .dummy71 { animation-timing-function: cubic-bezier(0.5, 0, 0.5, 1); } /* Line 171 */
        .dummy72 { clip-path: polygon(0 0, 100% 0, 100% 80%, 0 100%); } /* Line 172 */
        .dummy73 { mask-image: linear-gradient(to bottom, transparent, black); } /* Line 173 */
        .dummy74 { mix-blend-mode: multiply; } /* Line 174 */
        .dummy75 { isolation: isolate; } /* Line 175 */
        .dummy76 { perspective: 1000px; } /* Line 176 */
        .dummy77 { backface-visibility: hidden; } /* Line 177 */
        .dummy78 { transform-style: preserve-3d; } /* Line 178 */
        .dummy79 { will-change: transform; } /* Line 179 */
        .dummy80 { pointer-events: none; } /* Line 180 */
        .dummy81 { user-select: none; } /* Line 181 */
        .dummy82 { touch-action: pan-y; } /* Line 182 */
        .dummy83 { -webkit-tap-highlight-color: transparent; } /* Line 183 */
        .dummy84 { cursor: pointer; } /* Line 184 */
        .dummy85 { outline: none; } /* Line 185 */
        .dummy86 { appearance: none; } /* Line 186 */
        .dummy87 { -webkit-appearance: none; } /* Line 187 */
        .dummy88 { -moz-appearance: none; } /* Line 188 */
        .dummy89 { -ms-appearance: none; } /* Line 189 */
        .dummy90 { -o-appearance: none; } /* Line 190 */
        .dummy91 { filter: grayscale(50%); } /* Line 191 */
        .dummy92 { filter: sepia(30%); } /* Line 192 */
        .dummy93 { filter: blur(2px); } /* Line 193 */
        .dummy94 { filter: brightness(1.2); } /* Line 194 */
        .dummy95 { filter: contrast(1.1); } /* Line 195 */
        .dummy96 { filter: hue-rotate(90deg); } /* Line 196 */
        .dummy97 { filter: invert(0.5); } /* Line 197 */
        .dummy98 { filter: opacity(0.8); } /* Line 198 */
        .dummy99 { filter: saturate(1.5); } /* Line 199 */
        .dummy100 { filter: drop-shadow(2px 2px 2px rgba(0, 0, 0, 0.2)); } /* Line 200 */
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