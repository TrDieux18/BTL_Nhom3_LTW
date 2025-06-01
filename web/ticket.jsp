<%@page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Danh sách vé máy bay</title>
        <link rel="stylesheet" href="./assets/css/bootstrap.min.css" />
        <style>
            .box-item {
                cursor: pointer;
                transition: transform 0.2s ease;
            }
            .box-item:hover {
                transform: scale(1.03);
            }
            .card-title {
                font-weight: 600;
            }
            /* Chỉnh kích thước select và căn chỉnh form nhóm giá */
            #priceRange {
                height: 38px;  /* cao bằng input text */
            }

            .form-group.col-md-3 {
                min-width: 180px; /* giới hạn độ rộng tối thiểu */
            }

            .form-group.col-md-2 {
                min-width: 120px; /* vừa đủ cho nút xóa */
            }

            .box-item {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <section class="search-ticket">
            <div class="container py-5">
                <div class="bg-white p-4 rounded shadow-sm border">
                    <form id="searchForm" class="row g-3 align-items-end" onsubmit="return false;">
                        <div class="col-12 mb-2">
                            <h4 class="text-danger font-weight-bold" style="font-size: 25px;">
                                🔍 Tìm kiếm vé máy bay
                            </h4>
                        </div>

                        <!-- Điểm khởi hành -->
                        <div class="form-group col-md-3">
                            <label for="origin">Điểm khởi hành</label>
                            <input
                                type="text"
                                class="form-control"
                                id="origin"
                                placeholder="VD: Nha Trang, Đà Nẵng..."
                                />
                        </div>

                        <!-- Điểm đến -->
                        <div class="form-group col-md-3">
                            <label for="destination">Điểm đến</label>
                            <input
                                type="text"
                                class="form-control"
                                id="destination"
                                placeholder="VD: Nha Trang, Đà Nẵng..."
                                />
                        </div>

                        <!-- Giá vé -->
                        <div class="form-group col-md-3">
                            <label for="priceRange">Khoảng giá</label>
                            <select class="form-select" id="priceRange" aria-label="Chọn khoảng giá">
                                <option value="">Tất cả</option>
                                <option value="under1">Dưới 1 triệu</option>
                                <option value="1to3">Từ 1 - 3 triệu</option>
                                <option value="above3">Trên 3 triệu</option>
                            </select>
                        </div>

                        <!-- Nút xóa -->
                        <div class="form-group col-md-2">
                            <button type="button" id="clearBtn" class="btn btn-danger w-100">Xóa bộ lọc</button>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <div class="container py-5">
            <h4 class="mb-4 text-danger font-weight-bold">✈ Gợi ý vé máy bay phổ biến</h4>
            <div class="row g-4" id="ticketList">

                <div class="col-md-3 box-item">
                    <a href="selectticket?origin=Hà Nội&destination=Cần Thơ" style="text-decoration:none; color:inherit;">
                        <div class="card h-100 shadow-sm">
                            <img src="assets/images/flight/can_tho_1.jpg" class="card-img-top" style="height:180px; object-fit:cover;" alt="Flight Image" />
                            <div class="card-body">
                                <h5 class="card-title">Hà Nội → Cần Thơ</h5>
                                <p class="text-danger font-weight-bold">1.300.000 ₫</p>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3 box-item">
                    <a href="selectticket?origin=Đà Nẵng&destination=Hà Nội" style="text-decoration:none; color:inherit;">
                        <div class="card h-100 shadow-sm">
                            <img src="assets/images/flight/ha_noi_2.jpg" class="card-img-top" style="height:180px; object-fit:cover;" alt="Flight Image" />
                            <div class="card-body">
                                <h5 class="card-title">Đà Nẵng → Hà Nội</h5>
                                <p class="text-danger font-weight-bold">950.000 ₫</p>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3 box-item">
                    <a href="selectticket?origin=TP.HCM&destination=Nha Trang" style="text-decoration:none; color:inherit;">
                        <div class="card h-100 shadow-sm">
                            <img src="assets/images/flight/nha_trang_1.jpg" class="card-img-top" style="height:180px; object-fit:cover;" alt="Flight Image" />
                            <div class="card-body">
                                <h5 class="card-title">TP.HCM → Nha Trang</h5>
                                <p class="text-danger font-weight-bold">870.000 ₫</p>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3 box-item">
                    <a href="selectticket?origin=Cần Thơ&destination=Đà Nẵng" style="text-decoration:none; color:inherit;">
                        <div class="card h-100 shadow-sm">
                            <img src="assets/images/flight/da_nang_2.jpg" class="card-img-top" style="height:180px; object-fit:cover;" alt="Flight Image" />
                            <div class="card-body">
                                <h5 class="card-title">Cần Thơ → Đà Nẵng</h5>
                                <p class="text-danger font-weight-bold">1.050.000 ₫</p>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3 box-item">
                    <a href="selectticket?origin=Huế&destination=TP.HCM" style="text-decoration:none; color:inherit;">
                        <div class="card h-100 shadow-sm">
                            <img src="assets/images/flight/tp_hcm_2.jpg" class="card-img-top" style="height:180px; object-fit:cover;" alt="Flight Image" />
                            <div class="card-body">
                                <h5 class="card-title">Huế → TP.HCM</h5>
                                <p class="text-danger font-weight-bold">1.100.000 ₫</p>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3 box-item">
                    <a href="selectticket?origin=Vinh&destination=Đà Lạt" style="text-decoration:none; color:inherit;">
                        <div class="card h-100 shadow-sm">
                            <img src="assets/images/flight/da_lat.jpg" class="card-img-top" style="height:180px; object-fit:cover;" alt="Flight Image" />
                            <div class="card-body">
                                <h5 class="card-title">Vinh → Đà Lạt</h5>
                                <p class="text-danger font-weight-bold">990.000 ₫</p>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3 box-item">
                    <a href="selectticket?origin=Hải Phòng&destination=Nha Trang" style="text-decoration:none; color:inherit;">
                        <div class="card h-100 shadow-sm">
                            <img src="assets/images/flight/nha_trang_1.jpg" class="card-img-top" style="height:180px; object-fit:cover;" alt="Flight Image" />
                            <div class="card-body">
                                <h5 class="card-title">Hải Phòng → Nha Trang</h5>
                                <p class="text-danger font-weight-bold">1.250.000 ₫</p>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3 box-item">
                    <a href="selectticket?origin=Buôn Ma Thuột&destination=Hà Nội" style="text-decoration:none; color:inherit;">
                        <div class="card h-100 shadow-sm">
                            <img src="assets/images/flight/ha_noi_1.jpg" class="card-img-top" style="height:180px; object-fit:cover;" alt="Flight Image" />
                            <div class="card-body">
                                <h5 class="card-title">Buôn Ma Thuột → Hà Nội</h5>
                                <p class="text-danger font-weight-bold">1.180.000 ₫</p>
                            </div>
                        </div>
                    </a>
                </div>

            </div>
        </div>
        <%@include file="footer.jsp" %>

        <script>
            const originInput = document.getElementById('origin');
            const destinationInput = document.getElementById('destination');
            const priceSelect = document.getElementById('priceRange');
            const ticketList = document.getElementById('ticketList');
            const clearBtn = document.getElementById('clearBtn');

            function filterTickets() {
                const origin = originInput.value.trim().toLowerCase();
                const destination = destinationInput.value.trim().toLowerCase();
                const priceRange = priceSelect.value;

                const tickets = ticketList.querySelectorAll('.box-item');

                tickets.forEach(ticket => {
                    const ticketOrigin = ticket.getAttribute('data-origin').toLowerCase();
                    const ticketDestination = ticket.getAttribute('data-destination').toLowerCase();
                    const ticketPrice = Number(ticket.getAttribute('data-price'));

                    let matchesOrigin = origin === '' || ticketOrigin.includes(origin);
                    let matchesDestination = destination === '' || ticketDestination.includes(destination);

                    let matchesPrice = true;
                    if (priceRange === 'under1') {
                        matchesPrice = ticketPrice < 1000000;
                    } else if (priceRange === '1to3') {
                        matchesPrice = ticketPrice >= 1000000 && ticketPrice <= 3000000;
                    } else if (priceRange === 'above3') {
                        matchesPrice = ticketPrice > 3000000;
                    }

                    if (matchesOrigin && matchesDestination && matchesPrice) {
                        ticket.style.display = 'block';
                    } else {
                        ticket.style.display = 'none';
                    }
                });
            }

            originInput.addEventListener('input', filterTickets);
            destinationInput.addEventListener('input', filterTickets);
            priceSelect.addEventListener('change', filterTickets);
            clearBtn.addEventListener('click', () => {
                originInput.value = '';
                destinationInput.value = '';
                priceSelect.value = '';
                filterTickets();
            });

            // Khởi tạo: hiện tất cả vé
            filterTickets();
        </script>

    </body>
</html>
