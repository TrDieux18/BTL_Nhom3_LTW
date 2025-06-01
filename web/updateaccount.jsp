<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Bán vé máy bay</title>
        <style>        
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
                        <a href="profile" class="list-group-item list-group-item-action active" style="background-color: #da3d33"><i class="fa fa-user me-2"></i>Hồ sơ</a>
                        <a href="password" class="list-group-item list-group-item-action"><i class="fa fa-key me-2"></i>Thay đổi mật khẩu</a>
                        <a href="logout" id="logoutBtn" class="list-group-item list-group-item-action"><i class="fa-solid fa-right-from-bracket"></i>Đăng xuất</a>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-9">
                    <!-- Success or Error Message -->
                    <%
                        String successMessage = (String) request.getAttribute("successMessage");
                        String errorMessage = (String) request.getAttribute("errorMessage");
                        if (successMessage != null) {
                    %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <%= successMessage %>                      
                    </div>
                    <%
                        } else if (errorMessage != null) {
                    %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <%= errorMessage %>                      
                    </div>
                    <%
                        }
                    %>
                    <script>
                    <% if (successMessage != null) { %>
                        let countdown = 3;
                        const countdownElement = document.getElementById('countdown');
                        const interval = setInterval(() => {
                            countdown--;
                            countdownElement.textContent = countdown;
                            if (countdown <= 0) {
                                clearInterval(interval);
                                window.location.href = 'profile';
                            }
                        }, 1000);
                    <% } %>
                    </script>   
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
                                    <label style="color: black">Email</label>
                                    <input type="email" class="form-control" id="email" value="<%= user != null ? user.getEmail() : ""%>" name="email" >
                                </div>
                                <div class="col-md-6">
                                    <label style="color: black">Số điện thoại di động</label>
                                    <input style="" type="tel" class="form-control" id="phonenumber" value="<%= user != null ? user.getPhonenumber() : ""%>" name="phonenumber">
                                    <br/>
                                </div>
                                
                                <div class="col-md-6 mt-3">
                                    <label style="color: black">Thành phố</label>
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
        <jsp:include page="footer.jsp" />
        <script src="assets/JS/navbar.js"></script>
        <script src="assets/JS/bootstrap.bundle.min.js"></script>
        <script src="assets/JS/jquery.slim.min.js"></script>
    </body>
</html>