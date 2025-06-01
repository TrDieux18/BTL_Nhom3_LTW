<%-- 
    Document   : register
    Created on : May 15, 2025, 12:25:30 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./assets/css/bootstrap.min.css" />
    <title>Bán vé máy bay</title>
    <link rel="stylesheet" href="./assets/css/reset.min.css" />
    <link rel="stylesheet" href="./assets/css/base.css" />
    <link rel="stylesheet" href="./assets/css/styles.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link rel="stylesheet" href="./assets/font/fontawesome-free-6.7.2-web/fontawesome/css/all.min.css"/>
</head>
<body>
    <jsp:include page="navbar-w.jsp" />
    <jsp:include page="carousel.jsp" />
    
    <!--form đăng kí-->
    <section class="register-form">
            <form id="registerForm" method="post" action="register" novalidate>
                <h2>Đăng ký tài khoản</h2>                
                <div class="form-group">
                    <label for="fullname">Họ và tên</label>
                    <input id="fullname" name="fullname" type="text" placeholder="Nhập họ và tên" />
                    <div id="fullnameError" style="color: var(--color-red); display: none;"></div>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input id="email" name="email" type="text" placeholder="Nhập địa chỉ email"/>
                    <div id="emailError" style="color: var(--color-red); display: none;"></div>
                </div>
                <div class="form-group">
                    <label for="phonenumber">Số điện thoại</label>
                    <input id="phonenumber" name="phonenumber" type="tel" placeholder="Nhập số điện thoại" />
                    <div id="phonenumberError" style="color: var(--color-red); display: none;"></div>
                </div>
                <div class="form-group">
                    <label for="username">Tên tài khoản</label>
                    <input id="username" name="username" type="text" placeholder="Nhập tên tài khoản"/>
                    <div id="usernameError" style="color: var(--color-red); display: none;"></div>
                </div>
                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input id="password" name="password" type="password" placeholder="Nhập mật khẩu" />
                    <div id="passwordError" style="color: var(--color-red); display: none;"></div>
                </div>
                <div class="form-group">
                    <label for="address">Địa chỉ</label>
                    <input id="address" name="address" type="text" placeholder="Nhập địa chỉ"  />
                    <div id="addressError" style="color: var(--color-red); display: none;"></div>
                </div>
                <button style="width: 100%" type="submit" class="btn btn-danger">Đăng ký</button>
                <div class="login-link">Bạn đã có tài khoản? <a href="log">Đăng nhập ngay</a></div>
                <div class="login-link mt-3" style="font-size:16px;">Hoặc đăng nhập bằng</div>
                <div class="d-flex gap-3 flex-column w-100 " style="padding-top:20px; ">
                  <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:9999/BTLTest/loginn&response_type=code&client_id=923754187538-6vqp4klodso22mc6tf34nvmf2fcal3up.apps.googleusercontent.com&approval_prompt=force" class="btn btn-lg btn-light border">
                    <img src="https://cdn.airpaz.com/cdn-cgi/image/w=50,h=50,f=webp/forerunner-next/img/socmed/google_logo.png"alt="Google"style="width: 18px; height: 18px;vertical-align: middle;" />
                    <span class="ms-2 fs-6"style="font-size:16px;padding: 0px !important;color: black; ">Google</span>
                  </a>              
                </div>
            </form>
    </section>
    </main>   
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#registerForm').on('submit', function(e) {
                e.preventDefault();
                $('#fullnameError').hide().text('');
                $('#emailError').hide().text('');
                $('#phonenumberError').hide().text('');
                $('#usernameError').hide().text('');
                $('#passwordError').hide().text('');
                $('#addressError').hide().text('');  
                var formData = $(this).serialize();
                $.ajax({
                    url: 'register',
                    type: 'POST',
                    data: formData,
                    dataType: 'json',
                    success: function(response) {
                        if (response.status === 'success') {                        
                            window.location.href = 'log';
                        } else {                          
                            if (response.errors) {
                                if (response.errors.fullname) {
                                    $('#fullnameError').text(response.errors.fullname).show();
                                }
                                if (response.errors.email) {
                                    $('#emailError').text(response.errors.email).show();
                                }
                                if (response.errors.phonenumber) {
                                    $('#phonenumberError').text(response.errors.phonenumber).show();
                                }
                                if (response.errors.username) {
                                    $('#usernameError').text(response.errors.username).show();
                                }
                                if (response.errors.password) {
                                    $('#passwordError').text(response.errors.password).show();
                                }
                                if (response.errors.address) {
                                    $('#addressError').text(response.errors.address).show();
                                }
                            }
                        }
                    },
                    error: function() {
                        alert('Lỗi kết nối server. Vui lòng thử lại.');
                    }
                });
            });
        });
    </script>
</body>
</html>