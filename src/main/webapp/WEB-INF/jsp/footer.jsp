<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- footer.jsp -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css"> <!-- Import file CSS footer -->
<footer class="footer">
    <div class="footer-content">
        <div class="footer-section about">
            <h5>Về Chúng Tôi</h5>
            <ul>
                <li><a href="${pageContext.request.contextPath}/user/about">Giới thiệu</a></li>
                <li><a href="${pageContext.request.contextPath}/user/contact">Liên hệ</a></li>
                <li><a href="${pageContext.request.contextPath}/user/policy">Chính sách</a></li>
            </ul>
        </div>
        <div class="footer-section support">
            <h5>Hỗ Trợ</h5>
            <ul>
                <li><a href="${pageContext.request.contextPath}/user/help">Trợ giúp</a></li>
                <li><a href="${pageContext.request.contextPath}/user/faq">Câu hỏi thường gặp</a></li>
                <li><a href="${pageContext.request.contextPath}/user/support">Hỗ trợ khách hàng</a></li>
            </ul>
        </div>
        <div class="footer-section contact">
            <h5>Liên Hệ</h5>
            <ul>
                <li><i class="fas fa-map-marker-alt"></i> 123 Đường Bánh Xèo, Quận 1, TP. HCM, Việt Nam</li>
                <li><i class="fas fa-phone"></i> <a href="">Phone : 0375608914</a></li>
                <li><i class="fas fa-envelope"></i> <a href="mailto:info@banhxeo.com">info@banhxeo.com</a></li>
                <li><i class="fas fa-globe"></i> <a href="https://maps.google.com" target="_blank">Xem bản đồ</a></li>
            </ul>
        </div>
        <div class="footer-section social">
            <h5>Kết Nối Với Chúng Tôi</h5>
            <div class="social-icons">
                <a href="https://facebook.com" target="_blank" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                <a href="https://youtube.com" target="_blank" title="YouTube"><i class="fab fa-youtube"></i></a>
                <a href="https://tiktok.com" target="_blank" title="TikTok"><i class="fab fa-tiktok"></i></a>
                <a href="https://instagram.com" target="_blank" title="Instagram"><i class="fab fa-instagram"></i></a>
                <a href="https://twitter.com" target="_blank" title="Twitter"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <p>© 2025 Bánh Xèo. All rights reserved. | Designed with <i class="fas fa-heart" style="color: #ff4d4d;"></i></p>
    </div>
</footer>