<%-- 
    Document   : login
    Created on : May 14, 2025, 11:41:42 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <link
        rel="stylesheet"
        href="./assets/font/fontawesome-free-6.7.2-web/fontawesome/css/all.min.css"
    />
</head>
<body>
    <jsp:include page="navbar-w.jsp" />
    <jsp:include page="carousel.jsp" />
    <!--form đăng nhập -->
    <section class="login-form">
        <form id="loginForm" method="post" action="login">
            <h2>Đăng nhập tài khoản</h2>           
            <div class="form-group">
                <label for="username">Tên tài khoản</label>
                <input type="text" id="username" name="username" class="form-control" placeholder="Nhập tên tài khoản" required/>
            </div>            
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required/>
            </div>
            <% String error = request.getParameter("error"); %>
            <div id="alertError" class="alert alert-danger" style="display: <%= (error != null && error.equals("true")) ? "block" : "none" %>;" role="alert">
                Tài khoản hoặc mật khẩu không đúng.
            </div>
            <button style="width: 100%;" type="submit" class="btn btn-danger">Đăng nhập</button>
            <div class="login-link mt-3">Bạn chưa có tài khoản? <a href="register.jsp">Đăng kí ngay</a></div>
        </form>
    </section>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>