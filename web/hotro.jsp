<%-- 
    Document   : newjsp
    Created on : May 15, 2025, 10:27:56 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Hỗ trợ</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="./assets/css/reset.min.css" />
    <link rel="stylesheet" href="./assets/css/base.css" />
    <link rel="stylesheet" href="./assets/css/styles.css" />
    <link rel="stylesheet" href="./assets/css/support.css">
</head>
<header class="navbar" role="navigation">
    <div class="container">   
      <div class="row">
        <div class="col-12">
          <div class="inner-main">
            <div class="inner-logo">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 108 30"
                class="text-white"
                width="108"
                data-v-f62f7173=""
              >
                <path
                  fill="currentColor"
                  d="M10.862 23.091c-.102 0-.187 0-.289.017-.408.018-.817.018-1.225 0-.085 0-.187 0-.272-.017-.069-.034-.137 0-.205-.034a5.542 5.542 0 0 1-2.16-.634c-.426-.24-.8-.549-1.192-.857a11.649 11.649 0 0 1-.885-.72c-.29-.24-.579-.48-.885-.738l-.919-.77c-.221-.19-.442-.395-.664-.584-.323-.291-.646-.565-.97-.857-.068-.068-.136-.137-.204-.188.613-.446 1.26-.806 1.991-.978.68-.154 1.31-.085 1.923.326 1.362.926 2.86 1.423 4.527 1.389 1.395-.035 2.689-.463 3.863-1.217.936-.583 1.77-1.286 2.638-1.972a459.238 459.238 0 0 0 3.37-2.657c.05-.034.101-.086.186-.171-3.335.034-6.62-.035-9.921-.138.12-.154.255-.24.391-.342.92-.738 1.974-1.115 3.098-1.406 2.62-.686 5.258-1.234 7.913-1.766 1.327-.257 2.654-.531 3.982-.788a.574.574 0 0 0 .204-.103c1.753-1.406 3.506-2.795 5.241-4.217 1.09-.892 2.179-1.783 3.404-2.503.885-.515 1.82-.96 2.842-1.132.017 0 .034-.017.034-.034h1.021c.085.103.221.069.323.12.834.274 1.345.857 1.702 1.629.085.188.136.377.204.565.051.12.017.223-.085.309-.408.343-.817.703-1.225 1.046-.545.462-1.09.925-1.634 1.371-.748.617-1.497 1.251-2.263 1.869-.715.6-1.43 1.2-2.161 1.8-.817.668-1.617 1.337-2.434 2.005-.749.617-1.497 1.217-2.263 1.835-.817.668-1.65 1.32-2.468 1.988-.936.754-1.889 1.509-2.842 2.246-1.889 1.474-3.777 2.948-5.735 4.32-.63.445-1.327.754-2.042 1.028-.85.326-1.718.566-2.603.72-.358.069-.732.12-1.09.155-.05.085-.153.034-.22.085ZM104.595 9.755c.578.085 1.14.205 1.633.582.358.275.579.618.698 1.046.017.069.017.137.085.189v.823c-.017 0-.034.017-.034.017-.085.445-.391.737-.681 1.045l-2.961 3.19c-.731.788-1.463 1.593-2.212 2.382l-.715.771c.068.069.136.035.205.035h5.7c.154 0 .239.034.256.188l.153.875c.017.308.017.634 0 .942-.051.309-.085.635-.153.943-.034.137-.085.172-.222.172-2.654 0-5.326 0-7.98-.017h-.069c-.068-.035-.136 0-.204-.035-.562-.051-1.106-.154-1.617-.377-.697-.308-1.225-.788-1.344-1.611a1.954 1.954 0 0 1 0-.446c.068-.566.357-1.012.749-1.44.442-.463.868-.943 1.31-1.423.528-.566 1.038-1.131 1.566-1.68.408-.428.817-.874 1.225-1.303.408-.445.817-.908 1.242-1.337.119-.137.238-.274.375-.428-.069-.052-.154-.018-.222-.018H96.12c-.409 0-.443-.034-.477-.445l-.05-.463c-.035-.086.016-.172-.035-.257v-.806c.051-.086 0-.171.034-.257.034-.274.068-.532.136-.806.035-.12.086-.137.17-.137h8.305c.136.103.273.051.392.086ZM56.146 20.263c0 .669.392 1.097 1.038 1.149-.017.154-.102.274-.17.394-.46.806-1.174 1.217-2.06 1.371-.152.035-.288.035-.441.052a1.623 1.623 0 0 1-.409 0c-.442-.017-.868-.069-1.276-.257-.477-.223-.817-.566-1.004-1.046a1.894 1.894 0 0 1-.136-.686c-.018-.086-.018-.171-.018-.24v-8.074c0-.086.017-.172-.017-.24-.033-.497-.136-.96-.646-1.183-.085-.034-.17-.086-.238-.069-.222.018-.154-.137-.12-.222.12-.24.256-.463.426-.652.51-.583 1.174-.84 1.923-.943.085-.034.17.017.255-.034h.477c.085.051.187 0 .289.034.46.086.902.172 1.276.446.545.394.749.96.8 1.611v.343c.919-1.2 1.94-2.16 3.472-2.4.085-.034.17.017.255-.034h.51c.103.051.222 0 .34.034.494.086.988.155 1.43.463.392.274.579.669.664 1.132.034.24.034.48.034.72-.034.068 0 .137-.034.205-.085.497-.187.977-.425 1.423-.307.566-.732.926-1.413.823-.272-.034-.527-.137-.8-.223a6.004 6.004 0 0 0-.8-.137c-.068-.034-.136 0-.204-.034-.68-.052-1.344 0-1.974.274-.527.24-.987.771-1.02 1.474-.035.069 0 .137-.035.206 0 .754 0 1.509-.017 2.28v1.766c.085.068.034.171.068.274ZM33.887 9.72c.22-.172.425-.36.646-.532l.851-.703c.273-.223.545-.463.817-.703.374-.308.749-.6 1.106-.908.34-.309.698-.583 1.038-.874.358-.309.715-.583 1.072-.892.137-.103.256-.223.375-.343.034-.034.068-.085.136-.068.051.017.034.085.034.12V19.92c0 .274 0 .548.085.805.136.463.425.686.902.737-.29.669-1.413 1.663-2.944 1.732a1.633 1.633 0 0 1-.409 0c-.51 0-1.003-.103-1.446-.36-.51-.291-.868-.72-.987-1.32-.085-.343-.034-.686-.034-1.029-.017-.48-.017-.942-.017-1.422-.034-.086-.017-.155-.017-.24V11.04c0-.086.017-.172-.017-.24-.051-.36-.204-.669-.545-.858-.17-.085-.323-.171-.51-.171-.034-.017-.136.051-.136-.051ZM48.318 20.332c.034.582.323.96.85 1.045.17.035.188.069.103.223-.443.892-1.175 1.389-2.145 1.56-.17.035-.34.035-.493.052a1.632 1.632 0 0 1-.408 0c-.426 0-.851-.086-1.243-.258-.714-.308-1.055-.89-1.14-1.645-.017-.086-.017-.172-.017-.24v-8.074c0-.086.017-.172-.017-.24-.034-.395-.068-.789-.374-1.08-.153-.155-.358-.223-.562-.258-.119-.034-.153-.051-.102-.171.153-.343.374-.617.63-.892.493-.497 1.106-.668 1.753-.77.085-.035.17.016.255-.035h.476c.085.051.188 0 .29.034.425.086.833.172 1.208.412.425.274.663.668.8 1.148.017.069.034.137.05.223.035.069 0 .154.035.223v8.348c0 .069.017.137.017.206.034.052-.017.137.034.189ZM31.233 13.337c.357.103.697.24.987.48.408.36.612.806.697 1.337.017.154.017.292 0 .446-.187 1.028-.8 1.646-1.77 1.817a3.063 3.063 0 0 1-.561 0 1.802 1.802 0 0 1-1.174-.583c-.409-.428-.596-.96-.579-1.56.017-.977.817-1.868 1.787-1.937.136-.017.29-.017.425-.034.051.034.136 0 .188.034ZM47.706 5.691c-.12.669-.477 1.183-1.107 1.475a2.332 2.332 0 0 1-.493.137c-.17.017-.323.017-.494 0-.8-.069-1.548-.772-1.6-1.663a1.656 1.656 0 0 1 0-.412c.103-.874.715-1.577 1.72-1.662a.559.559 0 0 1 .238 0c.834.085 1.531.617 1.719 1.611.034.189.034.343.017.514Z"
                ></path>
                <path
                  fill="currentColor"
                  fill-rule="evenodd"
                  d="M64.485 11.657c.289.258.34.617.374.977.034.07.017.155 0 .206v15.12l.002.053c.003.056.007.118-.019.17v.977c.166.05.316.035.481.019l.013-.002c.731-.051 1.429-.188 2.076-.548 1.208-.652 1.872-1.68 1.889-3.086v-2.897c0-.109.009-.218.018-.328.013-.15.025-.303.016-.46.119.102.22.188.323.274.46.377.987.651 1.566.822.459.138.953.206 1.446.223.272.018.545.018.817 0 .63-.051 1.225-.154 1.804-.411 1.123-.497 1.94-1.337 2.535-2.4.562-.994.817-2.074.92-3.206a.665.665 0 0 0 .01-.187c-.002-.075-.005-.15.023-.224v-.566c-.028-.075-.025-.15-.022-.224a.665.665 0 0 0-.012-.187c-.017-.069-.017-.155-.017-.24-.028-.038-.025-.075-.022-.113.002-.03.004-.062-.012-.093-.153-1.063-.442-2.074-.987-3-.391-.669-.85-1.286-1.463-1.766-.732-.565-1.566-.874-2.468-.977-.042-.017-.09-.017-.138-.017-.049 0-.1 0-.151-.017h-.545c-.053.032-.106.03-.16.03-.031-.002-.063-.002-.095.004-1.361.137-2.45.84-3.403 1.817a.367.367 0 0 0-.013-.096c-.003-.01-.005-.018-.005-.024-.102-.497-.323-.908-.731-1.217-.392-.291-.851-.394-1.31-.48-.043-.017-.086-.017-.128-.017-.043 0-.085 0-.128-.017h-.51c-.047.028-.093.025-.14.023a.26.26 0 0 0-.116.011c-.51.086-1.004.206-1.43.514a2.428 2.428 0 0 0-.935 1.166c-.034.086-.034.12.085.137.204.017.391.12.562.257Zm9.75 6.566c.222-.6.273-1.217.273-1.903-.017-.566-.068-1.183-.29-1.765-.39-.978-1.089-1.543-2.144-1.595-1.055-.051-1.855.412-2.348 1.354-.255.48-.357 1.03-.391 1.578-.069.908 0 1.782.425 2.605.493.943 1.276 1.44 2.348 1.372 1.072-.052 1.753-.652 2.128-1.646ZM92.683 14.16c-.017-.103-.017-.223-.017-.325-.038-.051-.02-.12-.008-.167.004-.016.008-.03.008-.04a3.632 3.632 0 0 0-.085-.6c-.256-1.13-.834-2.005-1.838-2.57-.851-.48-1.787-.67-2.74-.79-.03-.015-.065-.013-.101-.01-.044.002-.09.005-.137-.024-.103-.017-.222-.017-.324-.017a22.313 22.313 0 0 0-1.514 0c-.102.017-.222.017-.324.017-.046.029-.092.026-.139.023-.038-.002-.077-.004-.116.012l-.22.03c-.522.074-1.042.147-1.55.313-.782.257-1.531.582-2.127 1.182a.571.571 0 0 0 0 .24c.012.035.02.071.03.107.02.072.038.145.072.202.409.771.97 1.371 1.855 1.56.17.034.272.017.409-.103.953-.874 2.059-1.131 3.284-.737.561.171.987.549 1.242 1.097.235.488.23 1.002.223 1.54l-.002.26a9.85 9.85 0 0 0-2.484-.651c-.06-.017-.12-.017-.177-.017-.057 0-.112 0-.163-.018h-.34a.555.555 0 0 1-.224.023c-.061-.002-.123-.004-.185.012l-.358.051c-1.242.137-2.331.6-3.216 1.526-.596.634-.987 1.388-1.089 2.263-.016.039-.013.078-.011.117.002.046.005.093-.023.14v.651c.028.038.025.08.023.124a.26.26 0 0 0 .011.116c.034.463.17.892.374 1.286.188.343.443.634.732.926.358.36.766.617 1.208.823.63.291 1.31.48 2.008.48.239.017.494.017.732 0 .102 0 .204 0 .29-.017.953-.155 1.854-.463 2.654-1.046.102-.086.17-.086.239.051.153.326.425.549.731.72.443.24.902.309 1.396.326.136.017.272.017.408 0 .68-.034 1.293-.206 1.838-.634.391-.326.68-.703.85-1.183-.73-.103-1.037-.48-1.054-1.183-.026-1.337-.023-2.664-.02-3.996.002-.444.003-.89.003-1.335a1.881 1.881 0 0 1-.023-.411 2.256 2.256 0 0 0-.011-.344Zm-4.544 5.434c.29-.24.528-.48.409-.89l-.003-.08c-.003-.082-.006-.169.02-.247.017-.171-.035-.274-.188-.342-.1-.054-.195-.107-.289-.16-.18-.099-.355-.196-.545-.286-.561-.257-1.14-.463-1.77-.343-.612.137-1.157.377-1.395 1.011-.238.6-.136 1.183.255 1.697.409.532.97.703 1.6.6.749-.102 1.328-.514 1.906-.96Z"
                  clip-rule="evenodd"
                ></path>
              </svg>
            </div>
            <div class="navbar-menu">
              <ul>
                <li><a href="#">Vé máy bay</a></li>
                <li><a href="#">Khách sạn</a></li>
                <li><a href="#">Khuyến mãi</a></li>
                <li><a href="#">Đơn hàng</a></li>
                <li><a href="Uudai.html">Ưu đãi</a></li>
                <li><a href="hotro.html">Hỗ trợ</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
