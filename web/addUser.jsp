<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>

<%
    User getUser = (User) request.getAttribute("currentUser");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title><%= (getUser == null) ? "Thêm Người Dùng" : "Chỉnh Sửa Người Dùng" %></title>

        <style>
            body {
                background: linear-gradient(135deg, #e0eafc, #cfdef3);
                padding: 40px;
                color: #333;
            }
            .form-container {
                max-width: 900px;
                margin: 50px auto 0;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
                padding: 32px 48px;
                margin-bottom: 20px;
            }
            h2 {
                font-weight: 700;
                text-align: center;
                margin-bottom: 40px;
                color: #c0392b;
                font-size: 2rem;
            }
            form {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 24px 32px;
            }
            .form-group {
                display: flex;
                align-items: center;
            }
            label {
                width: 130px;
                font-weight: 600;
                font-size: 16px;
                margin-right: 12px;
                color: #333;
                text-align: right;
                white-space: nowrap;
            }
            input[type="text"],
            input[type="password"],
            input[type="email"],
            select {
                flex: 1;
                padding: 10px 14px;
                border-radius: 8px;
                border: 2px solid #ccc;
                font-size: 15px;
                font-weight: 500;
                color: #333;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }
            input[type="text"]:focus,
            input[type="password"]:focus,
            input[type="email"]:focus,
            select:focus {
                outline: none;
                border-color: #c0392b;
                box-shadow: 0 0 8px #c0392b;
            }
            button {
                margin-top: 40px;
                padding: 14px 0;
                grid-column: 1 / -1;
                background-color: #c0392b;
                color: #fff;
                font-size: 1.25rem;
                font-weight: 700;
                border: none;
                border-radius: 12px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            button:hover {
                background-color: #a62a23;
            }
            @media (max-width: 768px) {
                form {
                    grid-template-columns: 1fr;
                }
                .form-group {
                    flex-direction: column;
                    align-items: flex-start;
                }
                label {
                    width: 100%;
                    margin-bottom: 6px;
                    text-align: left;
                }
            }
            .back-button {
                display: inline-block;
                margin-bottom: 24px;
                font-weight: 600;
                color: #c0392b;
                text-decoration: none;
                font-size: 1rem;
            }
            .back-button:hover {
                text-decoration: underline;
            }
            .alert {
                padding: 15px 20px;
                border-radius: 8px;
                margin-bottom: 30px;
                font-weight: 600;
                font-size: 1rem;
                text-align: center;
                animation: fadeOut 1s ease forwards;
                animation-delay: 3.5s;
            }
            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .alert-error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            @keyframes fadeOut {
                to {
                    opacity: 0;
                    height: 0;
                    padding: 0 20px;
                    margin: 0;
                    overflow: hidden;
                }
            }
        </style>

        <script>
            window.onload = function () {
                var alertBox = document.getElementById('alertBox');
                if (alertBox) {
                    setTimeout(function () {
                        alertBox.style.display = 'none';
                    }, 4500);
                }
            };
        </script>

    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="form-container">
            <a href="management" class="btn btn-info back-button">← Quay lại</a>
            <h2><%= (getUser == null) ? "Thêm Người Dùng" : "Chỉnh Sửa Người Dùng" %></h2>

            <% if (message != null) { %>
            <div id="alertBox" class="alert alert-success"><%= message %></div>
            <% } else if (error != null) { %>
            <div id="alertBox" class="alert alert-error"><%= error %></div>
            <% } %>

            <form action="userServlet" method="post">
                <% if (getUser != null) { %>
                <input type="hidden" name="id" value="<%= getUser.getId() %>"/>
                <% } %>

                <div class="form-group">
                    <label for="fullName">Họ và Tên</label>
                    <input type="text" id="fullName" name="fullName" required value="<%= (getUser != null) ? getUser.getFullname() : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="userName">Tên Đăng Nhập</label>
                    <input type="text" id="userName" name="userName" required value="<%= (getUser != null) ? getUser.getUsername() : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="password">Mật Khẩu</label>
                    <input type="text" id="password" name="password" required value="<%= (getUser != null) ? getUser.getPassword() : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required value="<%= (getUser != null) ? getUser.getEmail() : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="phoneNumber">Số Điện Thoại</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" required value="<%= (getUser != null) ? getUser.getPhonenumber() : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="address">Địa Chỉ</label>
                    <input type="text" id="address" name="address" value="<%= (getUser != null) ? getUser.getAddress() : "" %>"/>
                </div>

                <div class="form-group">
                    <label for="status">Trạng Thái</label>
                    <select name="status" id="status" required>
                        <option value="1" <%= (getUser != null && "1".equals(getUser.getStatus())) ? "selected" : "" %>>Bật</option>
                        <option value="0" <%= (getUser != null && "0".equals(getUser.getStatus())) ? "selected" : "" %>>Tắt</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="roleId">Vai Trò</label>
                    <select name="roleId" id="roleId" required>
                        <option value="1" <%= (getUser != null && getUser.getRoleId() == 1) ? "selected" : "" %>>Admin</option>
                        <option value="2" <%= (getUser != null && getUser.getRoleId() == 2) ? "selected" : "" %>>Customer</option>
                    </select>
                </div>

                <button type="submit"><%= (getUser == null) ? "Thêm Người Dùng" : "Cập Nhật Người Dùng" %></button>
            </form>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>