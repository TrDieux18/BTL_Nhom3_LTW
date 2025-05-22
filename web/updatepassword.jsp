<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
    <head>

        <title>Thay đổi mật khẩu</title>

        <style>
            .password-strength {
                height: 6px;
                background-color: #e0e0e0;
                margin-bottom: 5px;
                border-radius: 5px;
                overflow: hidden;
            }
            .password-strength-bar {
                height: 100%;
                width: 0%;
                background-color: red;
                transition: width 0.3s ease;
            }
            .disabled-button {
                pointer-events: none;
                opacity: 0.5;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="container mt-5 mb-5">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3">
                    <div class="list-group">
                        <a href="${pageContext.request.contextPath}/orders?action=get&id=<%= user.getId() %>" class="list-group-item list-group-item-action active" style="background-color: #da3d33">Danh sách đơn hàng</a>
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

                <!-- Form đổi mật khẩu -->
                <div class="col-md-9">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Thay đổi mật khẩu</h5>
                        </div>
                        <div class="card-body">
                            <% if (request.getAttribute("error") != null) {%>
                            <div class="alert alert-danger"><%= request.getAttribute("error")%></div>
                            <% } else if (request.getAttribute("message") != null) {%>
                            <div class="alert alert-success"><%= request.getAttribute("message")%></div>
                            <% }%>
                            <form action="updatepassword" method="post">
                                <div class="mb-3">
                                    <label for="oldPassword" class="form-label">Mật khẩu cũ</label>
                                    <input type="password" class="form-control" id="oldPassword" placeholder="Nhập mật khẩu" name="oldPassword">
                                </div>

                                <div class="mb-3">
                                    <label for="newPassword" class="form-label">Mật khẩu mới</label>
                                    <input type="password" class="form-control" id="newPassword" placeholder="Nhập mật khẩu" name="newPassword">
                                </div>

                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                                    <input type="password" class="form-control" id="confirmPassword" placeholder="Nhập mật khẩu" name="confirmPassword">
                                </div>

                                <div class="mb-2">
                                    <label for="passwordStrength" class="form-label">Mật khẩu mạnh</label>
                                    <div class="password-strength">
                                        <div class="password-strength-bar" id="strengthBar"></div>
                                    </div>
                                    <small class="text-muted">Mật khẩu phải có ít nhất 6 ký tự và chứa ít nhất một ký hiệu hoặc số.</small>
                                </div>

                                <div class="d-flex justify-content-end">
                                    <button type="submit" id="saveBtn" class="btn btn-danger disabled-button" disabled>Lưu</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>


<%@include file="footer.jsp" %>
        <script src="./assets/JS/updatepassword.js"></script>
    </body>
</html>