<body>
  <div class="hero ">
    <h1>Xin chào, chúng tôi có thể giúp gì cho bạn?</h1>
  
    <div class="search-box">
      <input type="text" placeholder="Vui lòng nhập bất kỳ câu hỏi hoặc từ khóa nào (ví dụ: đặt phòng, thanh toán)">
      <div class="icon">
        <img src="img/iconfinding.svg" alt="Plane Icon" width="24" height="24">
      </div>
    </div>
  </div>
<div class="container py-5" style="padding: 0 100px 0 100px;">
  <h1 class="mb-4 fw-bold" style="font-size: 25px;">Quản lý đặt chỗ</h1>
  <div class="row g-4">

    <!-- Đổi lịch bay -->
    <div class="col-md-4">
      <div class="card card-custom h-100 p-3 highlight d-flex align-items-center">
        <div class="d-flex align-items-center">
          <!-- Ảnh bên trái -->
          <div style="width: 100px; margin-right: 15px;">
            <img src="./img/doiLichBay.webp" width="100" alt="Lịch bay" class="img-fluid">
          </div>
    
          <!-- Nội dung bên phải -->
          <div>
            <h5 class="card-title fw-bold mb-1">Đổi lịch bay</h5>
            <p class="card-text mb-0">Yêu cầu thay đổi ngày giờ chuyến bay/khách sạn. Chỉ cần sự linh hoạt!</p>
          </div>
        </div>
      </div>
    </div>
    
    

    <!-- Chỉnh sửa dữ liệu hành khách -->
    <div class="col-md-4">
      <div class="card card-custom h-100 p-3 highlight d-flex align-items-center">
        <div class="d-flex align-items-center">
          <!-- Ảnh bên trái -->
          <div style="width: 100px; margin-right: 15px;">
            <img src="./img/ChinhSuaDL.webp" width="100" alt="Lịch bay" class="img-fluid">
          </div>
    
          <!-- Nội dung bên phải -->
          <div>
            <h5 class="card-title fw-bold mb-1">Chỉnh sửa dữ liệu hành khách</h5>
            <p class="card-text mb-0">Vô tình ghi sai tên, lặp tên hoặc thông tin cá nhân khác? Yêu cầu thay đổi nó tại đây!</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Gửi lại chuyến đi -->
    <div class="col-md-4">
      <div class="card card-custom h-100 p-3 highlight d-flex align-items-center">
        <div class="d-flex align-items-center">
          <!-- Ảnh bên trái -->
          <div style="width: 100px; margin-right: 15px;">
            <img src="./img/Guilaichuyendi.webp" width="100" alt="Lịch bay" class="img-fluid">
          </div>
    
          <!-- Nội dung bên phải -->
          <div>
            <h5 class="card-title fw-bold mb-1">Gửi lại chuyến đi</h5>
            <p class="card-text mb-0">Gửi vé máy bay hoặc khách sạn tới bất kỳ email nào khi bạn rảnh.</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Thêm hành lý -->
    <div class="col-md-4">
      <div class="card card-custom h-100 p-3 highlight d-flex align-items-center">
        <div class="d-flex align-items-center">
          <!-- Ảnh bên trái -->
          <div style="width: 100px; margin-right: 15px;">
            <img src="./img/HoanTien.webp" width="100" alt="Lịch bay" class="img-fluid">
          </div>
    
          <!-- Nội dung bên phải -->
          <div>
            <h5 class="card-title fw-bold mb-1">Hoàn tiền</h5>
            <p class="card-text mb-0">Dễ dàng yêu cầu hủy và hoàn tiền cho đặt chỗ của bạn</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Hoàn tiền -->
    <div class="col-md-4">
      <div class="card card-custom h-100 p-3 highlight d-flex align-items-center">
        <div class="d-flex align-items-center">
          <!-- Ảnh bên trái -->
          <div style="width: 100px; margin-right: 15px;">
            <img src="./img/HoanTien.webp" width="100" alt="Lịch bay" class="img-fluid">
          </div>
    
          <!-- Nội dung bên phải -->
          <div>
            <h5 class="card-title fw-bold mb-1">Hoàn tiền</h5>
            <p class="card-text mb-0">Dễ dàng yêu cầu hủy và hoàn tiền cho đặt chỗ của bạn</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Check-in trực tuyến -->
    <div class="col-md-4">
      <div class="card card-custom h-100 p-3 highlight d-flex align-items-center">
        <div class="d-flex align-items-center">
          <!-- Ảnh bên trái -->
          <div style="width: 100px; margin-right: 15px;">
            <img src="./img/thuTuc.webp" width="100" alt="Lịch bay" class="img-fluid">
          </div>
    
          <!-- Nội dung bên phải -->
          <div>
            <h5 class="card-title fw-bold mb-1">Thủ tục check-in trực tuyến</h5>
            <p class="card-text mb-0">Nhận thẻ lên máy bay trước khi làm thủ tục check-in trực tuyến.</p>
          </div>
        </div>
      </div>
    </div>


  </div>
