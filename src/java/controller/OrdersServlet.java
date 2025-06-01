package controller;

import dal.BookingHistoryDAO;
import dal.HotelBookingDAO;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.HotelBooking;
import model.Ticket;

@WebServlet(name = "OrdersServlet", urlPatterns = {"/orders"})
public class OrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String id = request.getParameter("id");
        String type = request.getParameter("type");

        BookingHistoryDAO ticketDAO = new BookingHistoryDAO();
        HotelBookingDAO hotelBookingDAO = new HotelBookingDAO();

        if ("get".equals(action)) {
            if (id != null && !id.isEmpty()) {
                String userId = id;

                if ("flight".equals(type)) {
                    List<Ticket> tickets = ticketDAO.getTicketsByUserId(userId);
                    request.setAttribute("tickets", tickets);
                } else if ("hotel".equals(type)) {
                    List<HotelBooking> hotelBookings = hotelBookingDAO.getHotelBookingsByUserId(userId);
                    request.setAttribute("hotelBookings", hotelBookings);
                } else {
                    List<Ticket> tickets = ticketDAO.getTicketsByUserId(userId);
                    List<HotelBooking> hotelBookings = hotelBookingDAO.getHotelBookingsByUserId(userId);
                    request.setAttribute("tickets", tickets);
                    request.setAttribute("hotelBookings", hotelBookings);
                }

                request.setAttribute("type", type);
                request.getRequestDispatcher("orders.jsp").forward(request, response);
            } else {
                response.sendRedirect("account.jsp");
            }
        }
    }

   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    String type = request.getParameter("type");
    String bookingId = request.getParameter("bookingdeleteId");
    String userId = request.getParameter("userId");
    boolean success = false;
    String message = "";
    try {
        if ("delete".equals(action)) {
            if ("flight".equals(type)) {
                BookingHistoryDAO ticketDAO = new BookingHistoryDAO();
                success = ticketDAO.deleteTicket(Integer.parseInt(bookingId));
                message = success ? "Hủy vé máy bay thành công" : "Hủy vé máy bay không thành công";
            }if ("hotel".equals(type)) {
                HotelBookingDAO hotelBookingDAO = new HotelBookingDAO();
                success = hotelBookingDAO.deleteHotelBooking(Integer.parseInt(bookingId));
                message = success ? "Hủy đặt phòng thành công" : "Hủy đặt phòng không thành công";
            }
            if (success) {
                request.getSession().setAttribute("message", message);
            } else {
                request.getSession().setAttribute("error", message);
            }
        }
    } catch (Exception e) {
        request.getSession().setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
    }
    response.sendRedirect(request.getContextPath() + "/orders?action=get&type=" + type + "&id=" + userId);
}

    @Override
    public String getServletInfo() {
        return "Handles display of user's flight tickets and hotel bookings.";
    }
}
