<%@page import="model.Ticket"%>
<%@page import="dal.TicketDAO"%>
<%@page import="model.Hotel"%>
<%@page import="java.util.List"%>
<%@page import="dal.HotelDAO"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Trang chủ</title>

        <style>
            .top h2 {
                margin-bottom: 10px;
                left: 295px;
                font-size: 40px;
                font-weight: bold;
                color: white;
            }
            .top h5 {
                left: 295px;
                margin-top: 10px;
                margin-bottom: 20px;
                font-size: 20px;
                color: white;
            }
            .carousel {
                position: relative;
                overflow: hidden;
                width: 100%;
            }
            .hotel-list{
                display: flex;
                overflow-x: auto;
                scroll-behavior: smooth;
                padding: 10px 0;
                scrollbar-width: none; /* Firefox */
                scroll-snap-type: x mandatory;
            }
            .hotel-list::-webkit-scrollbar{
                display: none; /* Chrome, Safari */
            }
            .box-hotel{
                flex: 0 0 300px;
                min-width: 300px;
                margin-right: 15px;
                scroll-snap-align: start;
            }
            .hotel-card{
                height: 100%;
            }
            .hotel-card img{
                height: 180px;
                object-fit: cover;
            }
            .nav-button {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                background: rgba(0, 0, 0, 0.5);
                color: white;
                border: none;
                padding: 10px;
                cursor: pointer;
                font-size: 1.5em;
                border-radius: 5px;
                z-index: 10;
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            }
            .nav-button.left {
                left: 10px;
            }
            .nav-button.right {
                right: 10px;
            }
            .nav-button:hover {
                background: rgba(0, 0, 0, 0.8);
                transform: translateY(-50%) scale(1.1);
            }
            .nav-button:disabled {
                background: rgba(0, 0, 0, 0.2);
                cursor: not-allowed;
                transform: translateY(-50%) scale(1);
            }


        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />


        <%
            HotelDAO hotelDAO = new HotelDAO();
            List<Hotel> hotels = hotelDAO.getAllHotel();
            request.setAttribute("hotels", hotels);
            int mid = hotels.size()/2;
             List<Hotel> recommendedHotels = hotels.subList(0, mid);
             request.setAttribute("recommendedHotels", recommendedHotels);
             List<Hotel> discountHotels = hotels.subList(mid, hotels.size());
              request.setAttribute("discountHotels", discountHotels);
            TicketDAO ticketDAO = new TicketDAO();
            List<Ticket> tickets = ticketDAO.getAllTickets();
            request.setAttribute("tickets", tickets);
            int midList = tickets.size() /2;
            List<Ticket> recommendedTickets = tickets.subList(0, midList);
             request.setAttribute("recommendedTickets", recommendedTickets);
             List<Ticket> discountTickets = tickets.subList(midList, tickets.size());
              request.setAttribute("discountTickets", discountTickets);
        %>
        <section class="search-hotel">
            <div class="container py-5">
                <div class="top">
                    <h2>Đi du lịch ngay thôi</h2>
                    <h5>Nhận ưu đãi vé máy bay và khách sạn cho chuyến du lịch</h5>
                </div>               
            </div>
        </section>

        <div class="container d-flex flex-column justify-content-center" style="padding-top:20px; padding-bottom: 0px;">
            <h2 class="mb-2 text-dark" style="font-size: 25px;">Khuyến mãi không thể chịu thua</h2>
            <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" data-interval="2000" style="width: 1100px; height:auto; padding-top: 20px;border-radius: 10px; ">
                <ol class="carousel-indicators">
                    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active" ></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
                </ol>
                <div class="carousel-inner" style="border-radius: 10px;">
                    <div class="carousel-item active" style="border-radius: 10px;">
                        <img src="./assets/images/u4.jpg" class="d-block w-100" alt="Slide 1" style="border-radius: 10px; ">
                    </div>
                    <div class="carousel-item">
                        <img src="./assets/images/u5.jpg" class="d-block w-100" alt="Slide 2" style="border-radius: 10px; ">
                    </div>
                    <div class="carousel-item">
                        <img src="./assets/images/u6.jpg" class="d-block w-100" alt="Slide 3" style="border-radius: 10px; ">
                    </div>
                    <div class="carousel-item">
                        <img src="./assets/images/u7.jpg" class="d-block w-100" alt="Slide 4" style="border-radius: 10px; ">
                    </div>
                </div>
            </div>
        </div>
        <!-- Vé máy bay -->
        <section class="container py-4">
            <h2 class="mb-4 text-dark" style="font-size: 25px;">Vé máy bay đề xuất</h2>
            <div class="carousel">
                <button class="nav-button left" id="ticket-recommended-prev">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <button class="nav-button right" id="ticket-recommended-next">
                    <i class="fas fa-chevron-right"></i>
                </button>
                <div class="hotel-list" id="ticket-recommended">
                    <c:forEach var="ticket" items="${recommendedTickets}">
                        <div class="box-hotel">
                            <a href="ticketDetail?ticketId=${ticket.id}" class="text-decoration-none">
                                <div class="card h-100 hotel-card">
                                    <img src="${ticket.image != null ? ticket.image : './assets/images/default-ticket.jpg'}" alt="${ticket.airline}" class="card-img-top" />
                                    <div class="card-body">
                                        <h5 class="card-title text-dark">${ticket.airline}</h5>
                                        <p class="card-text text-secondary mb-1">${ticket.origin} → ${ticket.destination}</p>
                                        <p class="card-text text-secondary mb-1">Khởi hành: ${ticket.departuretimeString}</p>
                                        <p class="card-text text-secondary mb-1">Thời gian bay: ${ticket.estimatedtime}</p>
                                        <p class="text-danger fw-bold">
                                            <fmt:formatNumber value="${ticket.price}" type="currency" currencySymbol="VNĐ " />
                                        </p>
                                        <!-- Thêm vào giỏ hàng -->
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
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                    <c:if test="${empty tickets}">
                        <p class="text-secondary">Không có vé máy bay nào được tìm thấy.</p>
                    </c:if>
                </div>
            </div>

            <h2 class="mb-4 text-dark" style="font-size: 25px; margin-top:40px;">Vé máy bay ưu đãi</h2>
            <div class="carousel">
                <button class="nav-button left" id="ticket-promo-prev">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <button class="nav-button right" id="ticket-promo-next">
                    <i class="fas fa-chevron-right"></i>
                </button>
                <div class="hotel-list" id="ticket-promo">
                    <c:forEach var="ticket" items="${discountTickets}">
                        <div class="box-hotel">
                            <a href="ticketDetail?ticketId=${ticket.id}" class="text-decoration-none">
                                <div class="card h-100 hotel-card">
                                    <img src="${ticket.image != null ? ticket.image : './assets/images/default-ticket.jpg'}" alt="${ticket.airline}" class="card-img-top" />
                                    <div class="card-body">
                                        <h5 class="card-title text-dark">${ticket.airline}</h5>
                                        <p class="card-text text-secondary mb-1">${ticket.origin} → ${ticket.destination}</p>
                                        <p class="card-text text-secondary mb-1">Khởi hành: ${ticket.departuretimeString}</p>
                                        <p class="card-text text-secondary mb-1">Thời gian bay: ${ticket.estimatedtime}</p>
                                        <p class="text-danger fw-bold">
                                            <fmt:formatNumber value="${ticket.price}" type="currency" currencySymbol="VNĐ " />
                                        </p>
                                        <!-- Thêm vào giỏ hàng -->
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
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                    <c:if test="${empty tickets}">
                        <p class="text-secondary">Không có vé máy bay nào được tìm thấy.</p>
                    </c:if>
                </div>
            </div>
        </section>

        <!-- Khách sạn -->
        <section class="container py-4">
            <h2 class="mb-4 text-dark" style="font-size: 25px;">Khách sạn đề xuất</h2>
            <div class="carousel">
                <button class="nav-button left" id="hotel-recommended-prev">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <button class="nav-button right" id="hotel-recommended-next">
                    <i class="fas fa-chevron-right"></i>
                </button>
                <div class="hotel-list" id="hotel-recommended">
                    <c:forEach var="hotel" items="${recommendedHotels}">
                        <div class="box-hotel">
                            <a href="detail?hotelId=${hotel.id}" class="text-decoration-none">
                                <div class="card h-100 hotel-card">
                                    <img src="${hotel.image != null ? hotel.image : './assets/images/default-hotel.jpg'}" alt="${hotel.name}" class="card-img-top" />
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
                    <c:if test="${empty hotels}">
                        <p class="text-secondary">Không có khách sạn nào được tìm thấy.</p>
                    </c:if>
                </div>
            </div>

            <h2 class="mb-4 text-dark" style="font-size: 25px; margin-top:40px;">Khách sạn ưu đãi</h2>
            <div class="carousel">
                <button class="nav-button left" id="hotel-promo-prev">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <button class="nav-button right" id="hotel-promo-next">
                    <i class="fas fa-chevron-right"></i>
                </button>
                <div class="hotel-list" id="hotel-promo">
                    <c:forEach var="hotel" items="${discountHotels}">
                        <div class="box-hotel">
                            <a href="detail?hotelId=${hotel.id}" class="text-decoration-none">
                                <div class="card h-100 hotel-card">
                                    <img src="${hotel.image != null ? hotel.image : './assets/images/default-hotel.jpg'}" alt="${hotel.name}" class="card-img-top" />
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
                    <c:if test="${empty hotels}">
                        <p class="text-secondary">Không có khách sạn nào được tìm thấy.</p>
                    </c:if>
                </div>
            </div>
        </section>
        <!-- Why Travel with Airpaz Section -->
        <div class="why-airpaz-section">
            <h2>Tại sao phải đi du lịch với Airpaz</h2>
            <div class="features-row">
                <div class="feature-item">
                    <div class="feature-image">
                        <img src="./assets/images/simplified-booking.webp" alt="Đơn giản hóa đặt chỗ">
                    </div>
                    <h4>Đơn giản hóa trải nghiệm đặt chỗ của bạn</h4>
                    <p>Cảm nhận sự linh hoạt và đơn giản trong suốt quá trình đặt chỗ của bạn</p>
                </div>

                <div class="feature-item">
                    <div class="feature-image">
                        <img src="./assets/images/wide-selection-travel.webp" alt="Đa dạng lựa chọn">
                    </div>
                    <h4>Đa dạng sự lựa chọn để đi du lịch</h4>
                    <p>Tận hưởng những khoảnh khắc đáng nhớ với hàng triệu vé máy bay và chỗ ở thuận tiện</p>
                </div>

                <div class="feature-item">
                    <div class="feature-image">
                        <img src="./assets/images/exclusive-offer.webp" alt="Ưu đãi độc quyền">
                    </div>
                    <h4>Ưu đãi độc quyền mỗi ngày</h4>
                    <p>Vô số chương trình khuyến mãi hàng ngày với giá cả cạnh tranh cho tất cả khách du lịch</p>
                </div>

                <div class="feature-item">
                    <div class="feature-image">
                        <img src="./assets/images/online-booking-expert.webp" alt="Đặt chỗ chuyên nghiệp">
                    </div>
                    <h4>Nơi đặt chỗ trực tuyến chuyên nghiệp</h4>
                    <p>Cùng với các đối tác đáng tin cậy, chúng tôi đã đáp ứng vô số nhu cầu của khách du lịch kể từ năm 2011</p>
                </div>

                <div class="feature-item">
                    <div class="feature-image">
                        <img src="./assets/images/affectionate-customer-support.webp" alt="Hỗ trợ khách hàng">
                    </div>
                    <h4>Hỗ trợ khách hàng nhiệt tình</h4>
                    <p>Hỗ trợ tốt nhất, bộ phận hỗ trợ khách hàng của chúng tôi luôn sẵn sàng 24/7 bất kể ngôn ngữ địa phương bạn sử dụng</p>
                </div>

                <div class="feature-item">
                    <div class="feature-image">
                        <img src="./assets/images/worlds-local-booking-excitement.webp" alt="Dịch vụ địa phương">
                    </div>
                    <h4>Thoải mái đặt chỗ bằng dịch vụ phù hợp với địa phương</h4>
                    <p>Trải nghiệm cảm giác thoải mái khi đặt chỗ bằng phương thức thanh toán, tiền tệ và ngôn ngữ địa phương</p>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
        <script src="./assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/JS/jquery.slim.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script>
            function createCarouselNavigation(containerId, prevBtnId, nextBtnId) {
                const container = document.getElementById(containerId);
                const prevBtn = document.getElementById(prevBtnId);
                const nextBtn = document.getElementById(nextBtnId);
                if (!container || !prevBtn || !nextBtn)
                    return;
                const cardWidth = 315;
                function updateButtons() {
                    const scrollLeft = container.scrollLeft;
                    const maxScroll = container.scrollWidth - container.clientWidth;

                    prevBtn.disabled = scrollLeft <= 0;
                    nextBtn.disabled = scrollLeft >= maxScroll - 1;
                }
                prevBtn.addEventListener('click', () => {
                    container.scrollBy({
                        left: -cardWidth,
                        behavior: 'smooth'
                    });
                });
                nextBtn.addEventListener('click', () => {
                    container.scrollBy({
                        left: cardWidth,
                        behavior: 'smooth'
                    });
                });
                container.addEventListener('scroll', updateButtons);
                updateButtons();
                window.addEventListener('resize', updateButtons);
            }
            document.addEventListener('DOMContentLoaded', function () {
                createCarouselNavigation('ticket-recommended', 'ticket-recommended-prev', 'ticket-recommended-next');
                createCarouselNavigation('ticket-promo', 'ticket-promo-prev', 'ticket-promo-next');
                createCarouselNavigation('hotel-recommended', 'hotel-recommended-prev', 'hotel-recommended-next');
                createCarouselNavigation('hotel-promo', 'hotel-promo-prev', 'hotel-promo-next');
            });
        </script>          
    </body>
</html>