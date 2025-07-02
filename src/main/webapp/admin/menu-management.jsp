<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Menu - Bánh Xèo Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin.css">
</head>
<body>
<div class="sidebar">
    <div class="text-center mb-4"><h4>Bánh Xèo Admin</h4></div>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/order-management"><i class="fas fa-shopping-cart me-2"></i> Quản Lý Đơn Hàng</a>
    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/menu-management" aria-current="page"><i class="fas fa-utensils me-2"></i> Quản Lý Menu</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/report"><i class="fas fa-chart-line me-2"></i> Báo Cáo</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-management"><i class="fas fa-users me-2"></i> Quản Lý Người Dùng</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Đăng Xuất</a>
</div>
<div class="content">
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <h3 class="text-primary">Quản Lý Menu</h3>
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
    <form action="${pageContext.request.contextPath}/admin/menu-management" method="post" enctype="multipart/form-data" class="mb-4">
        <input type="hidden" name="action" value="add">
        <div class="row g-3">
            <div class="col-md-3"><input type="text" class="form-control" name="name" placeholder="Tên món" required></div>
            <div class="col-md-2"><input type="number" class="form-control" name="price" placeholder="Giá" step="1000" required></div>
            <div class="col-md-2">
                <select name="category" class="form-select" required>
                    <option value="">Chọn danh mục</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat}">${cat}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3"><input type="file" class="form-control" name="image"></div>
            <div class="col-md-2"><button type="submit" class="btn btn-primary w-100">Thêm món</button></div>
        </div>
    </form>
    <form action="${pageContext.request.contextPath}/admin/menu-management" method="post" class="mb-4">
        <input type="hidden" name="action" value="addCategory">
        <div class="row g-3">
            <div class="col-md-4"><input type="text" class="form-control" name="categoryName" placeholder="Tên danh mục mới" required></div>
            <div class="col-md-2"><button type="submit" class="btn btn-info w-100">Thêm danh mục</button></div>
        </div>
    </form>
    <form action="${pageContext.request.contextPath}/admin/menu-management" method="post" class="mb-4">
        <input type="hidden" name="action" value="deleteCategory">
        <div class="row g-3">
            <div class="col-md-4">
                <select name="categoryName" class="form-select" required>
                    <option value="">Chọn danh mục để xóa</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat}">${cat}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2"><button type="submit" class="btn btn-danger w-100">Xóa danh mục</button></div>
        </div>
    </form>
    <form action="${pageContext.request.contextPath}/admin/menu-management" method="get" class="mb-4">
        <div class="row g-3">
            <div class="col-md-4"><input type="text" class="form-control" name="search" placeholder="Tìm kiếm tên món" value="${search}"></div>
            <div class="col-md-3">
                <select name="category" class="form-select">
                    <option value="">Tất cả danh mục</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat}" ${category == cat ? 'selected' : ''}>${cat}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2"><button type="submit" class="btn btn-info w-100">Lọc</button></div>
        </div>
    </form>
    <table class="table table-striped table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên Món</th>
            <th>Giá</th>
            <th>Hình Ảnh</th>
            <th>Lượt Thích</th>
            <th>Danh Mục</th>
            <th>Ngày Tạo</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="menu" items="${menus}">
            <tr>
                <td>${menu.menuId}</td>
                <td>${menu.name}</td>
                <td>${menu.price} VNĐ</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty menu.imageUrl}">
                            <img src="${pageContext.request.contextPath}/${menu.imageUrl}" width="50" height="50" alt="Hình ảnh món ăn"
                                 onerror="this.src='${pageContext.request.contextPath}/images/default.jpg'; this.onerror=null;">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/images/default.jpg" width="50" height="50" alt="Hình ảnh mặc định">
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${menu.likes}</td>
                <td>${menu.category}</td>
                <td>${menu.createdAt}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/menu-management?action=edit&menuId=${menu.menuId}" class="btn btn-warning btn-sm">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/menu-management?action=delete&menuId=${menu.menuId}" class="btn btn-danger btn-sm delete-menu" data-menu-id="${menu.menuId}" data-menu-name="${menu.name}">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 1}">
                <li class="page-item"><a class="page-link" href="?page=${currentPage - 1}&search=${search}&category=${category}">Trước</a></li>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${currentPage == i ? 'active' : ''}"><a class="page-link" href="?page=${i}&search=${search}&category=${category}">${i}</a></li>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <li class="page-item"><a class="page-link" href="?page=${currentPage + 1}&search=${search}&category=${category}">Sau</a></li>
            </c:if>
        </ul>
    </nav>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    window.onload = function() {
        document.querySelectorAll('.delete-menu').forEach(button => {
            button.addEventListener('click', (e) => {
                e.preventDefault();
                const menuId = button.getAttribute('data-menu-id');
                const menuName = button.getAttribute('data-menu-name');
                if (confirm(`Bạn có chắc muốn xóa món "${menuName}"?`)) {
                    window.location.href = button.getAttribute('href');
                }
            });
        });
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