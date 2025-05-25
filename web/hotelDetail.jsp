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
        <title>Chi tiết khách sạn</title>

        <style>
            textarea.form-control {

                resize: none;
            }

        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <section class="py-5">
            <div class="container">
                <div class="row">

                    <div class="col-md-6">
                        <div class="border rounded shadow-sm p-4 bg-white">
                            <c:choose>
                                <c:when test="${not empty error}">
                                    <div class="alert alert-danger text-center">${error}</div>
                                </c:when>
                                <c:when test="${not empty hotel}">
                                    <h1 class="fs-3 mb-4 text-dark" style="font-size: 25px;">${hotel.name}</h1>
                                    <div class="row">
                                        <div class="col-md-4 text-center">
                                            <img src="${hotel.image}" alt="${hotel.name}"
                                                 class="img-fluid rounded shadow-sm"
                                                 style="max-width: 100%; height: auto; max-height: 180px; object-fit: cover;" />
                                        </div>
                                        <div class="col-md-8">
                                            <h3 class="text-dark">Thông tin chi tiết</h3>
                                            <p><strong>Địa chỉ:</strong> ${hotel.address}</p>
                                            <p><strong>Giá mỗi đêm:</strong>
                                                <c:if test="${not empty hotel.price_per_night}">
                                                    <span class="text-danger fw-bold">
                                                        <fmt:formatNumber value="${hotel.price_per_night}" type="number" groupingUsed="true" maxFractionDigits="0" /> VNĐ
                                                    </span>
                                                </c:if>
                                                <c:if test="${empty hotel.price_per_night}">
                                                    <span class="text-danger">Giá không khả dụng</span>
                                                </c:if>
                                            </p>
                                            <p><strong>Số phòng:</strong> ${hotel.roomsAvailable}</p>
                                            <p><strong>Xếp hạng:</strong> 
                                                <c:choose>
                                                    <c:when test="${not empty hotel.rating}">${hotel.rating}★</c:when>
                                                    <c:otherwise>Chưa có xếp hạng</c:otherwise>
                                                </c:choose>
                                            </p>
                                            <p><strong>Thông tin liên hệ:</strong> 
                                                <c:choose>
                                                    <c:when test="${not empty hotel.contact_info}">${hotel.contact_info}</c:when>
                                                    <c:otherwise>Không có thông tin</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                    <form action="book" method="post" class="mt-4">
                                        <input type="hidden" name="hotelId" value="${hotel.id}" />
                                        <input type="hidden" name="hotelName" value="${hotel.name}" />
                                        <div class="mb-3">
                                            <div class="row">
                                                <div class="col-md-6 mb-3 mb-md-0">
                                                    <label for="checkIn" class="form-label">Ngày nhận phòng:</label>
                                                    <input type="date" id="checkIn" name="checkIn" class="form-control" value="<%= checkIn %>" required onchange="calculateTotal()" />
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="checkOut" class="form-label">Ngày trả phòng:</label>
                                                    <input type="date" id="checkOut" name="checkOut" class="form-control" required onchange="calculateTotal()" />
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
                                                    <label for="roomQuantity" class="form-label">Số lượng phòng:</label>
                                                    <input type="number" id="roomQuantity" name="roomQuantity" class="form-control" min="1" max="${hotel.roomsAvailable}" value="1" required onchange="calculateTotal()" />
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="status" class="form-label">Trạng thái:</label>
                                                    <select id="status" name="status" class="form-select form-select-custom" style="width: 100%; padding: 0.45rem; border-radius: 0.375rem; border: 1px solid #ced4da;">
                                                        <option value="Pending">Pending</option>
                                                        <option value="Confirmed">Confirmed</option>
                                                        <option value="Cancelled">Cancelled</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="note" class="form-label">Ghi chú:</label>
                                            <textarea id="note" name="note" rows="3" class="form-control" placeholder="Nhập ghi chú nếu có..."></textarea>
                                        </div>
                                        <div class="mb-3 total-price-container">
                                            <div class="price-display">
                                                <label class="form-label fw-bold">Tổng giá:</label>
                                                <div id="totalPrice" class="fs-5 text-danger">0 VNĐ/Đêm</div>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-danger w-100 fw-bold">Đặt Phòng</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning text-center">Không có thông tin khách sạn để hiển thị.</div>
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
                                    <div class="alert alert-warning text-center">Vui lòng đăng nhập để đặt khách sạn.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Mô tả khách sạn (nằm ngay dưới thông tin liên hệ) -->
                        <div class="description border rounded shadow-sm p-4 bg-white">
                            <h5 class="mb-3 text-dark" style="font-size: 25px;">Mô tả khách sạn</h5>
                            <c:choose>
                                <c:when test="${not empty hotel.description}">
                                    <p>${hotel.description}</p>
                                </c:when>
                                <c:otherwise>
                                    <p>Chưa có mô tả cho khách sạn này.</p>
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
                const pricePerNight = ${hotel.price_per_night != null ? hotel.price_per_night : 0};
                const checkIn = document.getElementById('checkIn').value;
                const checkOut = document.getElementById('checkOut').value;
                const roomQuantity = parseInt(document.getElementById('roomQuantity').value) || 1;
                let numberOfNights = 0;
                if (checkIn && checkOut) {
                    const checkInDate = new Date(checkIn);
                    const checkOutDate = new Date(checkOut);
                    if (checkOutDate > checkInDate) {
                        numberOfNights = (checkOutDate - checkInDate) / (1000 * 60 * 60 * 24);
                    }
                }
                const totalCost = pricePerNight * roomQuantity * numberOfNights;

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
