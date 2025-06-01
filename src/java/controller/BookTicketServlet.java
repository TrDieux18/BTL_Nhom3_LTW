/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BookingHistoryDAO;
import dal.TicketDAO;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import model.Hotel;
import model.Ticket;
import model.User;

/**
 *
 * @author DELL
 */
@WebServlet(name="BookTicketServlet", urlPatterns={"/bookTicket"})
public class BookTicketServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BookServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookServlet at " + request.getContextPath () + "</h1>");
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
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");

    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
        request.setAttribute("error", "Bạn cần đăng nhập để đặt vé máy bay.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        return;
    }

    try {
        // Lấy dữ liệu từ form
        int ticketId = Integer.parseInt(request.getParameter("hotelId"));
        int ticketQuantity = Integer.parseInt(request.getParameter("quantity"));
        String note = request.getParameter("note");
        String status = request.getParameter("status");

        // Validate dữ liệu

        if (ticketQuantity < 1) {
            throw new IllegalArgumentException("Số lượng vé phải lớn hơn 0.");
        }

        if (status == null || !status.matches("Pending|Confirmed|Cancelled")) {
            throw new IllegalArgumentException("Trạng thái không hợp lệ.");
        }

        // Lấy thông tin vé máy bay
        TicketDAO ticketDAO = new TicketDAO();
        Ticket ticket = ticketDAO.getTicketById(ticketId);
        if (ticket == null) {
            throw new IllegalArgumentException("Không tìm thấy vé!");
        } 
        
        
        String pricePerTicket = ticket.getPrice();
        if (pricePerNight == null) {
            throw new IllegalArgumentException("Giá phòng không khả dụng.");
        }

        Long totalPrice = pricePerNight * roomQuantity * numberOfNights;

        LocalDateTime now = LocalDateTime.now();
        String bookingDate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // Ghi dữ liệu đặt phòng vào database
        ticketDAO.insertBooking(
            user.getId(),
            hotelId,
            hotel.getName(),
            checkIn,
            checkOut,
            bookingDate,
            roomQuantity,
            note,
            totalPrice,
            status
        );

        request.getSession().setAttribute("successMessage", "Chúc mừng bạn đã đặt khách sạn " + hotel.getName() + " thành công.");
        response.sendRedirect("hotelList");

    } catch (NumberFormatException e) {
        request.setAttribute("error", "Dữ liệu không hợp lệ: " + e.getMessage());
        request.getRequestDispatcher("ticketDetail.jsp").forward(request, response);

    } catch (IllegalArgumentException e) {
        request.setAttribute("error", e.getMessage());

        // Gửi lại dữ liệu người dùng nhập vào để giữ form
        request.setAttribute("hotelId", request.getParameter("hotelId"));
        request.setAttribute("checkIn", request.getParameter("checkIn"));
        request.setAttribute("checkOut", request.getParameter("checkOut"));
        request.setAttribute("roomQuantity", request.getParameter("roomQuantity"));
        request.setAttribute("note", request.getParameter("note"));
        request.setAttribute("status", request.getParameter("status"));

        // Lấy lại thông tin khách sạn để hiển thị chi tiết
        HotelDAO hotelDAO = new HotelDAO();
        Hotel hotel = hotelDAO.getHotelById(Integer.parseInt(request.getParameter("hotelId")));
        request.setAttribute("hotel", hotel);

        request.getRequestDispatcher("hotelDetail.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        request.getRequestDispatcher("hotelDetail.jsp").forward(request, response);
    }
}

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}