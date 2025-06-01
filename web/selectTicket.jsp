<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="model.Ticket" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Chọn vé máy bay - 
            <c:choose>
                <c:when test="${not empty origin}">${fn:escapeXml(origin)}</c:when>
                <c:otherwise>--</c:otherwise>
            </c:choose>
            → 
            <c:choose>
                <c:when test="${not empty destination}">${fn:escapeXml(destination)}</c:when>
                <c:otherwise>--</c:otherwise>
            </c:choose>
        </title>
        <link rel="stylesheet" href="./assets/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body style="background:#f5f7fa;">
        <jsp:include page="header.jsp" />
        <div class="container py-4" id="selectTicket">
            <div class="row mb-4">
                <div class="col">
                    <h2 class="font-weight-bold text-danger d-flex align-items-center" style="font-size:2rem">
                        <i class="fas fa-plane mr-2"></i>
                        <span>
                            <c:choose>
                                <c:when test="${not empty origin}">${fn:escapeXml(origin)}</c:when>
                                <c:otherwise>--</c:otherwise>
                            </c:choose>
                        </span>
                        <span class="mx-2" style="font-size:1.7rem;">
                            <i class="fa fa-arrow-right mx-1"></i>
                        </span>
                        <span>
                            <c:choose>
                                <c:when test="${not empty destination}">${fn:escapeXml(destination)}</c:when>
                                <c:otherwise>--</c:otherwise>
                            </c:choose>
                        </span>
                    </h2>
                    <p class="text-muted lead" style="font-size:1.1rem">
                        Tìm thấy <span class="font-weight-bold text-dark">${ticketList != null ? ticketList.size() : 0}</span> chuyến bay cho chặng này.
                    </p>
                </div>
            </div>

            <div class="row">
                <!-- Bộ lọc trái -->
                <div class="col-md-3 mb-3">
                    <div class="card shadow-sm border-0 rounded-lg">
                        <div class="card-body">
                            <h5 class="card-title text-danger font-weight-bold mb-4">Bộ lọc tìm kiếm</h5>
                            <form id="filterForm" action="selectticket" method="get">
                                <input type="hidden" name="origin" value="${origin}" />
                                <input type="hidden" name="destination" value="${destination}" />
                                <input type="hidden" name="sortBy" id="sortByInput" value="${selectedSortBy}" />

                                <!-- Slider giá -->
                                <div class="mb-4">
                                    <label class="font-weight-bold mb-1" for="priceRange">Giá tối đa</label>
                                    <input type="range" class="custom-range" min="500000" max="3500000" step="100000" id="priceRange" name="maxPrice" value="${selectedMaxPrice != null ? selectedMaxPrice : 3500000}" />
                                    <div class="d-flex justify-content-between small text-muted">
                                        <span>₫ 500.000</span>
                                        <span>₫ 3.500.000</span>
                                    </div>
                                    <div class="mt-2">
                                        <span class="text-dark">Đến:</span> <span class="font-weight-bold" id="currentPrice"></span>
                                    </div>
                                    <input type="hidden" id="minPriceHidden" name="minPrice" value="500000" />
                                </div>

                                <div class="mb-4">
                                    <label class="font-weight-bold mb-2">Hãng hàng không</label>
                                    <div class="custom-control custom-checkbox mb-2">
                                        <input class="custom-control-input" type="checkbox" name="airline[]" value="all" id="allAirlines"
                                               <c:if test="${empty selectedAirlines || selectedAirlines.contains('all')}">checked</c:if> />
                                               <label class="custom-control-label ml-2" for="allAirlines">Tất cả hãng</label>
                                        </div>

                                        <div class="custom-control custom-checkbox mb-2 d-flex align-items-center">
                                            <input class="custom-control-input" type="checkbox" name="airline[]" value="Vietnam Airlines" id="vietnamAirlines"
                                            <c:if test="${selectedAirlines.contains('Vietnam Airlines')}">checked</c:if>>
                                            <label class="custom-control-label ml-2 d-flex align-items-center" for="vietnamAirlines">
                                                <img src="assets/images/airplane/VNA.png" width="32" height="22" class="rounded mr-1 border" alt="VNA"/>
                                                <span class="ml-2" style="font-size:15px">Vietnam Airlines</span>
                                            </label>
                                        </div>

                                        <div class="custom-control custom-checkbox mb-2 d-flex align-items-center">
                                            <input class="custom-control-input" type="checkbox" name="airline[]" value="Vietjet Air" id="vietjetAir"
                                            <c:if test="${selectedAirlines.contains('Vietjet Air')}">checked</c:if>>
                                            <label class="custom-control-label ml-2 d-flex align-items-center" for="vietjetAir">
                                                <img src="assets/images/airplane/VJA.png" width="32" height="22" class="rounded mr-1 border" alt="VJA"/>
                                                <span class="ml-2" style="font-size:15px">Vietjet Air</span>
                                            </label>
                                        </div>

                                        <div class="custom-control custom-checkbox mb-2 d-flex align-items-center">
                                            <input class="custom-control-input" type="checkbox" name="airline[]" value="Bamboo Airways" id="bambooAirways"
                                            <c:if test="${selectedAirlines.contains('Bamboo Airways')}">checked</c:if>>
                                            <label class="custom-control-label ml-2 d-flex align-items-center" for="bambooAirways">
                                                <img src="assets/images/airplane/BBA.jpg" width="32" height="22" class="rounded mr-1 border" alt="BBA"/>
                                                <span class="ml-2" style="font-size:15px">Bamboo Airways</span>
                                            </label>
                                        </div>

                                        <div class="custom-control custom-checkbox mb-2 d-flex align-items-center">
                                            <input class="custom-control-input" type="checkbox" name="airline[]" value="Vietravel Airlines" id="vietravelAirlines"
                                            <c:if test="${selectedAirlines.contains('Vietravel Airlines')}">checked</c:if>>
                                            <label class="custom-control-label ml-2 d-flex align-items-center" for="vietravelAirlines">
                                                <img src="assets/images/airplane/VTA.jpg" width="32" height="22" class="rounded mr-1 border" alt="VTA"/>
                                                <span class="ml-2" style="font-size:15px">Vietravel Airlines</span>
                                            </label>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-danger btn-block btn-lg rounded font-weight-bold mt-3">Áp dụng bộ lọc</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- Kết thúc bộ lọc trái -->

                    <!-- Danh sách vé phải -->
                    <div class="col-md-9">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="font-weight-bold mb-0" style="font-size:1.5rem">Các chuyến bay có sẵn</h4>
                            <div class="btn-group" role="group" aria-label="Sort options">
                                <button type="button" class="btn btn-outline-danger sort-btn ${selectedSortBy == 'price_asc' ? 'active' : ''}" data-sort="price_asc">Rẻ nhất</button>
                            <button type="button" class="btn btn-outline-danger sort-btn ${selectedSortBy == 'duration_asc' ? 'active' : ''}" data-sort="duration_asc">Nhanh nhất</button>
                            <div class="btn-group" role="group">
                                <button id="dropdownSortBy" type="button" class="btn btn-outline-danger dropdown-toggle" data-toggle="dropdown">
                                    Sắp xếp theo
                                </button>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownSortBy">
                                    <a class="dropdown-item sort-btn ${selectedSortBy == 'departure_asc' ? 'active' : ''}" href="#" data-sort="departure_asc">Xuất phát sớm nhất</a>
                                    <a class="dropdown-item sort-btn ${selectedSortBy == 'arrival_asc' ? 'active' : ''}" href="#" data-sort="arrival_asc">Đến sớm nhất</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">${errorMessage}</div>
                    </c:if>

                    <c:choose>
                        <c:when test="${empty ticketList}">
                            <div class="alert alert-info text-center" role="alert">
                                <h4 class="alert-heading">Không tìm thấy chuyến bay!</h4>
                                <p>Xin lỗi, không có chuyến bay nào từ <strong>${fn:escapeXml(origin)}</strong> đến <strong>${fn:escapeXml(destination)}</strong> phù hợp với tiêu chí lọc của bạn.</p>
                                <hr>
                                <p class="mb-0">Vui lòng thử các ngày khác hoặc điều chỉnh tiêu chí tìm kiếm của bạn.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="ticket" items="${ticketList}">
                                <div class="card mb-3 shadow-sm border-0 rounded-lg d-flex flex-row align-items-center" style="min-height:120px;">
                                    <div class="d-flex align-items-center pl-4 pr-2" style="width:100px;">
                                        <img src="${ticket.image}" class="img-fluid rounded border bg-white" alt="${ticket.airline} Logo" style="width:54px;height:38px;object-fit:contain;" />
                                    </div>
                                    <div class="flex-grow-1 px-2 py-3">
                                        <h5 class="font-weight-bold text-danger">${ticket.airline}</h5>
                                        <p class="mb-0 small text-secondary">${ticket.origin} → ${ticket.destination}</p>
                                    </div>
                                    <div class="flex-grow-1 px-2 py-3">
                                        <h5 class="font-weight-bold text-danger">Loai vé: ${ticket.type}</h5>
                                        
                                    </div>
                                    <div class="px-3">
                                        <span class="text-danger font-weight-bold" style="font-size:1.25rem">${ticket.price}₫</span>
                                        <p class="mb-0 small text-muted">Thời gian bay: ${ticket.estimatedtime}</p>
                                    </div>
                                    <div class="px-3">
                                        <a href="ticketDetail?ticketId=${ticket.id}" class="btn btn-outline-danger btn-lg rounded font-weight-bold">Đặt vé</a>
                                    </div>
                                    <form action="addtocart" method="post">
                                        <input type="hidden" name="type" value="ticket" />
                                        <input type="hidden" name="id" value="${ticket.id}" />
                                        <input type="hidden" name="name" value="${ticket.airline}" />
                                        <input type="hidden" name="price" value="${ticket.price}" />
                                        <input type="hidden" name="image" value="${ticket.image}" />
                                        <button type="submit" class="btn btn-sm btn-outline-danger w-100 mt-2">
                                            <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                                        </button>
                                    </form>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- Kết thúc danh sách vé phải -->
            </div>
                                

        </div>
                                   

        <script src="./assets/js/jquery-3.5.1.min.js"></script>
        <script src="./assets/js/bootstrap.bundle.min.js"></script>
        <script>
            // Hiển thị giá hiện tại trên slider
            function updateCurrentPrice() {
                let price = $("#priceRange").val();
                $("#currentPrice").text(price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + "₫");
            }

            $(document).ready(function () {
                updateCurrentPrice();

                $("#priceRange").on("input change", function () {
                    updateCurrentPrice();
                });

                // Xử lý nút sắp xếp
                $(".sort-btn").click(function (e) {
                    e.preventDefault();
                    let sortValue = $(this).data("sort");
                    $("#sortByInput").val(sortValue);
                    $("#filterForm").submit();
                });

                // Khi chọn "Tất cả hãng" thì bỏ chọn các hãng riêng lẻ
                $("#allAirlines").change(function () {
                    if ($(this).is(":checked")) {
                        $("input[name='airline[]']").not(this).prop("checked", false);
                    }
                });

                // Khi chọn hãng riêng lẻ thì bỏ chọn "Tất cả hãng"
                $("input[name='airline[]']").not("#allAirlines").change(function () {
                    if ($(this).is(":checked")) {
                        $("#allAirlines").prop("checked", false);
                    }
                });
            });

        </script>

        <jsp:include page="footer.jsp" />
    </body>
</html>
