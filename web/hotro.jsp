<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Form Hỗ Trợ</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .support-card {
      background-color: #fff;
      padding: 30px 25px;
      border-radius: 16px;
      box-shadow: 8px 0px 20px rgba(0, 0, 0, 0.3);
      transition: all 0.3s ease-in-out;
      margin-top: 30px;
    }

    .support-card h5 {
      font-size: 22px;
      font-weight: 600;
      margin-bottom: 25px;
      color: #2c3e50;
      text-align: center;
    }

    .form-label {
      font-weight: 500;
      color: #34495e;
    }

    .form-control, .form-select {
      border-radius: 10px;
      border: 1px solid #dce4ec;
      padding: 10px 15px;
      font-size: 15px;
      transition: border-color 0.3s;
    }

    .form-control:focus, .form-select:focus {
      border-color: #007bff;
      box-shadow: 0 0 0 0.15rem rgba(0, 123, 255, 0.25);
    }

    .btn-danger {
      padding: 10px 24px;
      font-weight: 500;
      border-radius: 10px;
      background-color: var(--color-red);
      border-color: #007bff;
      transition: background-color 0.3s ease;
    }

    .btn-danger:hover {
      background-color: #0056b3;
    }

    .support-images p {
      margin: 0;
      line-height: 1.4;
    }

    .support-images strong {
      color: #007bff;
      font-size: 18px;
    }
    .form-select:focus{
    box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
    border-color: #dc3545;
    }
    @media (max-width: 768px) {
      .support-card {
        padding: 25px 20px;
      }
    }
  </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <section class="search-hotel">
    <div class="container py-5" style="position: relative; text-align: center;">
        <img src="https://cdn.airpaz.com/cdn-cgi/image/w=2200,h=400,f=webp/forerunner-next/img/illustration/v2/hero/banner-help-desktop.png" 
             alt="alt" style="width: 100%; max-width: 1200px;height: 150px;"/>
        <h6 style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 28px; color: white; padding-bottom: 40px;">
            Xin chào! Airpaz luôn sẵn sàng giúp đỡ bạn.
        </h6>
    </div>
</section>


    <div class="d-flex justify-content-center align-items-center w-100" style="min-height: 50vh;">
        <div class="col-lg-5 col-md-8 col-10 mx-auto">
            <form id="myForm" action="https://formsubmit.co/47bce775de591175194e7b531cc71a49" method="POST" enctype=multipart/form-data>
                <input type="hidden" name="_template" value="table">
                <div class="support-card">
                  <h5>Gửi yêu cầu của bạn</h5>
                    <div class="mb-3">
                        <label for="yeucau" class="form-label">Chọn yêu cầu của bạn</label>
                        <select class="form-select" id="yeucau" name="problem" onchange="updateForm()">
                            <option selected disabled>Chọn một danh mục</option>
                            <option>Vấn đề về vé máy bay</option>
                            <option>Vấn đề về khách sạn</option>
                            <option>Báo cáo lỗi</option>
                            <option>Khác</option>
                      </select>
                    </div>
                    <div class="mb-3" id="aircodeField" style="display: none;">
                        <label for="fullname" class="form-label">Mã vé máy bay</label>
                        <input type="text" class="form-control" id="aircode" name="aircode" placeholder="Nhập mã vé máy bay">
                    </div>
                    <div class="mb-3" id="hotelcodeField" style="display: none;">
                        <label for="hotelcode" class="form-label">Mã vé khách sạn</label>
                        <input type="text" class="form-control" id="hotelcode" name="hotelcode" placeholder="Nhập mã vé khách sạn">
                    </div>
                    <div class="mb-3" id="fullnameField" style="display: none;">
                        <label for="name" class="form-label">Họ và Tên</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Nhập tên">
                    </div>
                    <div class="mb-3" id="emailField" style="display: none;">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Nhập địa chỉ email">
                    </div>
                    <input type="hidden" name="_autoresponse" value="Cảm ơn bạn đã phản hồi ! 
                           Chúng tôi rất trân trọng ý kiến đóng góp của bạn và sẽ xem xét để cải thiện dịch vụ tốt hơn trong tương lai.Nếu bạn có thêm góp ý hoặc câu hỏi nào, đừng ngần ngại liên hệ với chúng tôi.">
                  
                    <div class="mb-3" id="phoneField" style="display: none;">
                        <label for="phone" class="form-label">Số điện thoại</label>
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại">
                    </div>

                    <div class="mb-3" id="titleField" style="display: none;">
                        <label for="title" class="form-label">Tiêu đề</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Nhập tiêu đề">
                    </div>

                    <div class="mb-3" id="messageField" style="display: none;">
                        <label for="message" class="form-label">Mô tả</label>
                        <textarea class="form-control" id="message" name="message" rows="4" placeholder="Hãy mô tả chi tiết vấn đề của bạn..." style="resize: none;"></textarea>
                    </div>
                    <div class="mb-3" id="imagesField" style="display: none;">
                        <input type="file" name="attachment" accept="image/png, image/jpeg">
                    </div>
<!--                    <input type="hidden" name="_captcha" value="false">-->
                    <input type="hidden" name="_next" value="http://localhost:9999/BTLTest/thanks">                                 
                    <div class="text-center">
                        <button type="submit" class="btn btn-danger">Gửi yêu cầu</button>
                    </div>
                </div>
            </form>

            <div class="support-images mt-4" style="padding-bottom: 20px;">
                <div class="text-center text-muted">
                    <p><strong style="color:var(--color-red)">Hỗ trợ khách hàng 24/7</strong></p>
                    <p>Chúng tôi luôn sẵn sàng hỗ trợ bạn</p>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
    <script src="./assets/JS/helpform.js"></script>
</body>
</html>
