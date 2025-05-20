package controller;

import dal.BookingHistoryDAO;
import dal.HotelBookingDAO;
import dal.HotelDAO;
import dal.TicketDAO;
import dal.UserDAO;
import model.Ticket;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import model.BookingHistory;
import model.Hotel;
import model.HotelBooking;

@WebServlet(name = "ManagementServlet", urlPatterns = {"/management"})
public class ManagementServlet extends HttpServlet {

    private TicketDAO ticketDAO;
    private UserDAO userDao;
    private HotelDAO hotelDAO;
    private BookingHistoryDAO historyDAO;
    private HotelBookingDAO hotelBookingDAO;

    @Override
    public void init() throws ServletException {
        ticketDAO = new TicketDAO();
        userDao = new UserDAO();
        hotelDAO = new HotelDAO();
        historyDAO = new BookingHistoryDAO();
        hotelBookingDAO = new HotelBookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Ticket> tickets = ticketDAO.getAllTickets();
        List<User> users = userDao.getAllUser();
        List<Hotel> hotels = hotelDAO.getAllHotel();
        List<HotelBooking> hotelBookings = hotelBookingDAO.getAllHotelBooking();
        List<BookingHistory> bookingHistorys = historyDAO.getAllBooking();

        request.setAttribute("tickets", tickets);
        request.setAttribute("users", users);
        request.setAttribute("hotels", hotels);
        request.setAttribute("bookingHistorys", bookingHistorys);
        request.setAttribute("hotelBookings", hotelBookings);
        request.getRequestDispatcher("management.jsp").forward(request, response);
    }
}
