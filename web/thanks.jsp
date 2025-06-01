<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cảm ơn</title>
</head>
<body>
    <jsp:include page="header.jsp" />
    <section class="search-hotel">
        <div class="container py-5 d-flex justify-content-center align-items-center"
             style="color: white; font-size: 48px; height: 600px; display: flex; flex-direction: column; text-align: center;">
            Cảm ơn bạn đã phản hồi !!! 
            <span style="white-space: nowrap;">
                Bạn sẽ trở lại trang chủ sau <span id="countdown">5</span>&nbsp;giây.
            </span>
        </div>
    </section>
    <jsp:include page="footer.jsp" />   
    <script src="./assets/JS/helpform.js"></script>
</body>
</html>
