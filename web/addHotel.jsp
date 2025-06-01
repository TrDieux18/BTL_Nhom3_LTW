<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Hotel" %>
<%
    Object obj = request.getAttribute("hotel");
    Hotel hotel = null;
    if (obj != null) {
        hotel = (Hotel) obj;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title><%= (hotel == null) ? "Thêm Khách Sạn" : "Sửa Khách Sạn" %></title>
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

            /* --- Chỉnh CSS cho ảnh và nút đổi ảnh --- */
            .image-control {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .image-control img#hotelImage {
                max-width: 300px;
                max-height: 180px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                object-fit: cover;
                border: 2px solid #c0392b;
                transition: box-shadow 0.3s ease;
            }

            .image-control img#hotelImage:hover {
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

            .image-control img#hotelImage {
                max-width: 300px;
                max-height: 180px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                object-fit: cover;
                border: 2px solid #c0392b;
                transition: box-shadow 0.3s ease;
            }

            .image-control img#hotelImage:hover {
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
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="form-container">
            <a href="management?tab=hotel" class="btn btn-info back-button">← Back</a>

            <h2><%= (hotel == null) ? "Thêm Khách Sạn" : "Sửa Khách Sạn" %></h2>

            <form action="hotel" method="post" enctype="multipart/form-data" id="hotelForm" accept-charset="UTF-8">
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
                    <input type="text" id="rating" name="rating" placeholder="Nhập đánh giá" required
                           value="<%= (hotel != null) ? hotel.getRating() : "" %>" />
                </div>

                <div class="form-group">
                    <label for="pricePerNight">Giá/Đêm</label>
                    <input type="text" id="pricePerNight" name="pricePerNight" placeholder="Nhập giá/đêm" required
                           value="<%= (hotel != null) ? hotel.getPrice_per_night() : "" %>" />
                </div>

                <div class="form-group">
                    <label for="imageFile">Hình ảnh</label>
                    <div class="image-control">
                        <% if (hotel != null && hotel.getImage() != null && !hotel.getImage().isEmpty()) { %>
                        <img id="hotelImage" src="<%= hotel.getImage() + "?t=" + System.currentTimeMillis() %>" 
                             alt="<%= hotel.getName() %>" class="card-img-top" style="max-width: 300px; display: block; margin-bottom: 10px;"/>
                        <button type="button" id="changeImageBtn">Đổi ảnh</button>
                        <input type="file" id="imageFile" name="imageFile" accept="image/*" style="display:none;" />
                        <% } else { %>
                        <span style="font-style: italic; color: #777;">Chưa có hình ảnh</span>
                        <input type="file" id="imageFile" name="imageFile" accept="image/*" />
                        <% } %>
                    </div>
                </div>
                    
                     <div class="form-group">
                    <label for="roomsAvailable">Phòng trống</label>
                    <input type="text" id="roomsAvailable" name="roomsAvailable" placeholder="Nhập phòng" required
                           value="<%= (hotel != null) ? hotel.getRoomsAvailable() : "" %>" />
                </div>

                <button type="submit"><%= (hotel == null) ? "Thêm khách sạn" : "Lưu sửa" %></button>
            </form>
        </div>

        <script>
            const changeImageBtn = document.getElementById('changeImageBtn');
            const imageFileInput = document.getElementById('imageFile');
            const hotelImage = document.getElementById('hotelImage');

            if (changeImageBtn) {
                changeImageBtn.addEventListener('click', () => {
                    imageFileInput.click();
                });
            }

            if (imageFileInput) {
                imageFileInput.addEventListener('change', (e) => {
                    const file = e.target.files[0];
                    if (file && hotelImage) {
                        hotelImage.src = URL.createObjectURL(file);
                    }
                });
            }
        </script>
        <%@include file="footer.jsp" %>
    </body>
</html>
