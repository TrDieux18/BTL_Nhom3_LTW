<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="model.Hotel" %>

<%
    // Lấy ticket từ request attribute (có thể null nếu thêm mới)
    Object obj = request.getAttribute("hotel");
    Hotel hotel = null;
    if (obj != null) {
        hotel = (Hotel) obj;
    }

//    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title><%= (hotel == null) ? "Thêm Khách Sạn" : "Sửa Khách Sạn" %></title>
  
    <style> body {
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
        } </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="form-container">
        <a href="management" class="btn btn-info back-button">← Quay lại</a>

        <h2><%= (hotel == null) ? "Thêm Khách Sạn" : "Sửa Khách Sạn" %></h2>

        <form action="hotel" method="post" id="hotelForm" accept-charset="UTF-8">
            <input type="hidden" name="id" value="<%= (hotel != null) ? hotel.getId() : "" %>" />

            <div class="form-group">
                <label for="name">Tên khách sạn</label>
                <input type="text" id="name" name="name" placeholder="Nhập tên khách sạn" required
                       value="<%= (hotel != null) ? hotel.getName() : "" %>" />
            </div>

            <div class="form-group">
                <label for="address">Địa chỉ</label>
                <input type="text" id="address" name="address" placeholder="Nhập địa chỉ" required
                       value="<%= (hotel != null) ? hotel.getAddress() : "" %>" />
            </div>

            <div class="form-group">
                <label for="contactInfo">Liên hệ</label>
                <input type="text" id="contactInfo" name="contactInfo" placeholder="Nhập liên hệ" required
                       value="<%= (hotel != null) ? hotel.getContact_info() : "" %>" />
            </div>
            
            <div class="form-group">
                <label for="rating">Đánh giá</label>
                <input type="text" id="rating" name="rating" placeholder="Nhập liên hệ" required
                       value="<%= (hotel != null) ? hotel.getRating() : "" %>" />
            </div>
            
            
            <div class="form-group">
                <label for="pricePerNight">Giá/Đêm</label>
                <input type="text" id="pricePerNight" name="pricePerNight" placeholder="Nhập liên hệ" required
                       value="<%= (hotel != null) ? hotel.getPrice_per_night() : "" %>" />
            </div>

            <button type="submit"><%= (hotel == null) ? "Thêm khách sạn" : "Lưu sửa" %></button>
        </form>
    </div>
</body>
</html>