</div>
<div class="fixed-container">
  <div class="row">
    <!-- bên trái -->
    <h1 style="font-weight: bold; font-size: 25px;">Những chủ đề nổi bật nhất</h1>
    <div class="col-6">
      <ul class="nav nav-tabs mt-3 mb-3" id="myTab" role="tablist">
        <li class="nav-item" role="presentation">
          <button class="nav-link active" id="flight-tab" data-bs-toggle="tab" data-bs-target="#flight" type="button" role="tab" >Vé máy bay</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="hotel-tab" data-bs-toggle="tab" data-bs-target="#hotel" type="button" role="tab">Khách sạn</button>
        </li>
      </ul>

      <div class="tab-content" id="myTabContent">
        <!-- tab chuyến bay -->
        <div class="tab-pane fade show active" id="flight" role="tabpanel">
          <div class="accordion" id="accordionFlight">
            <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#f1" ><b>Tôi có thể thay đổi chuyến bay của mình không?</b></button>
                </h2>
                <div id="f1" class="accordion-collapse collapse" data-bs-parent="#accordionFlight">
                  <div class="accordion-body">
                    <p>Mỗi vé máy bay có điều kiện cụ thể riêng, đặc biệt khi bạn muốn đổi lịch bay. Bạn có thể kiểm tra điều kiện cụ thể cho chuyến bay của mình bằng cách tìm kiếm. Nếu trong chi tiết chuyến bay có thuật ngữ Đổi lịch bay, nghĩa là bạn có thể thay đổi chuyến bay của mình. Tuy nhiên, xin lưu ý rằng có những trường hợp vé của bạn có thể không đủ điều kiện để đổi lịch bay.</p>
                    <br>
                    Để thay đổi ngày bay hoặc đổi lịch bay, vui lòng làm theo các bước sau:<br>
                    Hãy truy cập trang web của chúng tôi và truy cập phần Đơn hàng.
                    <ol>
                      <li>Nhập mã Airpaz và địa chỉ email được liên kết với đặt chỗ của bạn.</li>
                      <li>Nhấn vào Tìm kiếm</li>
                      <li>Chọn Thay đổi chuyến bay từ menu và làm theo các bước sau.</li>
                    </ol>
                    Nếu bạn là thành viên:
                    <ol>
                      <li>Hãy đăng nhập vào trang web của chúng tôi bằng thông tin đăng nhập của bạn.</li>
                      <li>Vào phần Đơn hàng.</li>
                      <li>Nhập mã Airpaz của bạn</li>
                      <li>Nhấn vào Tìm kiếm</li>
                      <li>Chọn Thay đổi chuyến bay từ menu và tiến hành các bước sau.</li>
                    </ol>
                  </div>
                </div>
              </div>

              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#f2"><b>Tôi muốn thêm hành lý quá cước</b></button>
                </h2>
                <div id="f2" class="accordion-collapse collapse" data-bs-parent="#accordionFlight">
                  <div class="accordion-body">
                    Để thêm hành lý vào đặt chỗ của bạn, vui lòng làm theo các bước sau:
                    <ol>
                      <li>Hãy truy cập trang web của chúng tôi và chọn phần Đơn hàng.</li>
                      <li>Nhập mã Airpaz và địa chỉ email được liên kết với đặt chỗ của bạn.</li>
                      <li>Nhấn vào tìm kiếm</li>
                      <li>Chọn Thêm hành lý từ menu và làm theo các bước sau.</li>
                    </ol>
                    Nếu bạn là thành viên:
                    <ol>
                      <li>Hãy đăng nhập vào trang web của chúng tôi bằng thông tin đăng nhập của bạn.</li>
                      <li>Chọn phần Đơn hàng.</li>
                      <li>Nhập mã Airpaz của bạn.</li>
                      <li>Nhấn vào Tìm kiếm.</li>
                      <li>Chọn Thêm hành lý từ menu và tiến hành các bước sau.</li>
                    </ol>
                  </div>
                </div>
              </div>

              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#f3"><b>Làm thế nào để tôi có thể chỉnh sửa dữ liệu hành khách?</b></button>
                </h2>
                <div id="f3" class="accordion-collapse collapse" data-bs-parent="#accordionFlight">
                  <div class="accordion-body">
                    Để chỉnh sửa thông tin hành khách, vui lòng thực hiện các bước sau:
                    <ol>
                      <li>Truy cập trang web của chúng tôi và điều hướng đến phần Đơn đặt hàng.</li>
                      <li>Nhập mã Airpaz của bạn và địa chỉ email liên kết với đơn đặt hàng của bạn.</li>
                      <li>Click vào Tìm kiếm.</li>
                      <li>Chọn tùy chọn Thay đổi Thông tin Hành khách từ menu và tiếp tục với các bước sau.</li>
                    </ol>
                    Nếu bạn là thành viên:
                    <ol>
                      <li>Đăng nhập vào trang web của chúng tôi bằng thông tin đăng nhập của bạn.</li>
                      <li>Chuyển đến phần Đơn đặt hàng.</li>
                      <li>Nhập mã Airpaz của bạn.</li>
                      <li>Click vào Tìm kiếm.</li>
                      <li>Chọn tùy chọn Thay đổi Thông tin Hành khách từ menu và tiếp tục với các bước sau.</li>
                    </ol>
                    Vui lòng lưu ý: <br>
                    Thay đổi vé máy bay thường đi kèm với chi phí bổ sung, ngay cả đối với các sửa đổi nhỏ như sửa một lỗi nhỏ trong tên của bạn.
                  </div>
                </div>
              </div>
              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#f4"><b>Tôi có thể huỷ vé của mình hoặc một trong các vé của hành khách khác không?</b></button>
                </h2>
                <div id="f4" class="accordion-collapse collapse show" data-bs-parent="#accordionFlight">
                  <div class="accordion-body">
                    Mỗi vé đều có điều kiện huỷ riêng. Bạn có thể xem trong email đặt vé máy bay của mình... <br>
                    Xin lưu ý: <br>
                    Có những trường hợp vé của bạn không thể bị hủy và trong những trường hợp đó, bạn sẽ không được hoàn tiền. <br>
                    Nếu bạn chắc chắn muốn hủy vé, vui lòng làm theo các bước sau để gửi yêu cầu hủy:
                    <ol>
                      <li>Hãy truy cập trang web của chúng tôi và chọn phần Đơn hàng.</li>
                      <li>Nhập mã Airpaz và địa chỉ email được liên kết với đặt chỗ của bạn.</li>
                      <li>Nhấn vào Tìm kiếm.</li>
                      <li>Chọn Hủy chuyến bay từ menu và điền vào biểu mẫu.</li>
                    </ol>
                    Nếu bạn là thành viên:
                    <ol>
                      <li>Hãy đăng nhập vào trang web của chúng tôi bằng thông tin đăng nhập của bạn.</li>
                      <li>Vào phần Đơn hàng.</li>
                      <li>Nhập mã Airpaz của bạn.</li>
                      <li>Nhấn vào Tìm kiếm.</li>
                    </ol>
                  </div>
                </div>
              </div>

              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#f5"><b>Không có xác nhận sau khi thanh toán xong</b></button>
                </h2>
                <div id="f5" class="accordion-collapse collapse show" data-bs-parent="#accordionFlight">
                  <div class="accordion-body">
                    Bạn sẽ nhanh chóng nhận được vé điện tử qua email sau khi hoàn tất quá trình đặt chỗ với hãng hàng không. Vé điện tử này đóng vai trò là bằng chứng bạn đã đặt vé cho chuyến bay của bạn. Nó bao gồm các chi tiết cần thiết như vé máy bay, thông tin hành khách, số vé và chi tiết giá vé. <br>
                    Mặc dù chúng tôi cố gắng đảm bảo gửi email một cách nhanh chóng, nhưng bạn cần lưu ý là đôi khi email xác nhận, cùng với vé điện tử và biên lai, có thể bị đưa nhầm vào mục thư rác trong email của bạn. Chúng tôi khuyên bạn nên kiểm tra kỹ mục thư rác. Có thể email đã được lọc và lưu trữ ở đó. Bằng cách xem nhanh mục thư rác, bạn có thể đảm bảo rằng mình không bỏ lỡ bất kỳ thông tin liên lạc quan trọng nào liên quan đến chuyến bay của mình. <br>
                    Trong trường hợp bạn vẫn không thể tìm thấy email xác nhận hoặc nếu bạn có bất kỳ thắc mắc nào, vui lòng liên hệ với bộ phận hỗ trợ khách hàng của chúng tôi. Chúng tôi luôn sẵn sàng hỗ trợ bạn 24/7 và có thể gửi lại email xác nhận lại nếu cần. Đảm bảo rằng bạn đã nhận được vé điện tử và biên lai là điều quan trọng để có trải nghiệm du lịch suôn sẻ, vì vậy vui lòng liên hệ với chúng tôi để được hỗ trợ về việc đặt vé của bạn. <br>
                  </div>
                </div>
              </div>

          </div>
        </div>

        <!-- tab khách sạn -->
        <div class="tab-pane fade" id="hotel" role="tabpanel">
          <div class="accordion" id="accordionHotel">

             <div class="accordion-item">
              <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#h1"><b>Tôi có thể đổi lịch đặt phòng khách sạn của mình không?</b></button>
              </h2>
              <div id="h1" class="accordion-collapse collapse" data-bs-parent="#accordionHotel">
                <div class="accordion-body">
                  Có, bạn có thể đổi lịch đặt phòng khách sạn bằng cách quản lý đơn hàng trên trang web của chúng tôi. Đây là hướng dẫn dành cho bạn:
                  <ol>
                    <li>Truy cập trang web hoặc ứng dụng của chúng tôi.</li>
                    <li>Chọn phần Đơn hàng, nơi bạn có thể tìm thấy danh sách các đặt chỗ khách sạn của mình.</li>
                    <li>Chọn đặt chỗ khách sạn bạn muốn đổi lịch và chọn tùy chọn Thay đổi ngày.</li>
                    <li>Làm theo hướng dẫn để chọn lại ngày check-in và check-out mới cho đặt phòng của bạn.</li>
                    <li>Xem lại mọi điều khoản, điều kiện hoặc chi phí liên quan đến thay đổi của bạn.</li>
                    <li>Xác nhận các thay đổi và gửi yêu cầu.</li>
                  </ol>
                  <br>
                  Sau khi bạn gửi yêu cầu đổi lịch, bộ phận của chúng tôi sẽ xem xét tình trạng phòng trống cho ngày mới của bạn. Chúng tôi sẽ cố gắng hết sức để đáp ứng yêu cầu của bạn và cung cấp xác nhận về việc đặt lịch lại qua <br>
                  <br>
                  Xin lưu ý rằng việc đổi lịch tùy thuộc vào tình trạng sẵn có cũng như mọi điều khoản và điều kiện hiện hành do khách sạn đặt ra. Trong một số trường hợp, có thể có thêm phí hoặc điều chỉnh giá đặt phòng dựa trên ngày mới hoặc tình trạng phòng trống.
                </div>
              </div>
            </div>

            <div class="accordion-item">
              <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#h2"><b>Tôi có thể huỷ đặt phòng khách sạn không?</b></button>
              </h2>
              <div id="h2" class="accordion-collapse collapse" data-bs-parent="#accordionHotel">
                <div class="accordion-body">
                  Có, thông thường bạn có thể hủy đặt phòng khách sạn, nhưng điều này phụ thuộc vào chính sách hủy cụ thể của khách sạn và loại đặt phòng bạn đã đặt. Đây là những gì bạn cần biết:
                  <ol>
                    <li>Chính sách hủy: Mỗi khách sạn có chính sách hủy riêng, trong đó nêu rõ các điều khoản và điều kiện để hủy đặt phòng. Chính sách này nêu rõ thời hạn hủy miễn phí, mọi khoản phí hoặc hình phạt khi hủy trong một khoảng thời gian nhất định cũng như mọi hạn chế hoặc điều kiện áp dụng. Bạn có thể tìm thấy chính sách hủy trên trang chủ của khách sạn trong quá trình đặt phòng hoặc trong email xác nhận.</li>
                    <li>Thời gian hủy miễn phí: Nhiều chỗ nghỉ cung cấp thời gian hủy miễn phí, cho phép bạn hủy đặt phòng mà không phải trả bất kỳ khoản phí nào trong một khoảng thời gian nhất định. Khoảng thời gian này thường được nêu trong chính sách hủy của nơi lưu trú và có thể thay đổi từ vài giờ đến vài ngày trước ngày nhận phòng. Nếu bạn hủy trong thời gian hủy miễn phí, bạn có thể được hoàn lại toàn bộ số tiền hoặc không phát sinh phí.</li>
                    <li>Đặt chỗ khách sạn không hoàn tiền: Một số đặt phòng không được hoàn tiền, nghĩa là nếu bạn hủy, bạn có thể không đủ điều kiện để được hoàn tiền. Những đặt phòng này thường có mức giá thấp hơn hoặc các lợi thế khác, nhưng chúng phải đánh đổi bằng việc không thể hủy mà không bị phạt. Điều cần thiết là phải xem xét cẩn thận các điều khoản và điều kiện trước khi thực hiện đặt phòng không hoàn tiền.</li>
                    <li>Quá trình hủy: Để hủy đặt phòng khách sạn, bạn chỉ cần thông qua trang web hoặc ứng dụng di động của chúng tôi. Truy cập chi tiết đặt chỗ của bạn trong Đơn đặt hàng và tìm tùy chọn Hủy. Hãy làm theo hướng dẫn được cung cấp và nếu có bất kỳ khoản phí nào được áp dụng, chúng sẽ được nêu rõ ràng trước khi bạn xác nhận việc hủy.</li>
                    <li>Hỗ trợ khách hàng: Nếu bạn có bất kỳ câu hỏi nào hoặc gặp khó khăn khi hủy đặt chỗ, nhóm hỗ trợ khách hàng của chúng tôi sẵn sàng hỗ trợ bạn. Hãy liên hệ với nhóm hỗ trợ của chúng tôi để cung cấp thông tin đặt phòng của bạn và chúng tôi sẽ cung cấp hướng dẫn cũng như trợ giúp bạn trong quá trình hủy.</li>
                  </ol>
                  Điều quan trọng cần lưu ý là chính sách hủy có thể khác nhau tùy theo nơi lưu trú, loại phòng, gói giá và các yếu tố khác. Chúng tôi khuyên bạn nên xem lại chính sách hủy cụ thể đối với đặt phòng của mình và liên hệ với nơi lưu trú hoặc nhóm hỗ trợ khách hàng của chúng tôi nếu bạn cần làm rõ hoặc hỗ trợ thêm. <br>
                  Hãy nhớ hủy đặt phòng của bạn trong khung thời gian quy định để tránh mọi khoản phí hoặc hình phạt có thể xảy ra.
                </div>
              </div>
            </div>
            
            <div class="accordion-item">
              <h2 class="accordion-header">
                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#h3"><b>Tên trên đặt chỗ của tôi có thể thay đổi được không?</b></button>
              </h2>
              <div id="h3" class="accordion-collapse collapse show" data-bs-parent="#accordionHotel">
                <div class="accordion-body">
                    Có, trong hầu hết các trường hợp, bạn có thể thay đổi tên khi đặt phòng khách sạn, nhưng điều quan trọng cần lưu ý là các chính sách và thủ tục cụ thể có thể khác nhau tùy thuộc vào khách sạn và nền tảng đặt phòng bạn đã sử dụng. Dưới đây là các bước chung bạn cần phải xem xét:
                    <ol>
                        <li>Xem lại các điều khoản đặt phòng: Bắt đầu bằng cách kiểm tra các điều khoản và điều kiện được cung cấp trong quá trình đặt phòng hoặc email xác nhận bạn nhận được. Tìm kiếm thông tin liên quan đến việc thay đổi tên, phí sửa đổi và bất kỳ hạn chế hiện hành nào.</li>
                        <li>Kiểm tra chính sách của khách sạn: Các khách sạn khác nhau có chính sách khác nhau về việc thay đổi tên. Hãy truy cập trang của khách sạn trên trang web của chúng tôi và tìm nguyên tắc cụ thể của họ về việc thay đổi hoặc sửa đổi tên.</li>
                        <li>Liên hệ với bộ phận hỗ trợ khách hàng của chúng tôi: Nếu bạn muốn tiến hành thay đổi tên, chúng tôi khuyên bạn nên liên hệ với nhóm hỗ trợ khách hàng của chúng tôi. Họ có thể cung cấp hỗ trợ cá nhân, thông báo cho bạn về các thủ tục cụ thể và trả lời bất kỳ câu hỏi nào bạn có thể có.</li>
                        <li>Cung cấp thông tin cần thiết: Khi liên hệ với bộ phận hỗ trợ khách hàng của chúng tôi, hãy sẵn sàng cung cấp các chi tiết như số xác nhận đặt chỗ của bạn, tên hiện tại trên đặt chỗ và tên mới mong muốn. Thông tin này sẽ giúp tạo thuận lợi cho quá trình thay đổi tên.</li>
                    </ol>
                    Xin lưu ý rằng mặc dù nhiều khách sạn cho phép thay đổi tên nhưng một số khách sạn có thể có những chính sách hoặc hạn chế cụ thể. Nhóm hỗ trợ khách hàng của chúng tôi sẽ thay mặt bạn liên hệ với khách sạn để kiểm tra xem việc thay đổi tên có được phép hay không và liệu có cần thêm bất kỳ khoản phí hoặc tài liệu nào hay không. Họ sẽ hướng dẫn bạn trong suốt quá trình và cung cấp sự hỗ trợ cần thiết.
                </div>
              </div>
            </div>

            <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#h4"><b>Tên trên đặt chỗ của tôi có thể thay đổi được không?</b></button>
                </h2>
                <div id="h4" class="accordion-collapse collapse show" data-bs-parent="#accordionHotel">
                  <div class="accordion-body">
                    Chúng tôi hiểu rằng có thể có những trường hợp bạn cần nhận phòng tại khách sạn dưới một tên khác. Dưới đây là một số điểm quan trọng bạn cần phải xem xét:
                    <ol>
                        <li>Kiểm tra chính sách của khách sạn: Mỗi khách sạn có chính sách riêng về việc đổi tên và thủ tục nhận phòng. Một số khách sạn có thể cho phép nhận phòng dưới một tên khác, trong khi những khách sạn khác có thể yêu cầu tên của khách chính phải có mặt. Điều quan trọng là phải xem lại chính sách của khách sạn hoặc liên hệ với nhóm hỗ trợ khách hàng của chúng tôi để hỏi về các yêu cầu cụ thể của họ.</li>
                        <li>Thông báo trước cho khách sạn: Nếu bạn dự kiến cần một tên khác khi nhận phòng, chúng tôi khuyên bạn nên thông báo trước cho khách sạn. Hãy liên hệ với nhóm hỗ trợ khách hàng của chúng tôi và họ sẽ hỗ trợ bạn chuyển thông tin đến khách sạn. Điều này cho phép khách sạn thực hiện những sắp xếp cần thiết và tránh mọi rắc rối khi nhận phòng.</li>
                        <li>Giấy tờ bắt buộc: Khách sạn có thể yêu cầu giấy tờ hoặc giấy ủy quyền cụ thể để nhận phòng dưới một tên khác. Điều này có thể bao gồm thư ủy quyền bằng văn bản của khách chính hoặc các giấy tờ nhận dạng bổ sung. Đảm bảo bạn đã chuẩn bị trước các tài liệu cần thiết để tạo điều kiện cho quá trình đăng ký diễn ra suôn sẻ.</li>
                        <li>Giao tiếp là chìa khóa: Trao đổi cởi mở với nhóm hỗ trợ khách hàng của chúng tôi và khách sạn để giải thích tình huống và bất kỳ lý do cụ thể nào dẫn đến việc thay đổi tên. Giao tiếp rõ ràng sẽ giúp đảm bảo rằng nhân viên khách sạn sẵn sàng đáp ứng nhu cầu của bạn và mang lại trải nghiệm nhận phòng tích cực.</li>
                    </ol>
                    Điều quan trọng cần lưu ý là chính sách của khách sạn có thể khác nhau và bạn nên liên hệ trực tiếp với nhóm hỗ trợ khách hàng của chúng tôi hoặc khách sạn để thảo luận về trường hợp cụ thể của bạn và xác nhận thủ tục nhận phòng dưới một tên khác. Chúng tôi ở đây để hỗ trợ bạn và làm cho kỳ nghỉ của bạn thuận tiện nhất có thể.
                  </div>
                </div>
              </div>
              
              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#h5"><b>Tôi có thể yêu cầu check-in sớm hoặc check-out muộn không?</b></button>
                </h2>
                <div id="h5" class="accordion-collapse collapse show" data-bs-parent="#accordionHotel">
                  <div class="accordion-body">
                    Chúng tôi hiểu rằng kế hoạch du lịch đôi khi yêu cầu sự linh hoạt về thời gian check-in và check-out. Dưới đây là những điều bạn cần biết về việc yêu cầu check-in sớm hoặc check-out muộn:
                    <ol>
                      <li>Check-in sớm: Check-in sớm cho phép bạn nhận phòng chỗ ở trước thời gian nhận phòng tiêu chuẩn. Mặc dù tùy vào tình trạng sẵn có nhưng bạn có thể yêu cầu check-in sớm trong quá trình đặt phòng hoặc bằng cách liên hệ trực tiếp với nơi lưu trú. Xin lưu ý rằng việc check-in sớm không thể được đảm bảo và thường tùy thuộc vào tình trạng sẵn có của khách sạn vào ngày bạn đến.</li>
                      <li>Check-out muộn: Check-out muộn cho phép bạn kéo dài thời gian lưu trú vượt quá thời gian trả phòng tiêu chuẩn. Giống như check-in sớm, việc check-out muộn tùy thuộc vào tình trạng sẵn có và có thể được yêu cầu trong quá trình đặt phòng hoặc bằng cách liên hệ trực tiếp với nơi lưu trú. Tuy nhiên, khả năng check-out muộn có thể bị hạn chế, đặc biệt là trong thời gian cao điểm hoặc nếu có khách đặt phòng cho cùng một khách sạn.</li>
                      <li>Phụ phí hoặc phí: Một số chỗ nghỉ có thể áp dụng phụ phí hoặc phí khi check-in sớm hoặc check-out muộn. Các khoản phí này thay đổi tùy theo chính sách của nơi lưu trú và thời gian gia hạn. Điều quan trọng là phải xem lại các điều khoản và điều kiện của nơi lưu trú hoặc liên hệ trực tiếp với họ để hỏi về mọi khoản phí tiềm ẩn liên quan đến việc check-in sớm hoặc check-out muộn.</li>
                      Để yêu cầu check-in sớm hoặc check-out muộn, chúng tôi khuyên bạn nên liên hệ trước với nơi lưu trú để thảo luận về các yêu cầu cụ thể của mình và xác nhận tình trạng phòng trống. Nhóm hỗ trợ khách hàng của chúng tôi cũng sẵn sàng hỗ trợ bạn nếu có bất kỳ câu hỏi hoặc thắc mắc nào liên quan đến yêu cầu của bạn. <br>
                      Xin lưu ý rằng việc check-in sớm và check-out muộn tùy thuộc vào quyết định và tình trạng sẵn có của nơi lưu trú. Chúng tôi khuyên bạn nên lên kế hoạch sắp xếp chuyến đi phù hợp và trao đổi sở thích của mình với chỗ nghỉ để nâng cao khả năng đáp ứng yêu cầu của bạn.
                    </ol>
                  </div>
                </div>
            </div>

          </div>
        </div>
      </div>
    </div>

    <!-- bên phải-->
    <div class="col-6">
      <div class="card mb-4">
        <div class="card-body">
          <h5 class="card-title">
            <img src="https://img.icons8.com/ios-filled/24/fa314a/form.png" alt="icon"/>
            Gửi yêu cầu của bạn
          </h5>
          <!-- Chọn yêu cầu -->
          <div class="mb-3">
            <label for="yeucau" class="form-label">Chọn yêu cầu của bạn</label>
            <select class="form-select" id="yeucau">
              <option selected disabled>Chọn một danh mục</option>
              <option>Kiểm tra trạng thái</option>
              <option>Thanh toán</option>
              <option>Vấn đề đặt phòng</option>
              <option>Báo cáo lỗi</option>
              <option>Truyền thông quảng cáo</option>
              <option>Yêu cầu đặc biệt</option>
            </select>
          </div>

          <!-- Chọn mối quan tâm -->
          <div class="mb-3">
            <label for="moiquantam" class="form-label">Chọn mối quan tâm</label>
            <select class="form-select" id="moiquantam">
                <option selected disabled>Chọn một danh mục</option>
                <option>Thêm hành lý</option>
                <option>Hủy bỏ</option>
                <option>Đổi lịch bay</option>
                <option>Thay đổi dữ liệu hành khách</option>
            </select>
          </div>
          <!-- Email -->
          <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" placeholder="diachiemail@email.com">
          </div>

          <!-- Tin nhắn -->
          <div class="mb-3">
            <label for="message" class="form-label">Tin nhắn</label>
            <textarea class="form-control" id="message" rows="1" placeholder="Hãy mô tả chi tiết"></textarea>
          </div>

          <!-- Nút gửi (tuỳ chọn) -->
          <div class="text-end" >
            <button class="btn btn-primary" style="margin-right: 40%;" >Gửi yêu cầu</button>
          </div>
        </div>
      </div>
      <img src="./img/hotroworld.png" alt="" class="">
      <img src="./img/HoTro.webp" alt="" class="img-fluid" />
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
