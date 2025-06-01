<%-- 
    Document   : login.jsp
    Created on : 4 Jun, 2024, 4:48:55 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login page</title>
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/logins/login-6/assets/css/login-6.css">
    </head>
    
    
    <body class="bg-light">
        <jsp:include page="header.jsp" />
        <section class="search-hotel">
    <div class="container py-5" style="position: relative; text-align: center;">
        <img src="https://cdn.airpaz.com/cdn-cgi/image/w=2200,h=400,f=webp/forerunner-next/img/illustration/v2/hero/banner-help-desktop.png" 
             alt="alt" style="width: 100%; max-width: 1200px;height: 150px;"/>
        <h6 style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 28px; color: white; padding-bottom: 40px;">
            Lấy lại mật khẩu chỉ trong vài bước ^^
        </h6>
    </div>
</section>
        <section class="py-5">
    <div class="container">
        <div class="row justify-content-center align-items-center" style="min-height: 40vh;">
            <div class="col-12 col-md-9 col-lg-7 col-xl-6 col-xxl-5">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-3 p-md-4 p-xl-5">
                        <div class="row">
                            <div class="col-12">
                                <div class="mb-3">
                                    <h2>Nhập email bạn đã đăng ký tài khoản.</h2>
                                </div>
                            </div>
                        </div>
                        <form action="requestpassword" method="POST">
                            <div class="row gy-3 overflow-hidden">
                                <div class="col-12">
                                    <div class="form-floating mb-3">
                                        <input type="email" class="form-control"
                                               name="email" 
                                               id="email" placeholder="name@example.com" required>
                                        <label for="email" class="form-label">Email</label>
                                    </div>
                                </div>
                                <div class="text-danger small text-center" style="margin-top: 3px; margin-bottom: 3px;">
                                    ${mess}
                                </div>
                                <div class="text-success small text-center" style="margin-top: 3px; margin-bottom: 3px;">
                                    ${messs}
                                </div>
                                <div class="col-12">
                                    <div class="d-grid">                                               
                                        <button class="btn bsb-btn-2xl btn-danger" type="submit">Gửi</button>
                                    </div>
                                </div>
                            </div>
                        </form>                                
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>


        <jsp:include page="footer.jsp" />
    </body>
</html>