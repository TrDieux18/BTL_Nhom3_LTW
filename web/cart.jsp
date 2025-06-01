<%@page import="model.Ticket"%>
<%@page import="model.CartItem"%>
<%@page import="model.Hotel"%>
<%@page import="dal.HotelDAO"%>
<%@page import="dal.TicketDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLDecoder" %>

<%
    TicketDAO ticketDAO = new TicketDAO();
    HotelDAO hotelDAO = new HotelDAO();

    List<CartItem> cart = new ArrayList<>();
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            String cookieName = cookie.getName();
            if (cookieName.startsWith("cart_")) {
                String[] nameParts = cookieName.split("_");
                if (nameParts.length == 3) {
                    String type = nameParts[1];
                    String id = nameParts[2];

                    String value = URLDecoder.decode(cookie.getValue(), "UTF-8");
                    String[] parts = value.split(":");
                    if (parts.length == 3) {
                        String productName = parts[0];
                        double price = Double.parseDouble(parts[1]);
                        String image = parts[2];

                        cart.add(new CartItem(type, id, productName, price, image));
                    }
                }
            }
        }
    }

    List<Ticket> ticketsInCart = new ArrayList<>();
    List<Hotel> hotelsInCart = new ArrayList<>();

    for (CartItem item : cart) {
        if (item.getType().equals("ticket")) {
            try {
                int ticketId = Integer.parseInt(item.getId());
                Ticket t = ticketDAO.getTicketById(ticketId);
                if (t != null) {
                    ticketsInCart.add(t);
                }
            } catch (NumberFormatException e) {
            }
        } else if (item.getType().equals("hotel")) {
            try {
                int hotelId = Integer.parseInt(item.getId());
                Hotel h = hotelDAO.getHotelById(hotelId);
                if (h != null) {
                    hotelsInCart.add(h);
                }
            } catch (NumberFormatException e) {
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Giỏ hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background-color: #f9f5f3;
                color: #333;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                line-height: 1.6;
                margin: 0;
                padding: 0;
            }

            .cart-title {
                text-align: center;
                font-size: 1.6rem;
                color: #da3d33;
                margin: 40px 0;
                font-weight: 700;
                letter-spacing: 2px;
            }

            .card {
                background-color: #fff4f3;
                border-radius: 12px;
                margin-bottom: 35px;
                box-shadow: 0 3px 10px rgba(218, 61, 51, 0.15);
                border: 1px solid #f0c5bf;
                transition: box-shadow 0.3s ease;
            }
            .card:hover {
                box-shadow: 0 8px 30px rgba(218, 61, 51, 0.3);
            }

            .card-header {
                background-color: #da3d33;
                color: white;
                font-size: 1.4rem;
                font-weight: 600;
                padding: 18px 30px;
                border-radius: 12px 12px 0 0;
                letter-spacing: 1px;
            }

            .card-body {
                padding: 25px 30px;
            }

            a.item-link {
                display: block;
                padding: 18px 25px;
                margin-bottom: 12px;
                border: 1.5px solid transparent;
                border-radius: 10px;
                text-decoration: none;
                color: #2a2a2a;
                transition: 0.25s ease;
            }
            a.item-link:hover {
                background-color: #ffe5e1;
                border-color: #da3d33;
                box-shadow: 0 5px 15px rgba(218, 61, 51, 0.2);
                color: #a3221e;
                text-decoration: none;
            }

            .item i {
                color: #da3d33;
                margin-right: 12px;
                font-size: 1.1rem;
            }
            .item strong,
            .price {
                font-weight: 700;
                font-size: 1.1rem;
            }
            .price {
                color: #28a745;
                display: inline-block;
                margin-top: 10px;
            }

            

            button.delete-btn,
            .btn-buy-now {
                background-color: #dc3545;
                color: white;
                border: none;
                padding: 9px 18px;
                border-radius: 10px;
                cursor: pointer;
                font-size: 1rem;
                transition: 0.3s ease;
                box-shadow: 0 2px 6px rgba(220, 53, 69, 0.6);
            }
            button.delete-btn i,
            .btn-buy-now i {
                margin-right: 6px;
            }
            button.delete-btn:hover,
            .btn-buy-now:hover {
                background-color: #a31d24;
                transform: scale(1.05);
            }

            hr {
                border: none;
                border-top: 1px solid #f2c9c7;
                margin: 25px 0;
                opacity: 0.6;
            }

            p.no-items {
                font-size: 1.15rem;
                color: #555;
                text-align: center;
                padding: 30px 0;
                font-style: italic;
            }

            .container {
                padding: 0 20px;
                max-width: 960px;
                margin: auto;
            }

        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <div class="container">
            <h1 class="cart-title"><i class="fa-solid fa-cart-shopping"></i> Giỏ hàng của bạn</h1>

            <% if (user == null) { %>
            <div style="
                 display: flex;
                 flex-direction: column;
                 align-items: center;
                 justify-content: center;
                 margin-top: 60px;
                 background-color: #fff;
                 padding: 40px 30px;
                 border-radius: 20px;
                 box-shadow: 0 4px 12px rgba(218, 61, 51, 0.1);
                 max-width: 600px;
                 margin-left: auto;
                 margin-right: auto;
                 margin-bottom: 100px;">
                <img src="assets/images/empty-cart.jpg" alt="Giỏ hàng trống" style="width: 240px; max-width: 100%; margin-bottom: 25px;">
                <h2 style="color: #444; font-size: 1.6rem; font-weight: 600; margin-bottom: 10px;">Vui lòng đăng nhập để xem giỏ hàng</h2>
                <a href="log" style="
                   background-color: #da3d33;
                   color: white;
                   padding: 10px 22px;
                   border-radius: 8px;
                   font-size: 1rem;
                   text-decoration: none;
                   transition: background-color 0.3s ease, transform 0.2s ease;
                   box-shadow: 0 2px 6px rgba(218, 61, 51, 0.3);
                   " onmouseover="this.style.backgroundColor = '#c02c24'; this.style.transform = 'scale(1.05)';"
                   onmouseout="this.style.backgroundColor = '#da3d33'; this.style.transform = 'scale(1)';">
                    Đăng nhập
                </a>
            </div>
            <% } else { %>

            <% if (ticketsInCart.isEmpty() && hotelsInCart.isEmpty()) { %>
            <div style="
                 display: flex;
                 flex-direction: column;
                 align-items: center;
                 justify-content: center;
                 margin-top: 60px;
                 background-color: #fff;
                 padding: 40px 30px;
                 border-radius: 20px;
                 box-shadow: 0 4px 12px rgba(218, 61, 51, 0.1);
                 max-width: 600px;
                 margin-left: auto;
                 margin-right: auto;
                 margin-bottom: 100px;
                 ">
                <img src="assets/images/empty-cart.jpg" alt="Giỏ hàng trống" style="width: 240px; max-width: 100%; margin-bottom: 25px;">
                <h2 style="color: #444; font-size: 1.6rem; font-weight: 600; margin-bottom: 10px;">Giỏ hàng của bạn hiện đang trống</h2>
                <p style="color: #666; font-size: 1rem; margin-bottom: 20px; text-align: center;">
                    Bắt đầu mua sắm ngay bây giờ và các sản phẩm sẽ xuất hiện ở đây.
                </p>
                
                <a href="hotelList" style="
                   background-color: #da3d33;
                   color: white;
                   padding: 10px 22px;
                   border-radius: 8px;
                   font-size: 1rem;
                   text-decoration: none;
                   transition: background-color 0.3s ease, transform 0.2s ease;
                   box-shadow: 0 2px 6px rgba(218, 61, 51, 0.3);
                   " onmouseover="this.style.backgroundColor = '#c02c24'; this.style.transform = 'scale(1.05)';"
                   onmouseout="this.style.backgroundColor = '#da3d33'; this.style.transform = 'scale(1)';">
                    <i class="fa fa-shopping-bag"></i> Mua ngay
                </a>
               
            </div>
            <% } else { %>
            <!-- Vé máy bay -->
            <div class="card">
                <div class="card-header">Vé máy bay</div>
                <div class="card-body">
                    <% if (!ticketsInCart.isEmpty()) {
                            for (Ticket t : ticketsInCart) {%>
                    <a href="ticketDetail.jsp?id=<%= t.getId()%>" class="item-link">
                        <div class="item" style="cursor:pointer;">
                            <i class="fa-solid fa-plane"></i>
                            <strong>Chuyến bay:</strong> <%= t.getAirline()%><br>
                            <i class="fa-solid fa-location-dot"></i> <%= t.getOrigin()%> → <%= t.getDestination()%><br>
                            <i class="fa-regular fa-clock"></i> <%= t.getDeparturetime()%> → <%= t.getArrivetime()%><br>
                            <i class="fa-solid fa-chair"></i> Ghế: <%= t.getType()%><br>
                            <span class="price"><i class="fa-solid fa-dollar-sign"></i> <%= t.getPrice()%> VNĐ</span>
                        </div>
                    </a>
                    <form action="removefromcart" method="post" style="display:inline;">
                        <input type="hidden" name="type" value="ticket">
                        <input type="hidden" name="id" value="<%= t.getId()%>">
                        <button type="submit" class="delete-btn">
                            <i class="fa-solid fa-trash"></i> Xóa
                        </button>
                    </form>
                    <hr>
                    <%  }
                    } else { %>

                    <p class="no-items">Không có vé máy bay trong giỏ hàng.</p>
                    <% } %>
                </div>
            </div>

            <!-- Khách sạn -->
            <div class="card">
                <div class="card-header">Khách sạn</div>
                <div class="card-body">
                    <% if (!hotelsInCart.isEmpty() ) {
                            for (Hotel h : hotelsInCart) {%>
                    <a href="detail?hotelId=<%= h.getId()%>" class="item-link">
                        <div class="item" style="cursor:pointer;">
                            <i class="fa-solid fa-hotel"></i>
                            <strong>Khách sạn:</strong> <%= h.getName()%><br>
                            <i class="fa-solid fa-location-dot"></i> Địa điểm: <%= h.getAddress()%><br>
                            <i class="fa-solid fa-file-alt"></i> <%= h.getDescription()%><br>

                        </div>
                    </a>
                    <form action="removefromcart" method="post" style="display:inline;">
                        <input type="hidden" name="type" value="hotel">
                        <input type="hidden" name="hotelId" value="<%= h.getId()%>">
                        <button type="submit" class="delete-btn">
                            <i class="fa-solid fa-trash"></i> Xóa
                        </button>
                    </form>
                    <hr>
                    <%  }
                    } else { %>
                    <p class="no-items">Không có khách sạn nào trong giỏ hàng.</p>
                    <% } %>
                </div>
            </div>
            <% } %>

            <% } %>
        </div>



        <%@ include file="footer.jsp" %>
    </body>
</html>
