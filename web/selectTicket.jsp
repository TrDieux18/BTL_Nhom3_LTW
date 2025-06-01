<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Chọn vé máy bay - ${fn:escapeXml(origin)} → ${fn:escapeXml(destination)}</title>
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
                <span>${origin}</span>
                <span class="mx-2" style="font-size:1.7rem;">
                    <i class="fa fa-arrow-right mx-1"></i>
                </span>
                <span> ${destination}</span>
            </h2>
            <p class="text-muted lead" style="font-size:1.1rem">
                Tìm thấy <span class="font-weight-bold text-dark">${ticketResults != null ? ticketResults.size() : 0}</span> chuyến bay cho chặng này.
            </p>
        </div>
    </div>
    <div class="row">
        <!-- Bộ lọc trái -->
        <div class="col-md-3 mb-3">
            <div class="card shadow-sm border-0 rounded-lg">
                <div class="card-body">
                    <h5 class="card-title text-danger font-weight-bold mb-4">Bộ lọc tìm kiếm</h5>
                    <form id="filterForm" action="selectTicket" method="get">
                        <input type="hidden" name="origin" value="${origin}">
                        <input type="hidden" name="destination" value="${destination}">
                        <input type="hidden" name="sortBy" id="sortByInput" value="${selectedSortBy}">
                        <!-- Slider giá -->
                        <div class="mb-4">
                            <label class="font-weight-bold mb-1" for="priceRange">Giá</label>
                            <input type="range" class="custom-range" min="500000" max="3500000" step="100000" id="priceRange" name="maxPrice" value="${selectedMaxPrice!=null ? selectedMaxPrice : 3500000}">
                            <div class="d-flex justify-content-between small text-muted">
                                <span>₫ 500.000</span>
                                <span>₫ 3.500.000</span>
                            </div>
                            <div class="mt-2">
                                <span class="text-dark">Đến:</span> <span class="font-weight-bold" id="currentPrice"></span>
                            </div>
                            <input type="hidden" id="minPriceHidden" name="minPrice" value="500000">
                        </div>
                        <div class="mb-4">
                            <label class="font-weight-bold mb-2">Hãng hàng không</label>
                            <div class="custom-control custom-checkbox mb-2">
                                <input class="custom-control-input" type="checkbox" name="airline" value="all" id="allAirlines"
                                    <c:if test="${empty selectedAirlines || selectedAirlines.contains('all')}">checked</c:if>>
                                <label class="custom-control-label ml-2" for="allAirlines">Tất cả hãng</label>
                            </div>
                            <div class="custom-control custom-checkbox mb-2 d-flex align-items-center">
                                <input class="custom-control-input" type="checkbox" name="airline" value="Vietnam Airlines" id="vietnamAirlines" <c:if test="${selectedAirlines.contains('Vietnam Airlines')}">checked</c:if>>
                                <label class="custom-control-label ml-2 d-flex align-items-center" for="vietnamAirlines"><img src="assets/images/VNA.png" width="32" height="22" class="rounded mr-1 border" alt="VNA"/> <span class="ml-2" style="font-size:15px">Vietnam Airlines</span></label>
                            </div>
                            <div class="custom-control custom-checkbox mb-2 d-flex align-items-center">
                                <input class="custom-control-input" type="checkbox" name="airline" value="Vietjet Air" id="vietjetAir" <c:if test="${selectedAirlines.contains('Vietjet Air')}">checked</c:if>>
                                <label class="custom-control-label ml-2 d-flex align-items-center" for="vietjetAir"><img src="assets/images/VJA.png" width="32" height="22" class="rounded mr-1 border" alt="VJA"/> <span class="ml-2" style="font-size:15px">Vietjet Air</span></label>
                            </div>
                            <div class="custom-control custom-checkbox mb-2 d-flex align-items-center">
                                <input class="custom-control-input" type="checkbox" name="airline" value="Bamboo Airways" id="bambooAirways" <c:if test="${selectedAirlines.contains('Bamboo Airways')}">checked</c:if>>
                                <label class="custom-control-label ml-2 d-flex align-items-center" for="bambooAirways"><img src="assets/images/BBA.jpg" width="32" height="22" class="rounded mr-1 border" alt="BBA"/> <span class="ml-2" style="font-size:15px">Bamboo Airways</span></label>
                            </div>
                            <div class="custom-control custom-checkbox mb-2 d-flex align-items-center">
                                <input class="custom-control-input" type="checkbox" name="airline" value="Vietravel Airlines" id="vietravelAirlines" <c:if test="${selectedAirlines.contains('Vietravel Airlines')}">checked</c:if>>
                                <label class="custom-control-label ml-2 d-flex align-items-center" for="vietravelAirlines"><img src="assets/images/VTA.jpg" width="32" height="22" class="rounded mr-1 border" alt="VTA"/> <span class="ml-2" style="font-size:15px">Vietravel Airlines</span></label>
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
                    <button type="button" class="btn btn-outline-danger sort-btn <c:if test='${selectedSortBy == "price_asc"}'>active</c:if>'" data-sort="price_asc">Rẻ nhất</button>
                    <button type="button" class="btn btn-outline-danger sort-btn <c:if test='${selectedSortBy == "duration_asc"}'>active</c:if>'" data-sort="duration_asc">Nhanh nhất</button>
                    <div class="btn-group" role="group">
                        <button id="dropdownSortBy" type="button" class="btn btn-outline-danger dropdown-toggle" data-toggle="dropdown">
                            Sắp xếp theo
                        </button>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownSortBy">
                            <a class="dropdown-item sort-btn <c:if test='${selectedSortBy == "departure_asc"}'>active</c:if>'" href="#" data-sort="departure_asc">Xuất phát sớm nhất</a>
                            <a class="dropdown-item sort-btn <c:if test='${selectedSortBy == "arrival_asc"}'>active</c:if>'" href="#" data-sort="arrival_asc">Đến sớm nhất</a>
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">${errorMessage}</div>
            </c:if>
            <c:choose>
                <c:when test="${empty ticketResults}">
                    <div class="alert alert-info text-center" role="alert">
                        <h4 class="alert-heading">Không tìm thấy chuyến bay!</h4>
                        <p>Xin lỗi, không có chuyến bay nào từ <strong>${origin}</strong> đến <strong>${destination}</strong> phù hợp với tiêu chí lọc của bạn.</p>
                        <hr>
                        <p class="mb-0">Vui lòng thử các ngày khác hoặc điều chỉnh tiêu chí tìm kiếm của bạn.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="ticket" items="${ticketResults}">
                        <div class="card mb-3 shadow-sm border-0 rounded-lg d-flex flex-row align-items-center" style="min-height:120px;">
                            <div class="d-flex align-items-center pl-4 pr-2" style="width:100px;">
                                <img src="${ticket.image}" class="img-fluid rounded border bg-white" alt="${ticket.airline} Logo" style="width:54px;height:38px;object-fit:contain;" />
                            </div>
                            <div class="flex-grow-1 px-2 py-3">
                                <h5 class="mb-1 font-weight-bold text-dark" style="font-size:1.1rem">${ticket.airline}</h5>
                                <div class="text-muted small mb-1">${ticket.type}</div>
                                <div class="d-flex align-items-center" style="font-size:18px;">
                                    <span><fmt:formatDate value="${ticket.departuretime}" pattern="HH:mm" /></span>
                                    <span class="mx-1"><i class="fa fa-arrow-right"></i></span>
                                    <span><fmt:formatDate value="${ticket.arrivetime}" pattern="HH:mm" /></span>
                                </div>
                                <div class="text-muted small mt-1">
                                    <i class="fa fa-clock mr-1"></i>
                                    <span>${ticket.estimatedtime != null && !ticket.estimatedtime.isEmpty() ? ticket.estimatedtime : "Không xác định"}</span>
                                    <span class="mx-2">|</span>
                                    <span>${ticket.origin} <i class="fa fa-arrow-right"></i> ${ticket.destination}</span>
                                </div>
                            </div>
                            <div class="pr-4 pl-2 d-flex flex-column align-items-end justify-content-center" style="min-width:160px;">
                                <div class="font-weight-bold text-danger" style="font-size:1.5rem">
                                    <fmt:formatNumber value="${ticket.price}" type="number" groupingUsed="true" maxFractionDigits="0" />₫
                                </div>
                                <span class="text-muted small">Giá/Người</span>
                                <a href="booking?origin=${ticket.origin}&destination=${ticket.destination}&departureTime=${ticket.departuretime}" class="btn btn-danger rounded mt-2 px-4 py-1 font-weight-bold">Chọn</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="./assets/js/bootstrap.bundle.min.js"></script>
