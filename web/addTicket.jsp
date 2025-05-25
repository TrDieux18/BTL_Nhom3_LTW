<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="model.Ticket" %>

<%
    // Lấy ticket từ request attribute (có thể null nếu thêm mới)
    Object obj = request.getAttribute("ticket");
    Ticket ticket = null;
    if (obj != null) {
        ticket = (Ticket) obj;
    }

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

    // Lấy thông báo từ session hoặc request
    String message = null;
    String alertType = null;

    if (session.getAttribute("message") != null) {
        message = (String) session.getAttribute("message");
        alertType = (String) session.getAttribute("alertType");
        // Xóa thông báo khỏi session để không hiển thị lại sau khi reload trang khác
        session.removeAttribute("message");
        session.removeAttribute("alertType");
    } else if (request.getAttribute("message") != null) {
        message = (String) request.getAttribute("message");
        alertType = (String) request.getAttribute("alertType");
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title><%= (ticket == null) ? "Thêm Vé Máy Bay" : "Sửa Vé Máy Bay" %></title>

        <style>
            body {
                background: linear-gradient(135deg, #e0eafc, #cfdef3);
                padding: 40px;
                color: #333;
            }
            .form-container {
                max-width: 900px;
                margin: 50px auto 0;
                background: #fff;
                border-radius: 14px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
                padding: 32px 48px;
                margin-bottom: 20px;
            }
            h2 {
                font-weight: 700;
                text-align: center;
                margin-bottom: 40px;
                color: #c0392b;
                font-size: 2rem;
            }
            form {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 24px 32px;
            }
            .form-group {
                display: flex;
                align-items: center;
            }
            label {
                width: 130px;
                font-weight: 600;
                font-size: 16px;
                margin-right: 12px;
                color: #333;
                text-align: right;
                white-space: nowrap;
            }
            input[type="text"],
            input[type="datetime-local"],
            select {
                flex: 1;
                padding: 10px 14px;
                border-radius: 8px;
                border: 2px solid #ccc;
                font-size: 15px;
                font-weight: 500;
                color: #333;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }
            input[type="text"]:focus,
            input[type="datetime-local"]:focus,
            select:focus {
                outline: none;
                border-color: #c0392b;
                box-shadow: 0 0 8px #c0392b;
            }
            button {
                margin-top: 40px;
                padding: 14px 0;
                grid-column: 1 / -1;
                background-color: #c0392b;
                color: #fff;
                font-size: 1.25rem;
                font-weight: 700;
                border: none;
                border-radius: 12px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            button:hover {
                background-color: #a62a23;
            }
            @media (max-width: 768px) {
                form {
                    grid-template-columns: 1fr;
                }
                .form-group {
                    flex-direction: column;
                    align-items: flex-start;
                }
                label {
                    width: 100%;
                    margin-bottom: 6px;
                    text-align: left;
                }
            }
            .back-button {
                display: inline-block;
                margin-bottom: 24px;
                font-weight: 600;
                color: #c0392b;
                text-decoration: none;
                font-size: 1rem;
            }
            .back-button:hover {
                text-decoration: underline;
            }
            /* Alert styles */
            .alert {
                padding: 15px 20px;
                border-radius: 8px;
                margin-bottom: 30px;
                font-weight: 600;
                font-size: 1rem;
                text-align: center;
                animation: fadeOut 1s ease forwards;
                animation-delay: 3.5s;
            }
            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .alert-error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            @keyframes fadeOut {
                to {
                    opacity: 0;
                    height: 0;
                    padding: 0 20px;
                    margin: 0;
                    overflow: hidden;
                }
            }
        </style>
        <script>
            window.onload = function () {
                var alertBox = document.getElementById('alertBox');
                if (alertBox) {
                    setTimeout(function () {
                        alertBox.style.display = 'none';
                    }, 4500);
                }
            };
        </script>

    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="form-container">

            <a href="management" class="btn btn-info back-button">← Quay lại</a>

            <% if (message != null && alertType != null) { %>
            <div id="alertBox" class="alert <%= "success".equalsIgnoreCase(alertType) ? "alert-success" : "alert-error" %>">
                <%= message %>
            </div>
            <% } %>

            <h2><%= (ticket == null) ? "Thêm Vé Máy Bay" : "Sửa Vé Máy Bay" %></h2>

            <form action="ticket" method="post" id="ticketForm" accept-charset="UTF-8">
                <input type="hidden" name="id" value="<%= (ticket != null) ? ticket.getId() : "" %>" />

                <div class="form-group">
                    <label for="airline">Hãng bay</label>
                    <input type="text" id="airline" name="airline" placeholder="Nhập tên hãng bay" required
                           value="<%= (ticket != null) ? ticket.getAirline() : "" %>" />
                </div>

                <div class="form-group">
                    <label for="origin">Điểm đi</label>
                    <input type="text" id="origin" name="origin" placeholder="Nhập điểm đi" required
                           value="<%= (ticket != null) ? ticket.getOrigin() : "" %>" />
                </div>

                <div class="form-group">
                    <label for="destination">Điểm đến</label>
                    <input type="text" id="destination" name="destination" placeholder="Nhập điểm đến" required
                           value="<%= (ticket != null) ? ticket.getDestination() : "" %>" />
                </div>

                <div class="form-group">
                    <label for="departuretime">Giờ khởi hành</label>
                    <input type="datetime-local" id="departuretime" name="departuretime" required
                           value="<%= (ticket != null && ticket.getDeparturetime() != null) ? ticket.getDeparturetime().format(formatter) : "" %>" />
                </div>

                <div class="form-group">
                    <label for="arrivetime">Giờ đến</label>
                    <input type="datetime-local" id="arrivetime" name="arrivetime" required
                           value="<%= (ticket != null && ticket.getArrivetime() != null) ? ticket.getArrivetime().format(formatter) : "" %>" />
                </div>

                <div class="form-group">
                    <label for="type">Loại vé</label>
                    <select id="type" name="type" required>
                        <option value="" disabled <%= (ticket == null) ? "selected" : "" %>>Chọn loại vé</option>
                        <option value="Economy" <%= (ticket != null && "Economy".equals(ticket.getType())) ? "selected" : "" %>>Economy</option>
                        <option value="Business" <%= (ticket != null && "Business".equals(ticket.getType())) ? "selected" : "" %>>Business</option>
                        <option value="First Class" <%= (ticket != null && "First Class".equals(ticket.getType())) ? "selected" : "" %>>First Class</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="price">Giá vé</label>
                    <input type="text" id="price" name="price" placeholder="Nhập giá vé" required
                           value="<%= (ticket != null) ? ticket.getPrice() : "" %>" />
                </div>

                <div class="form-group">
                    <label for="estimatedtime">Thời gian bay</label>
                    <input type="text" id="estimatedtime" name="estimatedtime" placeholder="Nhập thời gian bay dự kiến"
                           value="<%= (ticket != null) ? ticket.getEstimatedtime() : "" %>" />
                </div>

                <button type="submit"><%= (ticket == null) ? "Thêm vé" : "Lưu sửa" %></button>
            </form>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
