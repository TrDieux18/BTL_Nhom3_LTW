<%-- 
    Document   : carousel
    Created on : May 17, 2025, 7:43:51 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./assets/css/bootstrap.min.css" />
    <title>Bán vé máy bay</title>
    <link rel="stylesheet" href="./assets/css/reset.min.css" />
    <link rel="stylesheet" href="./assets/css/base.css" />
    <link rel="stylesheet" href="./assets/css/styles.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link rel="stylesheet" href="./assets/font/fontawesome-free-6.7.2-web/fontawesome/css/all.min.css"/>
    </head>
    <body>
        <main class="register-container">
    <!-- Phần carousel -->
    <section class="carousel-section">
            <div class="carousel-container">
            <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" data-interval="3000">
                <ol class="carousel-indicators">
                  <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                  <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active"><img src="assets/images/p1.jpg" alt="First slide" /></div>
                    <div class="carousel-item"><img src="assets/images/p2.jpg" alt="Second slide" /></div>
                </div>
            </div>
          </div>
    </section>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
