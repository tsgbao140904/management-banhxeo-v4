document.querySelectorAll('.add-to-cart').forEach(button => {
    button.addEventListener('click', () => {
        const menuId = button.getAttribute('data-menu-id');
        const quantity = document.getElementById('quantity_' + menuId).value;
        fetch('${pageContext.request.contextPath}/user/add-to-cart', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'menuId=' + menuId + '&quantity=' + quantity
        }).then(response => {
            if (response.ok) alert('Thêm vào giỏ hàng thành công!');
            else alert('Thêm vào giỏ hàng thất bại!');
        });
    });
});

document.querySelectorAll('.like-btn').forEach(button => {
    button.addEventListener('click', () => {
        const menuId = button.getAttribute('data-menu-id');
        fetch('${pageContext.request.contextPath}/user/like-menu?menuId=' + menuId)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    button.innerHTML = '<i class="bi bi-heart-fill"></i> (' + data.likes + ')';
                    alert('Thả tim thành công!');
                }
            });
    });
});