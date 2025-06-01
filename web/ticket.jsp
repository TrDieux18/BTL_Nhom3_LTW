<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Danh sách vé máy bay</title>
        <link rel="stylesheet" href="./assets/css/bootstrap.min.css" />
        <link rel="stylesheet" href="./assets/css/base.css"/>
        <link rel="stylesheet" href="./assets/css/styles.css" />
        <link rel="stylesheet" href="./assets/font/fontawesome-free-6.7.2-web/fontawesome/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    </head>
    <body>
        <jsp:include page="header.jsp" />
        <section class="search-ticket">
            <div class="container py-5">
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
                    <form action="ticketList" method="get" class="row g-3 align-items-end">
                        <div class="col-12 mb-2">
                            <h4 class="text-danger font-weight-bold" style="font-size: 25px;">
                                🔍 Tìm kiếm vé máy bay
                            </h4>
                        </div>

                        <!-- Điểm khởi hành -->
                        <div class="form-group col-md-3">
                            <label for="origin">Điểm khởi hành</label>
                            <input
                                type="text"
                                class="form-control"
                                id="origin"
                                name="origin"
                                placeholder="VD: Nha Trang, Đà Nẵng..."
                                value="${param.origin != null ? param.origin : ''}"
                                />
                        </div>

                        <!-- Điểm đến -->
                        <div class="form-group col-md-3">
                            <label for="destination">Điểm đến</label>
                            <input
                                type="text"
                                class="form-control"
                                id="destination"
                                name="destination"
                                placeholder="VD: Nha Trang, Đà Nẵng..."
                                value="${param.destination != null ? param.destination : ''}"
                                />
                        </div>

                        <!-- Ngày khởi hành -->
                        <div class="form-group col-md-2">
                            <label for="departuretime">Ngày khởi hành</label>
                            <input
                                type="date"
                                class="form-control"
                                id="departuretime"
                                name="departuretime"
                                placeholder="VD: Nha Trang, Đà Nẵng..."
                                value="${param.destination != null ? param.destination : ''}"
                                />
                        </div>

                        <!-- Hạng vé -->    

                        <div class="form-group col-md-3">
                            <label for="type">Hạng vé</label>
                            <select class="form-control" id="type" name="type">
                                <option value="" ${param.type == null || param.type == '' ? 'selected' : ''}>-- Hạng vé --</option>
                                <option value="1" ${param.type == '1' ? 'selected' : ''}>Phổ thông</option>
                                <option value="2" ${param.type == '2' ? 'selected' : ''}>Phổ thông đặc biệt</option>
                                <option value="3" ${param.type == '3' ? 'selected' : ''}>Thương gia</option>
                                <option value="4" ${param.type == '4' ? 'selected' : ''}>Hạng nhất</option>
                            </select>
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
            <h2 class="mb-4 text-dark" style="font-size: 25px;">Gợi ý vé máy bay độc quyền</h2>
            <div class="row g-3">
                <c:choose>
                    <c:when test="${not empty recommendedTickets}">
                        <c:forEach var="ticket" items="${recommendedTickets}">
                            <div class="col-12 col-sm-6 col-md-4 col-lg-3 box-ticket">
                                <a href="ticketDetail?ticketId=${ticket.id}" class="text-decoration-none">
                                    <div class="card h-100 hotel-card">
                                        <img src="${ticket.image}" alt="${ticket.destination}" class="card-img-top" style="height:180px; object-fit:cover;" />
                                        <div class="card-body">
                                            <h5 class="card-title text-dark">${ticket.origin}</h5>
                                            <p class="card-text text-secondary mb-1">
                                                <i class="fas fa-plane"></i>
                                                ${ticket.destination}</p>
                                            <p class="text-danger fw-bold">
                                                <fmt:formatNumber value="${ticket.price}" type="currency" currencySymbol="VNĐ " />
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center text-muted">Không có vé máy bay đề xuất.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <jsp:include page="footer.jsp" />
        <script src="./assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/JS/jquery.slim.min.js"></script>
    </body>
</html>