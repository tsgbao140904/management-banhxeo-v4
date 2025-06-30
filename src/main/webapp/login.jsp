<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Body with soft blue gradient */
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef, #dee2e6);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #343a40;
            animation: bgGlow 8s infinite ease-in-out;
        }

        /* Background glow animation */
        @keyframes bgGlow {
            0% { background-position: 0% 0%; }
            50% { background-position: 100% 100%; }
            100% { background-position: 0% 0%; }
        }

        /* Container with subtle shine */
        .login-container {
            max-width: 400px;
            width: 100%;
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 123, 255, 0.1);
            position: relative;
            overflow: hidden;
            border: 1px solid #ced4da;
            margin: 20px 0;
            animation: containerShine 6s infinite;
        }

        /* Container shine animation */
        @keyframes containerShine {
            0% { box-shadow: 0 0 15px rgba(0, 123, 255, 0.1); }
            50% { box-shadow: 0 0 20px rgba(0, 123, 255, 0.2); }
            100% { box-shadow: 0 0 15px rgba(0, 123, 255, 0.1); }
        }

        /* Header with soft blue */
        .login-container h2 {
            text-align: center;
            color: #007bff;
            font-size: 2rem;
            margin-bottom: 25px;
            text-shadow: 1px 1px 3px rgba(0, 123, 255, 0.1);
        }

        /* Form styling */
        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* Label with gentle highlight */
        .form-label {
            font-weight: 600;
            color: #495057;
            font-size: 1.1rem;
            margin-bottom: 5px;
            text-shadow: 0 0 2px rgba(0, 123, 255, 0.1);
        }

        /* Input with blue glow */
        .form-control {
            border: 2px solid #ced4da;
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 1rem;
            color: #343a40;
            background: rgba(255, 255, 255, 0.9);
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            height: 50px;
        }

        /* Input focus effect */
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.2);
            outline: none;
        }

        /* Placeholder styling */
        .form-control::placeholder {
            color: #6c757d;
            opacity: 0.8;
        }

        /* Button with blue gradient */
        .btn {
            background: linear-gradient(45deg, #007bff, #00b4d8);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-size: 1.2rem;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }

        /* Button hover effect */
        .btn:hover {
            transform: scale(1.03);
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.3);
        }

        /* Button active effect */
        .btn:active {
            transform: scale(0.98);
        }

        /* Link styling */
        a {
            color: #007bff;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        /* Link hover effect */
        a:hover {
            color: #0056b3;
            text-decoration: underline;
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
        @media (max-width: 480px) {
            .login-container {
                margin: 10px;
                padding: 20px;
            }
            .login-container h2 {
                font-size: 1.8rem;
            }
            .form-control {
                padding: 10px;
                height: 45px;
            }
            .btn {
                padding: 10px;
                font-size: 1.1rem;
            }
        }

        /* Decorative subtle glow */
        .login-container::after {
            content: '';
            position: absolute;
            top: -20%;
            left: -20%;
            width: 140%;
            height: 140%;
            background: radial-gradient(circle, rgba(0, 123, 255, 0.1) 0%, transparent 70%);
            animation: glowPulse 4s infinite;
            z-index: -1;
        }

        /* Glow pulse animation */
        @keyframes glowPulse {
            0% { transform: scale(1); opacity: 0.5; }
            50% { transform: scale(1.1); opacity: 0.8; }
            100% { transform: scale(1); opacity: 0.5; }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="login-container mx-auto p-4 border rounded shadow-sm bg-white">
        <h2 class="text-center mb-4 text-primary">Đăng Nhập</h2>

        <!-- Hiển thị thông báo -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.message}
                <span class="close-btn" onclick="this.parentElement.style.display='none';">×</span>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>
        <c:if test="${not empty requestScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${requestScope.error}
                <span class="close-btn" onclick="this.parentElement.style.display='none';">×</span>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Tên đăng nhập</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Đăng Nhập</button>
        </form>
        <p class="mt-3 text-center">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="text-success">Đăng ký</a></p>
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