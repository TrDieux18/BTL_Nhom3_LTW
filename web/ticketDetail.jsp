<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.*, java.time.format.*" %>

<%
    LocalDate today = LocalDate.now();
    LocalDateTime now = LocalDateTime.now();
    String checkIn = today.toString();
    String bookingDateTime = now.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="./assets/css/bootstrap.min.css" />
        <link rel="stylesheet" href="./assets/css/reset.min.css" />
        <link rel="stylesheet" href="./assets/css/base.css"/>
        <link rel="stylesheet" href="./assets/css/styles.css" />
        <link rel="stylesheet" href="./assets/font/fontawesome-free-6.7.2-web/fontawesome/css/all.min.css"/>
        <title>Chi tiết vé máy bay</title>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success text-center" role="alert" style="margin-bottom: 20px;">
                ${sessionScope.message}
            </div>
            <c:remove var="message" scope="session" />
        </c:if>
        <section class="py-5">
            <div class="container">
                <div class="row">





                    <div class="col-md-6">
                        <div class="border rounded shadow-sm p-4 bg-white">
                            <c:choose>
                                <c:when test="${not empty error}">
                                    <div class="alert alert-danger text-center">${error}</div>
                                </c:when>
                                <c:when test="${not empty ticket}">
                                    <h1 class="fs-3 mb-4 text-dark" style="font-size: 25px;">Tóm tắt chuyến bay</h1>
                                    <div class="row">
                                        <div class="col-md-4 text-center">
                                            <img src="${ticket.image}" alt="${ticket.destination}"
                                                 class="img-fluid rounded shadow-sm"
                                                 style="max-width: 100%; height: auto; max-height: 180px; object-fit: cover;" />
                                        </div>
                                        <div class="col-md-8">
                                            <h3 class="text-dark" style="font-size: 18px;">Từ ${ticket.origin} đến ${ticket.destination}</h3>
                                            <p><strong>Hãng máy bay:</strong> ${ticket.airline}</p>
                                            <p><strong>Hạng vé:</strong> ${ticket.type}</p>
                                            <p><strong>Giá vé:</strong>
                                                <c:if test="${not empty ticket.price}">
                                                    <span class="text-danger fw-bold">
                                                        <fmt:formatNumber value="${ticket.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ
                                                    </span>
                                                </c:if>
                                                <c:if test="${empty ticket.price}">
                                                    <span class="text-danger">Giá không khả dụng</span>
                                                </c:if>
                                            </p>
                                            <p><strong>Thời gian dự kiến:</strong> ${ticket.estimatedtime}</p>
                                        </div>
                                    </div>
                                    <form action="bookTicket" method="post" class="mt-4">
                                        <input type="hidden" name="ticketId" value="${ticket.id}" />
                                        <div class="mb-3">
                                            <div class="row">
                                                <div class="col-md-6 mb-3 mb-md-0">
                                                    <label for="departuretime" class="form-label">Khởi hành: </label>
                                                    <p> ${ticket.departuretime}</p>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="arrivetime" class="form-label">Đến:</label>
                                                    <p> ${ticket.arrivetime}</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="bookingDate" class="form-label">Ngày đặt:</label>
                                            <div id="bookingDate"><%= bookingDateTime %></div>
                                            <input type="hidden" name="bookingDate" value="<%= bookingDateTime.replace('/', '-') %>" />
                                        </div>
                                        <div class="mb-3">
                                            <div class="row">
                                                <div class="col-md-6 mb-3 mb-md-0">
                                                    <label for="ticketQuantity" class="form-label">Số lượng vé:</label>
                                                    <input type="number" id="ticketQuantity" name="ticketQuantity" class="form-control" min="1" max="9" value="1" required onchange="calculateTotal()" />
                                                </div>

                                            </div>
                                        </div>
                                        <div class="mb-3 total-price-container">
                                            <div class="price-display">
                                                <label class="form-label fw-bold">Tổng giá:</label>
                                                <div id="totalPrice" class="fs-5 text-danger">0 VNĐ</div>
                                            </div>
                                        </div>
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.user}">
                                                <!-- Nếu đã đăng nhập, hiển thị nút đặt vé bình thường -->
                                                <button type="submit" class="btn btn-danger w-100 fw-bold">Đặt Vé</button>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Nếu chưa đăng nhập, nút chuyển sang trang login -->
                                                <a href="log" class="btn btn-secondary w-100 fw-bold">Bạn phải đăng nhập để đặt vé</a>
                                            </c:otherwise>
                                        </c:choose>

                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning text-center">Không có thông tin vé máy bay để hiển thị.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Phần thông tin liên hệ -->
                    <div class="col-md-6">
                        <!-- Thông tin liên hệ -->
                        <div class="contact-info border rounded shadow-sm p-4 bg-white mb-4">
                            <h5 class="mb-4 text-dark" style="font-size: 25px;">Thông tin liên hệ</h5>
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Họ và Tên</label>
                                            <input type="text" class="form-control" value="${sessionScope.user.fullname}" disabled />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Số điện thoại di động</label>
                                            <input type="text" class="form-control" value="${sessionScope.user.phonenumber}" disabled />
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Email</label>
                                            <input type="email" class="form-control" value="${sessionScope.user.email}" disabled />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Địa chỉ</label>
                                            <input type="text" class="form-control" value="${sessionScope.user.address}" disabled />
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning text-center">Vui lòng đăng nhập để đặt vé máy bay.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>


                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp" />
        <script>
            function calculateTotal() {
                const pricePerTicket = ${ticket.price != null ? ticket.price: 0};
                const ticketQuantity = parseInt(document.getElementById('ticketQuantity').value) || 1;

                const totalCost = pricePerTicket * ticketQuantity;

                const formattedCost = new Intl.NumberFormat('vi-VN', {
                    style: 'decimal',
                    minimumFractionDigits: 0
                }).format(totalCost) + ' VNĐ';

                document.getElementById('totalPrice').textContent = formattedCost;

                const now = new Date();
                const formattedDate = now.toLocaleString('vi-VN', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                    hour12: false
                }).replace(/,/, '').replace(/\//g, '-');
                document.getElementById('bookingDate').textContent = formattedDate;
                document.querySelector('input[name="bookingDate"]').value = formattedDate;
            }
        </script>
    </body>
</html>
