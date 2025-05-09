
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Đăng kí</title>
</head>
<body>
<%--<jsp:include page=""/>--%>
<main class="register-container">

    <!-- Phần carousel -->
    <section class="carousel-section">
        <div class="carousel-container">
            <div
                    id="carouselExampleIndicators"
                    class="carousel slide"
                    data-ride="carousel"
                    data-interval="2000"
            >
                <ol class="carousel-indicators">
                    <li
                            data-target="#carouselExampleIndicators"
                            data-slide-to="0"
                            class="active"
                    ></li>
                    <li
                            data-target="#carouselExampleIndicators"
                            data-slide-to="1"
                    ></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="assets/images/b.jpg" alt="First slide" />
                    </div>
                    <div class="carousel-item">
                        <img src="assets/images/s.jpg" alt="Second slide" />
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Phần form đăng ký -->
    <section class="register-form">
        <form id="registerForm" method="post" action="/register">
            <h2>Đăng ký tài khoản</h2>
            <div class="form-group">
                <label for="fullname">Họ và tên</label>
                <input
                        id="fullname"
                        placeholder="Nhập họ và tên"
                />
                <div id="fullnameError" style="color: var(--color-red); display: none;" >Không được để trống Họ và Tên</div>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input
                        id="email"
                        placeholder="Nhập địa chỉ email"
                />
                <div id="emailError" style="color: var(--color-red); display: none;" >Không được để trống Email</div>
            </div>
            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input
                        id="phone"
                        placeholder="Nhập số điện thoại"
                />
                <div id="phoneError" style="color: var(--color-red); display: none;" >Không được để trống Số điện thoại</div>
            </div>

            <div class="form-group">
                <label for="username">Tên tài khoản</label>
                <input
                        type="text"
                        id="username"

                        placeholder="Nhập tên tài khoản"
                />
                <div id="usernameError" style="color: var(--color-red); display: none;" >Không được để trống Tên tài khoản</div>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input
                        id="password"
                        placeholder="Nhập mật khẩu"
                />
                <div id="passwordError" style="color: var(--color-red); display: none;" >Không được để trống Mật khẩu</div>
            </div>
            <div class="form-group">
                <label for="address">Địa chỉ</label>
                <input
                        id="address"
                        placeholder="Nhập địa chỉ"
                />
                <div id="addressError" style="color: var(--color-red); display: none;" >Không được để trống Địa chỉ</div>
            </div>

            <button style="width: 100%" type="submit" class="btn btn-danger">
                Đăng ký
            </button>

            <div class="login-link">
                Bạn đã có tài khoản? <a href="login.html">Đăng nhập ngay</a>
            </div>
        </form>
    </section>
</main>
<!-- <Script> -->
<script src="${pageContext.request.contextPath}/admin/js/register.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
