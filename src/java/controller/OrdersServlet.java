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
                int userId = Integer.parseInt(id);

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
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles display of user's flight tickets and hotel bookings.";
    }
}
