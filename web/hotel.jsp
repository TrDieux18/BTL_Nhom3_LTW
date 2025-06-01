<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Danh sách khách sạn</title>
        <link rel="stylesheet" href="./assets/css/bootstrap.min.css" />
        <link rel="stylesheet" href="./assets/css/base.css"/>
        <link rel="stylesheet" href="./assets/css/styles.css" />
        <link rel="stylesheet" href="./assets/font/fontawesome-free-6.7.2-web/fontawesome/css/all.min.css"/>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <style> .top h2{
                margin-bottom: 10px;
                left: 295px;
                font-size: 40px;
                font-weight: bold;
                color: white;
            }

            .top h5{
               
                left: 295px;
                margin-top: 10px;
                margin-bottom: 20px;
                font-size: 20px;
                color: white;
            }</style>
        <section class="search-hotel">
            <div class="container py-5">
                <div class="top">
                    <h2>Tìm khách sạn giá rẻ cho bạn</h2>
                    <h5>Đặt phòng & Tận hưởng ưu đãi du lịch đến điểm đến của bạn</h5>
                </div>
                <div class="bg-white p-4 rounded shadow-sm border">
                    <%-- Hiển thị thông báo thành công nếu có --%>
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="container mt-3">
                            <div class="alert alert-success" role="alert" id="successAlert">
                                ${sessionScope.successMessage}
                            </div>
                            <c:remove var="successMessage" scope="session"/>
                        </div>
                    </c:if>
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const alert = document.getElementById('successAlert');
                            if (alert) {
                                setTimeout(function () {
                                    alert.style.display = 'none';
                                }, 2000);
                            }
                        });
                    </script>
                    <form action="hotelList" method="get" class="row g-3 align-items-end">
                        <!-- Địa chỉ -->
                        <div class="form-group col-md-4">
                            <label for="address">Địa chỉ</label>
                            <input
                                type="text"
                                class="form-control"
                                id="address"
                                name="address"
                                placeholder="VD: Nha Trang, Đà Nẵng..."
                                value="${param.address != null ? param.address : ''}"
                                />
                        </div>

                        <!-- Giá phòng tối đa -->
                        <div class="form-group col-md-4">
                            <label for="priceRange">Mức giá</label>
                            <select class="form-control" id="priceRange" name="priceRange">
                                <option value="" ${param.priceRange == null || param.priceRange == '' ? 'selected' : ''}>-- Tất cả --</option>
                                <option value="1" ${param.priceRange == '1' ? 'selected' : ''}>Dưới 1.000.000 VNĐ</option>
                                <option value="2" ${param.priceRange == '2' ? 'selected' : ''}>Từ 1.000.000 - 2.500.000 VNĐ</option>
                                <option value="3" ${param.priceRange == '3' ? 'selected' : ''}>Trên 2.500.000 VNĐ</option>
                            </select>
                        </div>

                        <!-- Số phòng còn trống -->
                        <div class="form-group col-md-3">
                            <label for="minRooms">Phòng trống tối thiểu</label>
                            <input
                                type="text"
                                class="form-control"
                                id="minRooms"
                                name="minRooms"
                                placeholder="VD: 5"
                                value="${param.minRooms != null ? param.minRooms : ''}"
                                />
                        </div>

                        <!-- Nút tìm kiếm -->
                        <div class="form-group col-md-1">
                            <button type="submit" class="btn btn-danger btn-block w-100">
                                Tìm
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <section class="container py-4">
            <h2 class="mb-4 text-dark" style="font-size: 25px;">Khách sạn đề xuất</h2>
            <div class="row g-3">
                <c:choose>
                    <c:when test="${not empty recommendedHotels}">
                        <c:forEach var="hotel" items="${recommendedHotels}">
                            <div class="col-12 col-sm-6 col-md-4 col-lg-3 box-hotel">
                                <a href="detail?hotelId=${hotel.id}" class="text-decoration-none">
                                    <div class="card h-100 hotel-card">
                                        <img src="${hotel.image}" alt="${hotel.name}" class="card-img-top" style="height:180px; object-fit:cover;" />
                                        <div class="card-body">
                                            <h5 class="card-title text-dark">${hotel.name}</h5>
                                            <p class="card-text text-secondary mb-1">Đánh giá: ${hotel.rating}★</p>
                                            <p class="text-danger fw-bold">
                                                <fmt:formatNumber value="${hotel.price_per_night}" type="currency" currencySymbol="VNĐ " />
                                            </p>
                                                                                        <!-- Thêm vào giỏ hàng -->
                                            <form action="addtocart" method="post">
                                                <input type="hidden" name="type" value="hotel" />
                                                <input type="hidden" name="id" value="${hotel.id}" />
                                                <input type="hidden" name="name" value="${hotel.name}" />
                                                <input type="hidden" name="price" value="${hotel.price_per_night}" />
                                                <input type="hidden" name="image" value="${hotel.image}" />
                                                <button type="submit" class="btn btn-sm btn-outline-danger w-100 mt-2">
                                                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center text-muted">Không có khách sạn đề xuất.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <h2 class="mb-4 text-dark" style="font-size: 25px; margin-top:40px;">Khách sạn ưu đãi</h2>
            <div class="row g-3">
                <c:choose>
                    <c:when test="${not empty discountHotels}">
                        <c:forEach var="hotel" items="${discountHotels}">
                            <div class="col-12 col-sm-6 col-md-4 col-lg-3 box-hotel">
                                <a href="detail?hotelId=${hotel.id}" class="text-decoration-none">
                                    <div class="card h-100 hotel-card">
                                        <img src="${hotel.image}" alt="${hotel.name}" class="card-img-top" style="height:180px; object-fit:cover;" />
                                        <div class="card-body">
                                            <h5 class="card-title text-dark">${hotel.name}</h5>
                                            <p class="card-text text-secondary mb-1">Đánh giá: ${hotel.rating}★</p>
                                            <p class="text-danger fw-bold">
                                                <fmt:formatNumber value="${hotel.price_per_night}" type="currency" currencySymbol="VNĐ " />
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center text-muted">Không có khách sạn ưu đãi.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <jsp:include page="footer.jsp" />
        <script src="./assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/JS/jquery.slim.min.js"></script>
    </body>
</html>