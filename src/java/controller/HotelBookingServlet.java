package controller;

import dal.HotelBookingDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.HotelBooking;

@WebServlet(name = "HotelBookingServlet", urlPatterns = {"/hotelBooking"})
public class HotelBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HotelBookingDAO dao = new HotelBookingDAO();

        try {
            if ("search".equals(action)) {
                String userName = request.getParameter("userName");
                String hotelName = request.getParameter("hotelName");
                String sortBy = request.getParameter("sortBy");

                List<HotelBooking> list = dao.searchHotelBooking(userName, hotelName, sortBy);
                request.setAttribute("tab", "hotelBooking");
                request.setAttribute("hotelBookings", list);
                request.getRequestDispatcher("management.jsp").forward(request, response);
                return;
            } else {
                response.sendRedirect("management");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý yêu cầu: " + e.getMessage());
        }
    }
}
