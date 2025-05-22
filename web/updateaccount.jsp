<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
    <head>

        <title>Bán vé máy bay</title>
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
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="container mt-5 mb-5">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3">
                    <div class="list-group">
                        <a href="${pageContext.request.contextPath}/orders?action=get&id=<%= user.getId() %>" class="list-group-item list-group-item-action active" style="background-color: #da3d33"> Danh sách đơn hàng</a>
                        <a href="${pageContext.request.contextPath}/orders?action=get&id=<%= user.getId() %>" class="list-group-item list-group-item-action">Tất cả</a>
                        <a href="#" class="list-group-item list-group-item-action">Vé máy bay</a>
                        <a href="#" class="list-group-item list-group-item-action">Khách sạn</a>
                        <a href="#" class="list-group-item list-group-item-action">Khác</a>
                        <a href="account.jsp" class="list-group-item list-group-item-action active" style="background-color: #da3d33"><i class="fa fa-user me-2"></i>Hồ sơ</a>
                        <a href="updatepassword.jsp" class="list-group-item list-group-item-action"><i class="fa fa-key me-2"></i>Thay đổi mật khẩu</a>
                        <a href="#" class="list-group-item list-group-item-action"><i class="fa fa-address-book me-2"></i>Danh sách liên lạc</a>
                        <a href="#" class="list-group-item list-group-item-action"><i class="fa fa-users me-2"></i>Danh sách du khách</a>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-9">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Hồ sơ của tôi</h5>
                        </div>
                        <form action="updateaccount" method="post">
                            <div class="card-body">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="avatar">
                                        <%= user != null ? user.getFullname().substring(0, 1).toUpperCase() : "?"%>
                                    </div>
                                    <div class="ms-3">
                                        <input type="text" class="form-control" id="fullname" value="<%= user != null ? user.getFullname() : "Tên người dùng"%>" name="fullname">
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div class="col-md-6">
                                        <label style="color: black">Email</label><br>
                                        <input type="email" class="form-control" id="email" value="<%= user != null ? user.getEmail() : ""%>" name="email" >
                                    </div>
                                    <div class="col-md-6">
                                        <label style="color: black">Số điện thoại di động</label><br/>
                                        <input type="tel" class="form-control" id="phonenumber" value="<%= user != null ? user.getPhonenumber() : ""%>" name="phonenumber">
                                        <br/>
                                    </div>

                                    <div class="col-md-6 mt-3">
                                        <label style="color: black">Thành phố</label><br>
                                        <input type="text" class="form-control" id="address" value="<%= user != null ? user.getAddress() : ""%>" name="address">
                                    </div>

                                </div>

                                <div class="d-flex justify-content-end">
                                    <button type="submit" class="btn btn-outline-danger btn-sm" onclick="updateAccount()">Lưu thay đổi</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="./assets/JS/updateaccount.js"></script>
        <%@include file="footer.jsp" %>
    </body>
</html>