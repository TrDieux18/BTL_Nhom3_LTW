<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Hồ sơ</title>
        <style>
            .avatar {
                width: 60px;
                height: 60px;
                font-size: 24px;
                border-radius: 50%;
                background-color: #dc3545;
                color: white;
                display: flex;
                justify-content: center;
                align-items: center;
            }         
            html, body {
                height: 100%;
                margin: 0;
            }
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            .container {
                flex: 1 0 auto;
            }
            footer {
                flex-shrink: 0;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="container mt-5 mb-5">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3">
                    <div class="list-group">
                        <a href="${pageContext.request.contextPath}/orders?action=get&type=all&id=<%= user.getId() %>" class="list-group-item list-group-item-action active" style="background-color: #da3d33"><i class="fa-solid fa-border-all"></i>Tất cả</a>
                        <a href="${pageContext.request.contextPath}/orders?action=get&type=flight&id=<%= user.getId() %>" class="list-group-item list-group-item-action "><i class="fa-solid fa-plane-up"></i>Vé máy bay</a>
                        <a href="${pageContext.request.contextPath}/orders?action=get&type=hotel&id=<%= user.getId() %>" class="list-group-item list-group-item-action "><i class="fa-solid fa-hotel"></i>Khách sạn</a>
                        <a href="account.jsp" class="list-group-item list-group-item-action active" style="background-color: #da3d33"><i class="fa fa-user me-2"></i>Hồ sơ</a>
                        <a href="updatepassword.jsp" class="list-group-item list-group-item-action"><i class="fa fa-key me-2"></i>Thay đổi mật khẩu</a>
                        <a href="logout" id="logoutBtn" class="list-group-item list-group-item-action"><i class="fa-solid fa-right-from-bracket"></i>Đăng xuất</a>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-9">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Hồ sơ của tôi</h5>
                            <a href="updateaccount.jsp" class="btn btn-outline-danger btn-sm">Chỉnh sửa hồ sơ</a>
                        </div>
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="avatar">
                                    <%= user != null ? user.getFullname().substring(0, 1).toUpperCase() : "?"%>
                                </div>
                                <div class="ms-3">
                                    <h6 class="mb-0 m-3" style="color: black"><%= user != null ? user.getFullname() : "Tên người dùng"%></h6>
                                </div>
                            </div>

                            <div class="row mb-2">
                                <div class="col-md-6">
                                    <label style="color: black">Email</label><br>
                                    <strong><%= user != null ? user.getEmail() : ""%></strong> <span class="text-success ms-2">✔ Đã xác minh</span>
                                </div>
                                <div class="col-md-6">
                                    <label style="color: black">Số điện thoại di động</label><br/>
                                    <div><%= user != null ? user.getPhonenumber(): ""%></div><br/>
                                </div>

                                <div class="col-md-6 mt-3">
                                    <label style="color: black">Thành phố</label><br>
                                    <strong><%= user != null ? user.getAddress(): ""%></strong>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp" %>
    </body>
</html>