<script>
    var priceRange = document.getElementById('priceRange');
    var currentPriceSpan = document.getElementById('currentPrice');
    function formatCurrency(amount) {
        if (!amount) return '';
        return parseInt(amount).toLocaleString('vi-VN') + ' đ';
    }
    function updatePriceDisplay() {
        currentPriceSpan.innerHTML = formatCurrency(priceRange.value);
    }
    priceRange.oninput = updatePriceDisplay;
    updatePriceDisplay();

    // Checkbox logic
    $(function(){
        var allAirlines = $('#allAirlines');
        var airlineCheckboxes = $('input[name="airline"]').not('#allAirlines');
        function toggleAirlineCheck(){
            if(allAirlines.prop('checked')){
                airlineCheckboxes.prop('checked', false).prop('disabled', true);
            } else {
                airlineCheckboxes.prop('disabled', false);
            }
        }
        allAirlines.change(function(){toggleAirlineCheck();});
        airlineCheckboxes.change(function(){
            let anyChecked = airlineCheckboxes.filter(':checked').length>0;
            if(anyChecked) allAirlines.prop('checked', false);
            else allAirlines.prop('checked', true);
            toggleAirlineCheck();
        });
        toggleAirlineCheck();
        // Sort button
        $('.sort-btn').click(function(e){
            e.preventDefault();
            var sortVal = $(this).data('sort');
            $('#sortByInput').val(sortVal);
            $('#filterForm').submit();
        });
    });
</script>
<jsp:include page="footer.jsp" />
</body>
</html>