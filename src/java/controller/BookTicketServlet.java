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
import jakarta.servlet.jsp.PageContext;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import model.BookingHistory;
import model.Hotel;
import model.Ticket;
import model.User;

/**
 *
 * @author DELL
 */
@WebServlet(name = "BookTicketServlet", urlPatterns = {"/bookTicket"})
public class BookTicketServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<h1>Servlet BookServlet at " + request.getContextPath() + "</h1>");
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

        // Lấy session và user đăng nhập
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            // Chưa đăng nhập => chuyển về trang login
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String ticketIdStr = request.getParameter("ticketId");
        String bookingDate = request.getParameter("bookingDate");
        String quantityStr = request.getParameter("ticketQuantity");

        if (ticketIdStr == null || quantityStr == null) {
            // Sai tham số => báo lỗi hoặc chuyển về trang đặt vé
            request.setAttribute("error", "Thiếu thông tin đặt vé.");
            request.getRequestDispatcher("ticketDetail.jsp").forward(request, response);
            return;
        }

        try {
            int ticketId = Integer.parseInt(ticketIdStr);
            int quantity = Integer.parseInt(quantityStr);

            // Lấy thông tin vé từ DB
            TicketDAO ticketDAO = new TicketDAO();
            Ticket ticket = ticketDAO.getTicketById(ticketId);
            if (ticket == null) {
                request.setAttribute("error", "Vé không tồn tại.");
                request.getRequestDispatcher("ticketDetail.jsp").forward(request, response);
                return;
            }

            // Tính tổng tiền
            double totalPrice = (double) (Double.parseDouble(ticket.getPrice()) * quantity);

            // Tạo đối tượng BookingHistory
            BookingHistory booking = new BookingHistory();
            booking.setUserId(user.getId());
            booking.setUserName(user.getFullname());
            booking.setTicketId(ticket.getId());
            booking.setOrigin(ticket.getOrigin());
            booking.setDestination(ticket.getDestination());
            booking.setTypeTicket(ticket.getType());
            booking.setPayment("MoMo");  // hoặc giá trị phù hợp
            booking.setOrderStatus("Pending");  // hoặc giá trị phù hợp
            booking.setQuantity(quantity);
            booking.setTotalPrice(totalPrice);

            // Lưu vào DB
            BookingHistoryDAO bookingDAO = new BookingHistoryDAO();
            // Sau khi insertBooking thành công
            boolean inserted = bookingDAO.insertBooking(booking, bookingDate);
            if (inserted) {
               request.getSession().setAttribute("ticket", ticket);
                request.getSession().setAttribute("message", "Đặt vé thành công!");
                response.sendRedirect("ticketDetail.jsp");
            } else {
                request.setAttribute("error", "Đặt vé thất bại, vui lòng thử lại.");
                request.getRequestDispatcher("ticketDetail.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Thông tin số lượng hoặc mã vé không hợp lệ.");
            request.getRequestDispatcher("ticketDetail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();  // In ra console để debug
            request.setAttribute("error", "Lỗi hệ thống: " + (e.getMessage() != null ? e.getMessage() : "Có lỗi xảy ra, vui lòng thử lại."));
            request.getRequestDispatcher("ticketDetail.jsp").forward(request, response);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
