
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;


@WebServlet(name = "AddtoCartServlet", urlPatterns = {"/addtocart"})
public class AddtoCartServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddtoCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddtoCartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String type = request.getParameter("type");
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String price = request.getParameter("price");

    if (type != null && id != null && name != null && price != null) {
        // Tạo cookie key duy nhất
        String cookieName = "cart_" + type + "_" + id;

        // Encode giá trị để tránh lỗi ký tự đặc biệt
        String cookieValue = URLEncoder.encode(name + ":" + price + ":" + type, "UTF-8");

        // Tạo cookie
        Cookie cartCookie = new Cookie(cookieName, cookieValue);
        cartCookie.setMaxAge(7 * 24 * 60 * 60); // 1 tuần
        cartCookie.setPath("/"); // Cho phép toàn bộ project sử dụng cookie này

        response.addCookie(cartCookie);
    }

    // Sau khi thêm, chuyển hướng đến cart.jsp
    response.sendRedirect("cart.jsp");
}
  
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
