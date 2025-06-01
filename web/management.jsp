<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Ticket" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="model.Hotel" %>
<%@ page import="model.BookingHistory" %>
<%@ page import="model.HotelBooking" %>
<!DOCTYPE html>
<html>
    <head>

        <title>Quản lí</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <style>
            .col-2.tab-left .container {
                display: flex;
                flex-direction: column;
                gap: 10px; /* khoảng cách giữa các nút (tùy chỉnh) */
            }
            .col-2.tab-left .container a{
                text-decoration: none;
            }


        </style>
        <section class="control-ticket">
            <div class="row">

                <div class="col-2 tab-left">
                    <div class="container">
                        <a href="${pageContext.request.contextPath}/management?tab=flight&action=search" class="inner-desc tab-button active" data-tab="flight">Vé Máy Bay</a>
                        <a href="${pageContext.request.contextPath}/management?tab=hotel&action=search" class="inner-desc tab-button" data-tab="hotel">Khách Sạn</a>
                        <a href="${pageContext.request.contextPath}/management?tab=customer&action=search" class="inner-desc tab-button" data-tab="customer">Người Dùng</a>
                        <a href="${pageContext.request.contextPath}/management?tab=bookingHistory&action=search" class="inner-desc tab-button" data-tab="bookingHistory">Đặt Vé</a>
                        <a href="${pageContext.request.contextPath}/management?tab=hotelBooking&action=search" class="inner-desc tab-button" data-tab="hotelBooking">Đặt Khách Sạn</a>
                    </div>
                </div>



                <div class="col-10 tab-right">
                    <div class="container-fluid">
                        <!-- Nội dung: Vé máy bay -->
                        <div class="tab-content" id="flight" style="display: block;">
                            <h2 class="text-center inner-desc text-dark">Danh sách vé máy bay</h2>
                            <!-- FORM TÌM KIẾM -->
                            <form class="row g-3 mb-4" action="${pageContext.request.contextPath}/ticket" method="get">
                                <input type="hidden" name="tab" value="flight" />

                                <input type="hidden" name="action" value="search" />
                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="airline" placeholder="Hãng máy bay">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="origin" placeholder="Điểm đi">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="destination" placeholder="Điểm đến">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="form-control" name="price" placeholder="Giá vé (tối đa)">
                                </div>

                                <div class="col-md-12" style="margin-top: 20px; display: flex; gap: 20px; align-items: center;">
                                    <select class="form-select" name="sortBy" 
                                            style="height: 38px; width: 180px; min-width: 150px; max-width: 220px; padding: 5px 10px; font-size: 1rem; border-radius: 4px; border: 1px solid #ced4da; transition: border-color 0.3s ease;">
                                        <option value="" selected>-- Sắp xếp --</option>
                                        <option value="airline">Tên hãng bay</option>
                                        <option value="price">Giá vé</option>
                                    </select>

                                    <button type="submit" class="btn btn-success"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                                    <a href="${pageContext.request.contextPath}/ticket" class="btn btn-secondary"><i class="fa-solid fa-rotate"></i> Reset</a>
                                </div>

                            </form>

                            <a  class="btn btn-primary" style="display: flex; align-items: center; gap: 5px;" href="addTicket.jsp"><i class="fa-solid fa-plus"></i>Thêm vé máy bay</a>


                            <div class="inner-table">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th scope="col">STT</th>
                                            <th scope="col">Hãng máy bay</th>
                                            <th scope="col">Điểm đi</th>
                                            <th scope="col">Điểm đến</th>
                                            <th scope="col">Thời gian bay</th>
                                            <th scope="col">Thời gian đi</th>
                                            <th scope="col">Thời gian đến</th>
                                            <th scope="col">Loại vé</th>
                                            <th scope="col">Giá vé</th>
                                            <th scope="col">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody id="ticketList">
                                        <%
                                            List<Ticket> tickets = (List<Ticket>) request.getAttribute("tickets");
                                            int index = 1;
                                            if (tickets != null) {
                                                for (Ticket t : tickets) {
                                        %>
                                        <tr>
                                            <th scope="row"><%= index++ %></th>
                                            <td><%= t.getAirline() %></td>
                                            <td><%= t.getOrigin() %></td>
                                            <td><%= t.getDestination() %></td>
                                            <td><%= t.getEstimatedtime() %></td>
                                            <td><%= t.getDeparturetime() %></td>
                                            <td><%= t.getArrivetime() %></td>
                                            <td><%= t.getType() %></td>
                                            <td><%= t.getPrice() %></td>
                                            <td>
                                                <a
                                                    class="delete-btn btn btn-danger"
                                                    href="${pageContext.request.contextPath}/ticket?action=delete&id=<%= t.getId() %>">
                                                    <i class="fa-solid fa-trash"></i>
                                                </a>

                                                <a href="${pageContext.request.contextPath}/ticket?action=edit&id=<%= t.getId() %>" class="btn btn-info"><i class="fa-solid fa-pen-to-square"></i></a>

                                            </td>
                                        </tr>
                                        <%
                                                }
                                            } else {
                                        %>
                                        <tr><td colspan="10">Không có vé nào.</td></tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Nội dung: Khách sạn -->
                        <div class="tab-content" id="hotel" style="display: none">
                            <h2 class="text-center inner-desc text-dark">Danh sách khách sạn</h2>
                            <form class="row g-3 mb-4" action="${pageContext.request.contextPath}/hotel" method="get">
                                <input type="hidden" name="tab" value="hotel" />
                                <input type="hidden" name="action" value="search" />

                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="name" placeholder="Tên khách sạn" value="${param.name}">
                                </div>

                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="address" placeholder="Địa chỉ" value="${param.address}">
                                </div>

                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="rating" placeholder="Đánh giá (tối thiểu)" value="${param.rating}">
                                </div>

                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="price" placeholder="Giá mỗi đêm (tối đa)" value="${param.price}">
                                </div>

                                <div class="col-md-12" style="margin-top: 10px; display: flex; gap: 15px; align-items: center;">
                                    <select class="form-select" name="sortBy" style="height: 38px; width: 180px; min-width: 150px; max-width: 220px; padding: 5px 10px; font-size: 1rem; border-radius: 4px; border: 1px solid #ced4da; transition: border-color 0.3s ease;">
                                        <option value="" ${empty param.sortBy ? "selected" : ""}>-- Sắp xếp --</option>
                                        <option value="name" ${param.sortBy == 'name' ? "selected" : ""}>Tên khách sạn</option>
                                        <option value="price" ${param.sortBy == 'price' ? "selected" : ""}>Giá mỗi đêm</option>
                                    </select>

                                    <button type="submit" class="btn btn-success"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                                    <a href="${pageContext.request.contextPath}/hotel?tab=hotel&action=search" class="btn btn-secondary"><i class="fa-solid fa-rotate"></i> Reset</a>
                                </div>
                            </form>

                            <a class="btn btn-primary" style="display: flex; align-items: center; gap: 5px;" href="addHotel.jsp">
                                <i class="fa-solid fa-plus"></i>Thêm khách sạn
                            </a>

                            <div class="inner-table">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th scope="col">STT</th>
                                            <th scope="col">Tên khách sạn</th>
                                            <th scope="col">Địa điểm</th>
                                            <th scope="col">Liên hệ</th>
                                            <th scope="col">Đánh giá</th>
                                            <th scope="col">Giá mỗi đêm</th>
                                            <th scope="col">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody id="hotelList">
                                        <%
                                           List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
                                           int hotelIndex = 1;
                                           if (hotels != null) {
                                               for (Hotel h : hotels) {
                                        %>
                                        <tr>
                                            <th scope="row"><%= hotelIndex++ %></th>
                                            <td><%= h.getName() %></td>
                                            <td><%= h.getAddress() %></td>
                                            <td><%= h.getContact_info() %></td>
                                            <td><%= h.getRating() %></td>
                                            <td><%= h.getPrice_per_night() %></td>
                                            <td>
                                                <a
                                                    class="delete-btn btn btn-danger"
                                                    href="${pageContext.request.contextPath}/hotel?action=delete&id=<%= h.getId() %>"
                                                    >
                                                    <i class="fa-solid fa-trash"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/hotel?action=edit&id=<%= h.getId() %>" class="btn btn-info"><i class="fa-solid fa-pen-to-square"></i></a>
                                            </td>
                                        </tr>
                                        <%
                                              }
                                          } else {
                                        %>
                                        <tr><td colspan="10">Không có vé nào.</td></tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>



                        <!-- Nội dung: Người dùng -->
                        <div class="tab-content" id="customer" style="display: none">
                            <h2 class="text-center inner-desc text-dark">Danh sách người dùng</h2>
                            <form class="row g-3 mb-4" action="${pageContext.request.contextPath}/userServlet" method="get">
                                <input type="hidden" name="tab" value="customer" />
                                <input type="hidden" name="action" value="search" />

                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="fullname" placeholder="Họ tên" value="<%= request.getParameter("fullname") != null ? request.getParameter("fullname") : "" %>">
                                </div>

                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="username" placeholder="Tên tài khoản" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                                </div>

                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="address" placeholder="Địa chỉ" value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>">
                                </div>

                                <div class="col-md-2">
                                    <select class="form-select" name="roleId" style="height: 36px; width: 180px; min-width: 150px; max-width: 220px; padding: 5px 10px; font-size: 1rem; border-radius: 4px; border: 1px solid #ced4da; transition: border-color 0.3s ease;">
                                        <option value="">-- Vai trò --</option>
                                        <option value="1" <%= "1".equals(request.getParameter("roleId")) ? "selected" : "" %>>ADMIN</option>
                                        <option value="2" <%= "2".equals(request.getParameter("roleId")) ? "selected" : "" %>>CUSTOMER</option>
                                    </select>
                                </div>



                                <div class="col-md-4" style="margin-top: 10px; display: flex; gap: 15px; align-items: center;">
                                    <select class="form-select" name="sortBy" style="height: 38px; width: 180px; min-width: 150px; max-width: 220px; padding: 5px 10px; font-size: 1rem; border-radius: 4px; border: 1px solid #ced4da; transition: border-color 0.3s ease;">
                                        <option value="">-- Sắp xếp --</option>
                                        <option value="fullname" <%= "fullname".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Tên</option>
                                        <option value="phonenumber" <%= "phonenumber".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Số điện thoại</option>
                                    </select>
                                    <button type="submit" class="btn btn-success"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                                    <a href="${pageContext.request.contextPath}/userServlet?tab=customer&action=search" class="btn btn-secondary"><i class="fa-solid fa-rotate"></i> Reset</a>
                                </div>
                            </form>

                            <a  class="btn btn-primary" style="display: flex; align-items: center; gap: 5px;" href="addUser.jsp"><i class="fa-solid fa-plus"></i>Thêm người dùng</a>
                            <div class="inner-table">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th scope="col">STT</th>
                                            <th scope="col">Họ tên</th>
                                            <th scope="col">Tên tài khoản</th>
                                            <th scope="col">Email</th>
                                            <th scope="col">Số điện thoại</th>
                                            <th scope="col">Trạng thái</th>
                                            <th scope="col">Vai trò</th>
                                            <th scope="col">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody id="customerList">
                                        <%
                                            List<User> users = (List<User>) request.getAttribute("users");
                                            int userIndex = 1;
                                            if (users != null) {
                                                for (User u : users) {
                                        %>
                                        <tr>
                                            <th scope="row"><%= userIndex++ %></th>
                                            <td><%= u.getFullname() %></td>
                                            <td><%= u.getUsername() %></td>
                                            <td><%= u.getEmail() %></td>
                                            <td><%= u.getPhonenumber() %></td>
                                            <td><%= "1".equals(u.getStatus()) ? "Đang hoạt động" : "Ngừng" %></td>
                                            <td><%= u.getRoleId() == 1 ? "ADMIN" : "CUSTOMER" %></td>
                                            <td>
                                                <% if (u.getRoleId() != 1) { %>
                                                <a
                                                    class="delete-btn btn btn-danger"
                                                    href="<%= request.getContextPath() %>/userServlet?action=delete&id=<%= u.getId() %>">
                                                    <i class="fa-solid fa-trash"></i>
                                                </a>
                                                <a href="<%= request.getContextPath() %>/userServlet?action=edit&id=<%= u.getId() %>" class="btn btn-info"><i class="fa-solid fa-pen-to-square"></i></a>
                                                    <% } else { %>
                                                Không có quyền
                                                <% } %>

                                            </td>
                                        </tr>
                                        <%
                                                }
                                            } else {
                                        %>
                                        <tr><td colspan="10">Không có người dùng nào.</td></tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!--Nội dung: Đặt vé--> 
                        <%
     String action = request.getParameter("action");
     String currentTab = request.getParameter("tab");
     boolean isBookingTab = "bookingHistory".equals(currentTab);
     List<BookingHistory> bhs = (List<BookingHistory>) request.getAttribute("bookingHistorys");
     List<Object[]> stats = (List<Object[]>) request.getAttribute("statistics");
                        %>

                        <% if (isBookingTab) { %>
                        <div class="tab-content" id="bookingHistory" style="display: none">
                            <h2 class="text-center inner-desc text-dark">🛎️ Lịch sử đặt vé</h2>

                            <form action="${pageContext.request.contextPath}/bookingHistory" method="get" class="row g-3 mb-4">
                                <input type="hidden" name="tab" value="bookingHistory" />
                                <input type="hidden" name="action" value="search" />

                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="userName" placeholder="Tên người đặt" value="${param.userName != null ? param.userName : ''}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="typeTicket" placeholder="Loại vé" value="${param.typeTicket != null ? param.typeTicket : ''}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="origin" placeholder="Điểm đi" value="${param.origin != null ? param.origin : ''}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="destination" placeholder="Điểm đến" value="${param.destination != null ? param.destination : ''}">
                                </div>

                                <div class="col-md-4" style="margin-top: 10px; display: flex; gap: 15px; align-items: center;">
                                    <select class="form-select" name="sortBy" style="height: 38px; width: 180px; min-width: 150px; max-width: 220px; padding: 5px 10px; font-size: 1rem; border-radius: 4px; border: 1px solid #ced4da; transition: border-color 0.3s ease;">
                                        <option value="" ${param.sortBy == null || param.sortBy == '' ? 'selected' : ''}>-- Sắp xếp --</option>
                                        <option value="quantity" ${param.sortBy == 'quantity' ? 'selected' : ''}>Số lượng vé</option>
                                        <option value="userName" ${param.sortBy == 'userName' ? 'selected' : ''}>Tên người đặt</option>
                                    </select>
                                    <button type="submit" class="btn btn-success"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                                    <a href="${pageContext.request.contextPath}/bookingHistory?tab=bookingHistory&action=search" class="btn btn-secondary"><i class="fa-solid fa-rotate"></i> Reset</a>
                                </div>
                            </form>

                            <div class="mb-3 d-flex gap-2">
                                <form action="${pageContext.request.contextPath}/bookingHistory" method="get" style="margin-right: 20px;">
                                    <input type="hidden" name="action" value="statByUser">
                                    <input type="hidden" name="tab" value="bookingHistory" />
                                    <button type="submit" class="btn btn-primary"><i class="fa-solid fa-chart-simple"></i> Thống kê theo người đặt</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/bookingHistory" method="get">
                                    <input type="hidden" name="tab" value="bookingHistory" />
                                    <input type="hidden" name="action" value="statByTicketType">
                                    <button type="submit" class="btn btn-warning" style="color: #fdfdfe"><i class="fas fa-chart-line"></i> Thống kê theo loại vé</button>
                                </form>
                            </div>

                            <% if (action == null || "search".equals(action)) { %>
                            <div class="inner-table">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th scope="col">STT</th>
                                            <th scope="col">Tên người đặt</th>
                                            <th scope="col">Điểm xuất phát</th>
                                            <th scope="col">Điểm đến</th>
                                            <th scope="col">Loại vé</th>
                                            <th scope="col">Phương thức thanh toán</th>
                                            <th scope="col">Trạng thái</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Tổng tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody id="bookingHistoryList">
                                        <%
                                            int bhsIndex = 1;
                                            if (bhs != null && !bhs.isEmpty()) {
                                                for (BookingHistory bh : bhs) {
                                        %>
                                        <tr>
                                            <th scope="row"><%= bhsIndex++ %></th>
                                            <td><%= bh.getUserName() %></td>
                                            <td><%= bh.getOrigin() %></td>
                                            <td><%= bh.getDestination() %></td>
                                            <td><%= bh.getTypeTicket() %></td>
                                            <td><%= bh.getPayment() %></td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/bookingHistory" method="post" style="display:flex; align-items:center; justify-content: center; gap:5px;">
                                                    <input type="hidden" name="action" value="updateStatus" />
                                                    <input type="hidden" name="bookingId" value="<%= bh.getId() %>" />
                                                    <select name="orderStatus" class="form-select" style="width: auto; border-radius: 5px; text-align: center; padding: 3.5px;">
                                                        <option value="Pending" <%= "Pending".equals(bh.getOrderStatus()) ? "selected" : "" %>>Pending</option>
                                                        <option value="Confirmed" <%= "Confirmed".equals(bh.getOrderStatus()) ? "selected" : "" %>>Confirmed</option>
                                                        <option value="Cancelled" <%= "Cancelled".equals(bh.getOrderStatus()) ? "selected" : "" %>>Cancelled</option>
                                                    </select>
                                                    <button type="submit" class="btn btn-sm btn-primary">Cập nhật</button>
                                                </form>
                                            </td>

                                            <td><%= bh.getQuantity() %></td>
                                            <td><%= bh.getTotalPrice() %></td>
                                        </tr>
                                        <%      }
                                            } else {
                                        %>
                                        <tr><td colspan="10">Không có lịch sử nào.</td></tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <% } else if ("statByUser".equals(action) && stats != null) { %>
                            <h3 class="mt-4">📊 Thống kê theo người đặt</h3>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Tên người đặt</th>
                                        <th>Loại vé</th>
                                        <th>Giá vé</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% int i = 1;
               for (Object[] row : stats) { %>
                                    <tr>
                                        <td><%= i++ %></td>
                                        <td><%= row[0] %></td>
                                        <td><%= row[1] %></td>
                                        <td><%= row[2] %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            <% } else if ("statByTicketType".equals(action) && stats != null) { %>
                            <h3 class="mt-4">📈 Thống kê theo loại vé</h3>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Loại vé</th>
                                        <th>Tổng số vé</th>
                                        <th>Tổng số tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% int i = 1;
               for (Object[] row : stats) { %>
                                    <tr>
                                        <td><%= i++ %></td>
                                        <td><%= row[0] %></td>
                                        <td><%= row[1] %></td>
                                        <td><%= row[2] %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            <% } %>
                        </div>
                        <% } %>

                        <!--
                        
                        
                        <!--Nội dung đặt khách sạn-->
                        <%
     String actionType = request.getParameter("action");
     String tabParam = request.getParameter("tab");  
     boolean isHotelBookingTab = "hotelBooking".equals(tabParam);
     List<HotelBooking> bookingList = (List<HotelBooking>) request.getAttribute("hotelBookings");
     List<Object[]> statsList = (List<Object[]>) request.getAttribute("statistics");
                        %>

                        <% if (isHotelBookingTab) { %>
                        <div class="tab-content" id="hotelBooking" style="display: none">
                            <h2 class="text-center inner-desc text-dark">🛎️ Lịch sử đặt khách sạn</h2>

                            <!-- Form tìm kiếm -->
                            <form action="${pageContext.request.contextPath}/hotelBooking" method="get" class="row g-3 mb-4 d-flex justify-content-center align-items-center" style="gap: 15px;">
                                <input type="hidden" name="tab" value="hotelBooking" />
                                <input type="hidden" name="action" value="search" />

                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="userName" placeholder="Tên người đặt" value="${param.userName != null ? param.userName : ''}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="hotelName" placeholder="Tên khách sạn" value="${param.hotelName != null ? param.hotelName : ''}">
                                </div>

                                <div class="col-md-4 d-flex align-items-center" style="gap: 15px;">
                                    <select class="form-select" name="sortBy" style="height: 38px; width: 180px; min-width: 150px; max-width: 220px; padding: 5px 10px; font-size: 1rem; border-radius: 4px; border: 1px solid #ced4da; transition: border-color 0.3s ease;">
                                        <option value="" ${empty param.sortBy ? 'selected' : ''}>-- Sắp xếp theo --</option>
                                        <option value="roomQuantity" ${param.sortBy == 'roomQuantity' ? 'selected' : ''}>Số lượng phòng</option>
                                        <option value="totalPrice" ${param.sortBy == 'totalPrice' ? 'selected' : ''}>Tổng tiền</option>
                                    </select>
                                    <button type="submit" class="btn btn-success">
                                        <i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm
                                    </button>
                                    <a href="${pageContext.request.contextPath}/hotelBooking?tab=hotelBooking&action=search" class="btn btn-secondary">
                                        <i class="fa-solid fa-rotate"></i> Reset
                                    </a>
                                </div>
                            </form>

                            <!-- Nút thống kê -->
                            <div class="mb-3 d-flex gap-2" style="margin-left: 103px;">
                                <form action="${pageContext.request.contextPath}/hotelBooking" method="get" style="margin-right: 20px;">
                                    <input type="hidden" name="tab" value="hotelBooking" />
                                    <input type="hidden" name="action" value="statByUser" />
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa-solid fa-chart-simple"></i> Thống kê theo người đặt
                                    </button>
                                </form>
                                <form action="${pageContext.request.contextPath}/hotelBooking" method="get">
                                    <input type="hidden" name="tab" value="hotelBooking" />
                                    <input type="hidden" name="action" value="statByHotel" />
                                    <button type="submit" class="btn btn-warning" style="color: white;">
                                        <i class="fas fa-chart-line"></i> Thống kê theo khách sạn
                                    </button>
                                </form>
                            </div>

                            <% if (actionType == null || "search".equals(actionType)) { %>
                            <!-- Bảng lịch sử đặt phòng -->
                            <div class="inner-table">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Người đặt</th>
                                            <th>Khách sạn</th>
                                            <th>Ngày nhận phòng</th>
                                            <th>Ngày trả phòng</th>
                                            <th>Số lượng phòng</th>
                                            <th>Tổng tiền</th>
                                            <th>Trạng thái</th>
                                            <th>Ghi chú</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            int bookingIndex = 1;
                                            if (bookingList != null && !bookingList.isEmpty()) {
                                                for (HotelBooking item : bookingList) {
                                        %>
                                        <tr>
                                            <td><%= bookingIndex++ %></td>
                                            <td><%= item.getUserName() %></td>
                                            <td><%= item.getHotelName() %></td>
                                            <td><%= item.getCheckInDate() %></td>
                                            <td><%= item.getCheckOutDate() %></td>
                                            <td><%= item.getRoomQuantity() %></td>
                                            <td><%= item.getTotalPrice() %></td>
                                             <td>
                                                <form action="${pageContext.request.contextPath}/hotelBooking" method="post" style="display:flex; align-items:center; justify-content: center; gap:5px;">
                                                    <input type="hidden" name="action" value="updateStatus" />
                                                    <input type="hidden" name="bookingId" value="<%= item.getId() %>" />
                                                    <select name="status" class="form-select" style="width: auto; border-radius: 5px; text-align: center; padding: 3.5px;">
                                                        <option value="Pending" <%= "Pending".equals(item.getStatus()) ? "selected" : "" %>>Pending</option>
                                                        <option value="Confirmed" <%= "Confirmed".equals(item.getStatus()) ? "selected" : "" %>>Confirmed</option>
                                                        <option value="Cancelled" <%= "Cancelled".equals(item.getStatus()) ? "selected" : "" %>>Cancelled</option>
                                                    </select>
                                                    <button type="submit" class="btn btn-sm btn-primary">Cập nhật</button>
                                                </form>
                                            </td>
                                            <td><%= item.getNotes() %></td>
                                        </tr>
                                        <%      }
                                            } else {
                                        %>
                                        <tr>
                                            <td colspan="9" class="text-center">Không có bản ghi nào được tìm thấy.</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <% } else if ("statByUser".equals(actionType) && statsList != null) { %>
                            <!-- Thống kê theo người đặt -->
                            <h3 class="mt-4">📊 Thống kê theo người đặt</h3>
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Người đặt</th>
                                        <th>Tên khách sạn</th>
                                        <th>Tổng phòng</th>
                                        <th>Tổng tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int indexList = 1;
                                        for (Object[] row : statsList) {
                                    %>
                                    <tr>
                                        <td><%= indexList++ %></td>
                                        <td><%= row[0] %></td>
                                        <td><%= row[1] %></td> <td><%= row[2] %></td>
                                        <td><%= row[3] %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>

                            <% } else if ("statByHotel".equals(actionType) && statsList != null) { %>
                            <!-- Thống kê theo khách sạn -->
                            <h3 class="mt-4">📈 Thống kê theo khách sạn</h3>
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Khách sạn</th>
                                        <th>Lượt đặt</th>
                                        <th>Tổng tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int indexHotel = 1;
                                        for (Object[] row : statsList) {
                                    %>
                                    <tr>
                                        <td><%= indexHotel++ %></td>
                                        <td><%= row[0] %></td>
                                        <td><%= row[1] %></td>
                                        <td><%= row[2] %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            <% } %>
                        </div>
                        <% } %>






                    </div>
                </div>
            </div>
        </section>



        <script>
            document.querySelectorAll(".tab-button").forEach((button) => {
                button.addEventListener("click", () => {
                    const tabId = button.getAttribute("data-tab");


                    const newUrl = window.location.pathname + '?tab=' + tabId;


                    window.location.href = newUrl;
                });
            });

            const urlParams = new URLSearchParams(window.location.search);
            const activeTab = urlParams.get("tab");

            if (activeTab) {
                document.querySelectorAll(".tab-button").forEach((btn) => {
                    btn.classList.remove("active");
                    if (btn.getAttribute("data-tab") === activeTab) {
                        btn.classList.add("active");
                    }
                });

                document.querySelectorAll(".tab-content").forEach((tab) => {
                    tab.style.display = "none";
                    if (tab.id === activeTab) {
                        tab.style.display = "block";
                    }
                });
            } else {

                document.querySelectorAll(".tab-button").forEach((btn) => btn.classList.remove("active"));
                const defaultTabBtn = document.querySelector(".tab-button[data-tab='flight']");
                if (defaultTabBtn)
                    defaultTabBtn.classList.add("active");

                document.querySelectorAll(".tab-content").forEach((tab) => tab.style.display = "none");
                const defaultTabContent = document.getElementById('flight');
                if (defaultTabContent)
                    defaultTabContent.style.display = "block";
            }
            function goToTab(tabName) {
                const baseUrl = '${pageContext.request.contextPath}/management';
                window.location.href = `${baseUrl}?tab=${tabName}&action=search`;
            }

        </script>
        <%@include file="footer.jsp" %>
    </body>
</html>