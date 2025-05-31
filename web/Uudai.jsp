<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Ưu đãi</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="./assets/css/reset.min.css" />
        <link rel="stylesheet" href="./assets/css/base.css" />
        <link rel="stylesheet" href="./assets/css/styles.css" />
</head>

<body class="bg-light">
    <jsp:include page="header.jsp" />
    <section class="search-hotel">
        <div class="container py-5">
            <div class="bg-white p-4 rounded shadow-sm border">
                <form action="deal" method="GET" id="filterForm" class="row g-3 align-items-end">                   
                    <div class="col-12 mb-2"><h4 class="text-danger font-weight-bold" style="font-size: 25px;">Tìm kiếm chuyến đi</h4></div>

                    <!-- Tìm kiếm theo điểm đi -->
                    <div class="form-group col-md-5">
                        <label for="key">Điểm đi</label>
                        <select name="key" id="key" class="form-control">
                            <option value="0" ${param.key == null || param.key == '0' ? 'selected' : ''}>-- Tất cả --</option>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.id}" ${param.key eq c.id.toString() ? 'selected' : ''}>
                                    ${c.diemDi}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group col-md-5">
                        <label for="price">Mức giá</label>
                        <select name="price" id="price" class="form-control">
                            <option value="all" ${param.price == null || param.price == 'all' ? 'selected' : ''}>-- Tất cả --</option>
                            <option value="under1" ${param.price == 'under1' ? 'selected' : ''}>Dưới 1 triệu</option>
                            <option value="1to3" ${param.price == '1to3' ? 'selected' : ''}>Từ 1 đến 3 triệu</option>
                            <option value="above3" ${param.price == 'above3' ? 'selected' : ''}>Trên 3 triệu</option>
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <button type="submit" class="btn btn-danger btn-block w-100">Tìm</button>
                    </div>
                </form>
            </div>
        </div>
    </section>
                        
                        


    <!-- Các chuyến bay nội địa -->
    <div class="container py-4" style="padding: 0 100px;">
        <h1 style="font-size: 25px; padding: 25px 0px; font-weight: bold;">Những Ưu Đãi Tốt Nhất cho Chuyến Bay Nội Địa</h1>
        <div class="row g-4" id="cardContainer">
            <c:forEach items="${requestScope.tickets}" var="c">
                <div class="col-md-4 flight-item_inland">
                    <a href="#" style="text-decoration: none; color: black;">
                        <div class="flight-card card shadow-sm">
                            <div class="discount-badge"><i class="fa-solid fa-down-long" style="font-size:12px;"></i> ${c.giamGia}%</div>
                            <div class="card-body">
                                <h5 class="card-title">Từ ${c.diemDi}</h5>
                                <div class="mb-2" style="font-size: 23px"><i class="fa-solid fa-plane"></i> ${c.diemHa}</div>
                                <h5 class="text-muted">${c.thoiGian} • Bay thẳng</h5>
                                <div class="mt-2 flight-price">₫ ${c.giaTien}</div>
                                <h5 class="text-muted">Giá / Người</h5>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
        <div class="text-center mt-4">
        <button class="btn btn-danger btn-sm-custom" id="toggleBtn">Hiện thêm</button>
    </div>
    </div>

    <!-- Các chuyến bay nước ngoài -->
    <div class="container mt-5" style="padding: 0 100px;">
        <h1 style="font-size: 25px; padding: 0px 0px 25px 0px; font-weight: bold;">Những Ưu Đãi Tốt Nhất cho Chuyến Bay Quốc Tế</h1>
        <div class="row g-4" id="international-flights">
            <c:forEach items="${requestScope.tickets_inter}" var="c">
                <div class="col-md-4 flight-item_international">
                    <a href="#" style="text-decoration: none; color: black;">
                        <div class="flight-card card shadow-sm">
                            <div class="discount-badge"><i class="fa-solid fa-down-long" style="font-size:12px;"></i>️ ${c.giamGia}%</div>
                            <div class="card-body">
                                <h5 class="card-title">Từ ${c.diemDi}</h5>
                                <div class="mb-2" style="font-size: 23px"><i class="fa-solid fa-plane"></i> ${c.diemHa}</div>
                                <h5 class="text-muted">${c.thoiGian} • Bay thẳng</h5>
                                <div class="mt-2 flight-price">₫ ${c.giaTien}</div>
                                <h5 class="text-muted">Giá / Người</h5>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
        <div class="text-center mt-4">
        <button class="btn btn-danger btn-sm-custom" id="toggleBtn_international">Hiện thêm</button>
    </div>
    </div>

    
    <!-- FAQ Section -->
        <div class="faq-container">
            <h2 class="card-title" style="font-size: 30px; margin-bottom: 20px;color: var(--color-red);">Một chuyến đi không lo lắng với chuyến bay giá phải chăng</h2>
            <div class="faq-item">
                <button class="faq-question" onclick="toggleFaq(this)">
                    Làm thế nào để tìm những ưu đãi vé máy bay last-minute rẻ nhất trên Airpaz cho một quốc gia cụ thể?
                </button>
                <div class="faq-answer">
                    Để đặt chuyến bay, hãy truy cập www.airpaz.com hoặc tải xuống ứng dụng của chúng tôi ở đây. Nhập các thành phố xuất phát và đích, cùng với ngày đi, và nhấn "Tìm kiếm". Sử dụng bộ lọc trên trang kết quả để tìm chuyến bay rẻ nhất, hoặc ghé thăm trang ưu đãi chuyến bay của chúng tôi để có những lựa chọn phù hợp nhất cho điểm đến của bạn.
                </div>
            </div>

            <div class="faq-item">
                <button class="faq-question" onclick="toggleFaq(this)">
                    Tôi nên đặt vé khi nào để có được những ưu đãi chuyến bay last-minute tốt nhất?
                </button>
                <div class="faq-answer">
                    Thời điểm tốt nhất để đặt chuyến bay và có được những ưu đãi tốt phụ thuộc vào điểm đến của bạn và thời gian trong năm. Nói chung, việc đặt vé 2-3 tháng trước sẽ giúp bạn dễ dàng tìm thấy giá vé thấp hơn. Tuy nhiên, đôi khi cũng có các ưu đãi cuối cùng. Bạn cũng có thể nhận thêm thông tin về các ưu đãi bằng cách tham gia nhận bản tin của chúng tôi.
                </div>
            </div>

            <div class="faq-item">
                <button class="faq-question" onclick="toggleFaq(this)">
                    Liệu có chuyến bay nào giá rẻ hơn vào những ngày cụ thể trong tuần không?
                </button>
                <div class="faq-answer">
                    Có, thường rẻ hơn vào giữa tuần khi các hãng hàng không có các ưu đãi và giảm giá, điều đó có nghĩa là đây là thời điểm thuận lợi để đặt vé máy bay. Bạn có thể kiểm tra định kỳ trang khuyến mãi của chúng tôi để thưởng thức những chuyến bay rẻ hơn. Kiểm tra khuyến mãi hiện có ở đây.
                </div>
            </div>

            <div class="faq-item">
                <button class="faq-question" onclick="toggleFaq(this)">
                    Ưu đãi chuyến bay 180 ngày là gì?
                </button>
                <div class="faq-answer">
                    Trang ưu đãi chuyến bay của Airpaz có những chuyến bay giá thấp nhất trong vòng 180 ngày tới từ ngày hiện tại, giúp kế hoạch cho chuyến đi trước thời gian hoặc khám phá những ưu đãi cuối cùng trong khoảng thời gian này.
                </div>
            </div>

            <div class="faq-item">
                <button class="faq-question" onclick="toggleFaq(this)">
                    Hạn chế hoặc điều kiện của các ưu đãi chuyến bay là gì?
                </button>
                <div class="faq-answer">
                    Có những quy định nhất định, như có số lượng vé giới hạn, vé không hoàn lại, hoặc ngày đi cụ thể. Quan trọng là đọc kỹ các điều khoản của mỗi ưu đãi trước khi đặt chỗ.
                </div>
            </div>

            <div class="faq-item">
                <button class="faq-question" onclick="toggleFaq(this)">
                    Làm thế nào để đặt chuyến bay với ưu đãi mà tôi thích trên trang ưu đãi chuyến bay của Airpaz?
                </button>
                <div class="faq-answer">
                    Chọn một ưu đãi chuyến bay, nhấn để xem chi tiết, kiểm tra giá và đặt vé của bạn. Hãy nhớ rằng giá có thể thay đổi bất cứ lúc nào, vì vậy hãy hoàn tất đặt chỗ của bạn nhanh chóng để bảo vệ ưu đãi, vì vé có thể bán hết nhanh chóng.
                </div>
            </div>

            <div class="faq-item">
                <button class="faq-question" onclick="toggleFaq(this)">
                    Phương thức thanh toán nào được chấp nhận để đặt vé máy bay với các ưu đãi trên Airpaz?
                </button>
                <div class="faq-answer">
                    Airpaz chấp nhận nhiều phương thức thanh toán, phụ thuộc vào loại tiền tệ, như thẻ tín dụng, thẻ ghi nợ, chuyển khoản ngân hàng và thanh toán trực tuyến.
                </div>
            </div>

            <div class="faq-item">
                <button class="faq-question" onclick="toggleFaq(this)">
                    Làm thế nào tôi có thể liên hệ với bộ phận hỗ trợ khách hàng của Airpaz để được giúp đỡ?
                </button>
                <div class="faq-answer">
                    Liên hệ với đội ngũ hỗ trợ khách hàng của chúng tôi để được giải đáp thắc mắc hoặc hỗ trợ thêm thông qua tính năng "Live Chat" tại Trung tâm Trợ giúp trên trang web của chúng tôi ở đây. Chúng tôi ở đây để trả lời mọi câu hỏi hoặc lo ngại về các ưu đãi chuyến bay hoặc các vấn đề khác liên quan đến du lịch của bạn.
                </div>
            </div>

            <div class="faq-item">
                <button class="faq-question" onclick="toggleFaq(this)">
                    Có chi phí bổ sung nào mà tôi cần xem xét không?
                </button>
                <div class="faq-answer">
                    Khi đặt chuyến bay với các ưu đãi của chúng tôi, hãy lưu ý rằng giá có thể không bao gồm phí hành lý, thuế sân bay và các dịch vụ tùy chọn như chọn ghế hoặc bữa ăn trên máy bay. Các phí này thay đổi tùy theo hãng hàng không, tuyến đường và loại giá. Hãy đọc kỹ chính sách của hãng hàng không trong quá trình đặt vé để biết về bất kỳ chi phí bổ sung nào và tránh gặp vấn đề trong chuyến đi của bạn.
                </div>
            </div>

            <div class="faq-item">
                <button class="faq-question" onclick="toggleFaq(this)">
                    Có bao nhiêu hãng hàng không cung cấp ưu đãi trên Airpaz?
                </button>
                <div class="faq-answer">
                    Có 1 hãng hàng không cung cấp ưu đãi, giúp bạn đi du lịch quanh thế giới với giá vé phải chăng hơn. Để khám phá thêm các ưu đãi từ hãng hàng không yêu thích của bạn, nhấp vào ở đây.
                </div>
            </div>
            <!-- Terms Section -->
            <div style="margin-top:20px;">
            <h3 style="color:black ;">Điều khoản và Điều kiện</h3>
            <p style="text-align: justify;">Giá hiển thị chỉ đề cập đến một hành khách và đã bao gồm thuế, nhưng có thể không bao gồm phí hành lý do hãng hàng không tính hoặc phí dịch vụ. Ngoài ra, giá chúng tôi hiển thị là giá vé thấp nhất có sẵn trong 180 ngày tới. Tuy nhiên, có thể có khả năng giá có thể khác do cập nhật giá theo thời gian thực, ngày bay, hạng bay và tình trạng sẵn có. Giá cả, quy định và chính sách hủy có thể thay đổi mà không cần thông báo trước. Giá vé thấp hơn có thể có sẵn cho một số điểm đến nhất định và vé ở mức giá thấp hơn này có thể không được chuyển nhượng và không hoàn tiền. Do đó, vui lòng đảm bảo kiểm tra các quy định thay đổi và hủy chuyến bay trước khi đặt chỗ. Chúng tôi mong muốn cung cấp thông tin chính xác và cập nhật nhất, nhưng hãy nhớ rằng hoàn cảnh có thể khác nhau và chính sách của hãng hàng không có thể thay đổi mà không cần thông báo.</p>
            </div>
        </div>       
    </div>


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
<script src="./assets/JS/button_items.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
