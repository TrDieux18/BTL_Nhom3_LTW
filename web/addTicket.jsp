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
              /* --- Chỉnh CSS cho ảnh và nút đổi ảnh --- */
            .image-control {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .image-control img#ticketImage {
                max-width: 300px;
                max-height: 180px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                object-fit: cover;
                border: 2px solid #c0392b;
                transition: box-shadow 0.3s ease;
            }

            .image-control img#ticketImage:hover {
                box-shadow: 0 8px 24px rgba(192, 57, 43, 0.6);
            }

            #changeImageBtn {
                padding: 10px 24px;
                background-color: #c0392b;
                color: white;
                font-weight: 600;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                transition: background-color 0.3s ease, box-shadow 0.3s ease;
                height: 40px;
                align-self: flex-start; /* nút đứng trên cùng, sát ảnh */
                box-shadow: 0 2px 6px rgba(192, 57, 43, 0.5);
            }

            #changeImageBtn:hover {
                background-color: #a62a23;
                box-shadow: 0 4px 12px rgba(166, 42, 35, 0.7);
            }

            input[type="file"] {
                display: none; /* ẩn input file, chỉ hiện khi ko có ảnh hoặc khi bấm đổi */
            }

            /* Khi chưa có ảnh thì hiển thị input file */
            .image-control span + input[type="file"] {
                display: block;
                flex: 1;
                padding: 6px;
                border-radius: 8px;
                border: 1px solid #ccc;
                cursor: pointer;
            }

            .image-control {
                display: flex;
                flex-direction: column; /* cho nút nằm dưới ảnh */
                align-items: center;    /* căn giữa ngang */
                gap: 12px;              /* khoảng cách giữa ảnh và nút */
            }

            .image-control img#ticketImage {
                max-width: 300px;
                max-height: 180px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                object-fit: cover;
                border: 2px solid #c0392b;
                transition: box-shadow 0.3s ease;
            }

            .image-control img#ticketImage:hover {
                box-shadow: 0 8px 24px rgba(192, 57, 43, 0.6);
            }

            #changeImageBtn {
                padding: 10px 24px;
                background-color: #c0392b;
                color: white;
                font-weight: 600;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                transition: background-color 0.3s ease, box-shadow 0.3s ease;
                height: 40px;
                /* align-self không cần nữa vì căn giữa toàn bộ */
                box-shadow: 0 2px 6px rgba(192, 57, 43, 0.5);
                width: fit-content; /* nút vừa đủ rộng theo chữ */
            }

            #changeImageBtn:hover {
                background-color: #a62a23;
                box-shadow: 0 4px 12px rgba(166, 42, 35, 0.7);
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

            <form action="ticket" method="post" id="ticketForm" enctype="multipart/form-data" accept-charset="UTF-8">
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
                <div class="form-group">
                    <label for="imageFile">Hình ảnh</label>
                    <div class="image-control">
                        <% if (ticket != null && ticket.getImage() != null && !ticket.getImage().isEmpty()) { %>
                        <img id="ticketImage" src="<%= ticket.getImage() + "?t=" + System.currentTimeMillis() %>" 
                             alt="<%= ticket.getDestination() %>" class="card-img-top" style="max-width: 300px; display: block; margin-bottom: 10px;"/>
                        <button type="button" id="changeImageBtn">Đổi ảnh</button>
                        <input type="file" id="imageFile" name="imageFile" accept="image/*" style="display:none;" />
                        <% } else { %>
                        <span style="font-style: italic; color: #777;">Chưa có hình ảnh</span>
                        <input type="file" id="imageFile" name="imageFile" accept="image/*" />
                        <% } %>
                    </div>
                </div>

                <button type="submit"><%= (ticket == null) ? "Thêm vé" : "Lưu sửa" %></button>
            </form>
        </div>
        <script>
            const changeImageBtn = document.getElementById('changeImageBtn');
            const imageFileInput = document.getElementById('imageFile');
            const ticketImage = document.getElementById('ticketImage');

            if (changeImageBtn) {
                changeImageBtn.addEventListener('click', () => {
                    imageFileInput.click();
                });
            }

            if (imageFileInput) {
                imageFileInput.addEventListener('change', (e) => {
                    const file = e.target.files[0];
                    if (file && ticketImage) {
                        ticketImage.src = URL.createObjectURL(file);
                    }
                });
            }
        </script>
        <%@ include file="footer.jsp" %>
    </body>
</html>
