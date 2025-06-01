<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Ticket" %>
<%@ page import="model.HotelBooking" %>
<%
    String type = (String) request.getAttribute("type");
%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Đơn hàng đã đặt</title>
        <style>
            html, body {
                height: 100%;
                margin: 0;
            }
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            .container {
                flex: 1 0 auto;
            }
            footer {
                flex-shrink: 0;
            }
            .cancel-button {
                margin-left: auto;
                display: flex;
                top: 10px;
                right: 10px;
                background-color: #ff4d4f;
                color: white;
                border: none;
                padding: 5px 10px;
                border-radius: 5px;
                /*cursor: pointer;*/
                font-weight: bold;
            }

            .cancel-button:hover {
                background-color: #d9363e;
            }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Hiển thị thông báo nếu có
            <% if (request.getAttribute("message") != null) { %>
                alert('<%= request.getAttribute("message") %>');
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                alert('<%= request.getAttribute("error") %>');
            <% } %>
            });
        </script>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <%@ page import="model.User" %>
        <div class="container mt-5 mb-5">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3">
                    <div class="list-group">
                        <a href="${pageContext.request.contextPath}/orders?action=get&type=all&id=<%= user.getId() %>" class="list-group-item list-group-item-action active" style="background-color: #da3d33"><i class="fa-solid fa-border-all"></i>Tất cả</a>
                        <a href="${pageContext.request.contextPath}/orders?action=get&type=flight&id=<%= user.getId() %>" class="list-group-item list-group-item-action "><i class="fa-solid fa-plane-up"></i>Vé máy bay</a>
                        <a href="${pageContext.request.contextPath}/orders?action=get&type=hotel&id=<%= user.getId() %>" class="list-group-item list-group-item-action "><i class="fa-solid fa-hotel"></i>Khách sạn</a>
                        <a href="profile" class="list-group-item list-group-item-action active" style="background-color: #da3d33"><i class="fa fa-user me-2"></i>Hồ sơ</a>
                        <a href="password" class="list-group-item list-group-item-action"><i class="fa fa-key me-2"></i>Thay đổi mật khẩu</a>
                        <a href="logout" id="logoutBtn" class="list-group-item list-group-item-action"><i class="fa-solid fa-right-from-bracket"></i>Đăng xuất</a>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-9">
                    <!-- Vé máy bay -->
                    <%
                                            if (type == null || "all".equals(type) || "flight".equals(type)) {
                                                List<Ticket> tickets = (List<Ticket>) request.getAttribute("tickets");
                    %>
                    <form action="orders" method="post">
                        <div class="card mb-4">
                            <div class="card-header bg-danger text-white">Vé máy bay đã đặt</div>
                            <div class="card-body">
                                <%
                                                                    if (tickets != null && !tickets.isEmpty()) {
                                                                        for (Ticket ticket : tickets) {
                                %>
                                <div class="booked-card">
                                    <form action="${pageContext.request.contextPath}/orders" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="type" value="flight">
                                        <input type="hidden" name="bookingdeleteId" value="<%= ticket.getId()%>">
                                        <input type="hidden" name="userId" value="<%= user.getId()%>">
                                        <button type="submit" class="cancel-button" 
                                                onclick="return confirm('Bạn có chắc chắn muốn hủy vé máy bay này?')">Hủy</button>
                                    </form>
                                    <div class="booked-info">
                                        <div><i class="fa-solid fa-plane"></i><strong>Chuyến bay:</strong> <%= ticket.getAirline() %></div>
                                        <div><i class="fa-solid fa-location-dot"></i><strong>Điểm đi:</strong> <%= ticket.getOrigin() %> - <strong>Điểm đến:</strong> <%= ticket.getDestination() %></div>
                                        <div><i class="fa-regular fa-clock"></i><strong>Giờ khởi hành:</strong> <%= ticket.getDeparturetime() %> - <strong>Giờ đến:</strong> <%= ticket.getArrivetime() %></div>
                                        <div><i class="fa-solid fa-chair"></i><strong>Ghế:</strong> <%= ticket.getType() %></div>
                                        <div class="booked-price"><i class="fa-solid fa-dollar-sign"></i><%= ticket.getPrice() %> VNĐ</div>
                                    </div>
                                </div>
                                <% }
                            } else { %>
                                <p>Bạn chưa đặt vé máy bay nào.</p>
                                <% } %>
                            </div>
                        </div>
                    </form>
                    <% } %>

                    <!-- Khách sạn -->
                    <%
                                            if (type == null || "all".equals(type) || "hotel".equals(type)) {
                                                List<HotelBooking> hotelBookings = (List<HotelBooking>) request.getAttribute("hotelBookings");
                    %>
                    <form action="orders" method="post">
                        <div class="card">
                            <div class="card-header bg-danger text-white">Phòng khách sạn đã đặt</div>
                            <div class="card-body">
                                <%
                                                                    if (hotelBookings != null && !hotelBookings.isEmpty()) {
                                                                        for (HotelBooking booking : hotelBookings) {
                                %>
                                <div class="booked-card">
                                    <form action="${pageContext.request.contextPath}/orders" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="type" value="hotel">
                                        <input type="hidden" name="bookingdeleteId" value="<%= booking.getId()%>">
                                        <input type="hidden" name="userId" value="<%= user.getId()%>">
                                        <button type="submit" class="cancel-button" 
                                                onclick="return confirm('Bạn có chắc chắn muốn hủy đặt phòng này?')">Hủy</button>
                                    </form>
                                    <div class="booked-info">
                                        <div><i class="fa-solid fa-hotel"></i><strong>Khách sạn:</strong> <%= booking.getHotelName() %></div>
                                        <div><i class="fa-regular fa-calendar-check"></i><strong>Ngày nhận phòng:</strong> <%= booking.getCheckInDate() %> - <strong>Ngày trả phòng:</strong> <%= booking.getCheckOutDate() %></div>
                                        <div><i class="fa-regular fa-calendar-days"></i><strong>Ngày đặt:</strong> <%= booking.getBookingDate() %></div>
                                        <div><i class="fa-solid fa-bed"></i><strong>Số lượng phòng:</strong> <%= booking.getRoomQuantity() %></div>
                                        <div><i class="fa-solid fa-note-sticky"></i><strong>Ghi chú:</strong> <%= booking.getNotes() %></div>
                                        <div class="booked-price"><i class="fa-solid fa-dollar-sign"></i> <%= booking.getTotalPrice() %> VNĐ</div>
                                        <div><i class="fa-solid fa-info-circle"></i><strong>Trạng thái:</strong> <%= booking.getStatus() %></div>
                                    </div>
                                </div>
                                <% }
                            } else { %>
                                <p>Bạn chưa đặt phòng khách sạn nào.</p>
                                <% } %>
                            </div>
                        </div>
                    </form>
                    <% } %>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>