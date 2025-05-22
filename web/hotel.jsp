<%@page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Danh sách khách sạn</title>
        <link rel="stylesheet" href="./assets/css/bootstrap.min.css" />
        <link rel="stylesheet" href="./assets/css/base.css"/>
        <link rel="stylesheet" href="./assets/css/styles.css" />
        <link rel="stylesheet" href="./assets/font/fontawesome-free-6.7.2-web/fontawesome/css/all.min.css"/>

        <style>
            .search-hotel {
                background: var(--color-red);
            }

            .hotel-card {
                display: flex;
                flex-direction: column;
                height: 100%;
                margin-bottom: 1.5rem;
                transition: box-shadow 0.3s ease;
                box-shadow: 0 2px 5px rgba(0,0,0,0.15);
                border-radius: 0.25rem;
            }
            .hotel-card:hover {
                box-shadow: 0 6px 15px rgba(0,0,0,0.35);
            }
            .hotel-card .card-body {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }
            .box-hotel  {
                margin-bottom: 20px;
            }
            input.form-control {
                border-radius: 0.5rem;
                transition: box-shadow 0.2s;
            }

            input.form-control:focus {
                box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
                border-color: #dc3545;
            }

            .btn-danger {
                border-radius: 0.5rem;
                font-weight: 500;
            }


        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <section class="search-hotel">
            <div class="container py-5">
                <div class="bg-white p-4 rounded shadow-sm border">
                    <form action="hotel" method="get" class="row g-3 align-items-end">
                        <div class="col-12 mb-2">
                            <h4 class="text-danger font-weight-bold">
                                🔍 Tìm kiếm khách sạn
                            </h4>
                        </div>

                        <!-- Địa chỉ -->
                        <div class="form-group col-md-4">
                            <label for="address">📍 Địa chỉ</label>
                            <input
                                type="text"
                                class="form-control"
                                id="address"
                                name="address"
                                placeholder="VD: Nha Trang, Đà Nẵng..."
                                />
                        </div>

                        <!-- Giá phòng tối đa -->
                        <div class="form-group col-md-4">
                            <label for="priceRange">💰 Mức giá</label>
                            <select class="form-control" id="priceRange" name="priceRange">
                                <option value="">-- Tất cả --</option>
                                <option value="1">Dưới 1.000.000 VNĐ</option>
                                <option value="2">Từ 1.000.000 - 2.500.000 VNĐ</option>
                                <option value="3">Trên 2.500.000 VNĐ</option>
                            </select>
                        </div>


                        <!-- Số phòng còn trống -->
                        <div class="form-group col-md-3">
                            <label for="minRooms">🛏️ Phòng trống tối thiểu</label>
                            <input
                                type="text"

                                class="form-control"
                                id="minRooms"
                                name="minRooms"
                                placeholder="VD: 5"
                                />
                        </div>

                        <!-- Nút tìm kiếm -->
                        <div class="form-group col-md-1">
                            <button type="submit" class="btn btn-danger btn-block w-100">
                                Tìm
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </section>



        <section class="container py-4">
            <!-- Tiêu đề chữ màu đen -->
            <h2 class="mb-4 text-dark">Danh sách tất cả khách sạn</h2>

            <div class="row g-3">
                <%
                    // Lấy danh sách khách sạn từ request
                    java.util.List<model.Hotel> hotels = (java.util.List<model.Hotel>) request.getAttribute("hotels");
                    if (hotels != null && !hotels.isEmpty()) {
                        java.text.NumberFormat formatter = java.text.NumberFormat.getInstance(new java.util.Locale("vi","VN"));
                        for (model.Hotel hotel : hotels) {
                %>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3 box-hotel " >
                    <a href="detail?hotelId=<%=hotel.getId()%>" class="text-decoration-none">
                        <div class="card h-100 hotel-card">
                            <img src="<%=hotel.getImage()%>" alt="<%=hotel.getName()%>" class="card-img-top" style="height:180px; object-fit:cover;" />
                            <div class="card-body">
                                <h5 class="card-title text-dark"><%=hotel.getName()%></h5>
                                <p class="card-text text-secondary mb-1">Đánh giá: <%=hotel.getRating()%>★</p>
                                <p class="text-danger fw-bold">
                                    <%= formatter.format(hotel.getPrice_per_night()) %> VNĐ / đêm
                                </p>
                            </div>
                        </div>
                    </a>
                </div>
                <%
                        }
                    } else {
                %>
                <p class="text-center text-muted">Chưa có khách sạn nào để hiển thị.</p>
                <%
                    }
                %>
            </div>
        </section>

        <jsp:include page="footer.jsp" />
        <script src="./assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
