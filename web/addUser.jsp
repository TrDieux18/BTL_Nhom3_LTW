<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="model.User" %>

<%
    Object obj = request.getAttribute("getUser");
    User currentUser = null;
    if (obj != null) {
        currentUser = (User) obj;
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title><%= (currentUser == null) ? "Thêm Người Dùng" : "Sửa Người Dùng" %></title>


        <style> body {
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
            input[type="datetime-local"],
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
            input[type="datetime-local"]:focus,
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
            } </style>

    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="form-container">
            <a href="management" class="btn btn-info back-button">← Quay lại</a>

            <h2><%= (currentUser == null) ? "Thêm Người Dùng" : "Sửa Người Dùng" %></h2>

            <form action="userServlet" method="post" id="userForm" accept-charset="UTF-8">
                <input type="hidden" name="id" value="<%= (currentUser != null) ? currentUser.getId() : "" %>" />

                <div class="form-group">
                    <label for="fullName">Tên người dùng</label>
                    <input type="text" id="fullName" name="fullName" placeholder="Nhập tên khách sạn" required
                           value="<%= (currentUser != null) ? currentUser.getFullname() : "" %>" />
                </div>

                <div class="form-group">
                    <label for="userName">Tên tài khoản</label>
                    <input type="text" id="userName" name="userName" placeholder="Nhập tên khách sạn" required
                           value="<%= (currentUser != null) ? currentUser.getUsername() : "" %>" />
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input type="text" id="password" name="password" placeholder="Nhập tên khách sạn" required
                           value="<%= (currentUser != null) ? currentUser.getPassword() : "" %>" />
                </div>

                <div class="form-group">
                    <label for="address">Địa chỉ</label>
                    <input type="text" id="address" name="address" placeholder="Nhập địa chỉ" required
                           value="<%= (currentUser != null) ? currentUser.getAddress() : "" %>" />
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="text" id="email" name="email" placeholder="Nhập địa chỉ" required
                           value="<%= (currentUser != null) ? currentUser.getEmail() : "" %>" />
                </div>

                <div class="form-group">
                    <label for="phoneNumber">Số điện thoại </label>
                    <input type="text" id="phoneNumber" name="phoneNumber" placeholder="Nhập địa chỉ" required
                           value="<%= (currentUser != null) ? currentUser.getPhonenumber() : "" %>" />
                </div>

                <div class="form-group">
                    <label for="status">Trạng thái</label>
                    <select id="status" name="status" required>
                        <option value="" disabled <%= (currentUser == null) ? "selected" : "" %>>Chọn trạng thái</option>
                        <option value="1" <%= (currentUser != null && "1".equals(currentUser.getStatus())) ? "selected" : "" %>>Hoạt động</option>
                        <option value="0" <%= (currentUser != null && "0".equals(currentUser.getStatus())) ? "selected" : "" %>>Bị khóa</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="roleId">Vai trò</label>
                    <select id="roleId" name="roleId" required>
                        <option value="" disabled <%= (currentUser == null) ? "selected" : "" %>>Chọn vai trò</option>
                        <option value="1" <%= (currentUser != null && currentUser.getRoleId() == 1) ? "selected" : "" %>>ADMIN</option>
                        <option value="2" <%= (currentUser != null && currentUser.getRoleId() == 2) ? "selected" : "" %>>CUSTOMER</option>
                    </select>
                </div>

                <button type="submit"><%= (currentUser == null) ? "Thêm Người Dùng" : "Lưu" %></button>
            </form>
        </div>
    </body>
</html>
