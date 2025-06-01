document.getElementById('changePasswordForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const oldPass = document.getElementById('oldPassword').value.trim();
    const newPass = document.getElementById('newPassword').value.trim();
    const confirmPass = document.getElementById('confirmPassword').value.trim();
    const msg = document.getElementById('changePassMsg');

    // Lấy user đang đăng nhập
    const userLogin = JSON.parse(localStorage.getItem('userLogin'));
    // Lấy danh sách users
    const users = JSON.parse(localStorage.getItem('users')) || [];

    if (!userLogin) {
        msg.textContent = "Bạn chưa đăng nhập!";
        msg.style.display = "block";
        return;
    }
    if (oldPass !== userLogin.password) {
        msg.textContent = "Mật khẩu cũ không đúng!";
        msg.style.display = "block";
        return;
    }
    if (newPass.length < 4) {
        msg.textContent = "Mật khẩu mới phải từ 4 ký tự!";
        msg.style.display = "block";
        return;
    }
    if (newPass !== confirmPass) {
        msg.textContent = "Nhập lại mật khẩu mới không khớp!";
        msg.style.display = "block";
        return;
    }

    // Cập nhật mật khẩu trong danh sách users
    const idx = users.findIndex(u => u.username === userLogin.username);
    if (idx !== -1) {
        users[idx].password = newPass;
        localStorage.setItem('users', JSON.stringify(users));
        // Cập nhật lại userLogin
        userLogin.password = newPass;
        localStorage.setItem('userLogin', JSON.stringify(userLogin));
        msg.style.color = "green";
        msg.textContent = "Đổi mật khẩu thành công!";
        msg.style.display = "block";
        setTimeout(() => {
            window.location.href = "index.html";
        }, 1500);
    } else {
        msg.textContent = "Có lỗi xảy ra!";
        msg.style.display = "block";
    }
});