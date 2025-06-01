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
        HotelBookingDAO bookingDAO = new HotelBookingDAO();

        try {
            if (action == null || action.equals("search")) {
             
                String userName = request.getParameter("userName");
                String hotelName = request.getParameter("hotelName");
                String sortBy = request.getParameter("sortBy");

                List<HotelBooking> bookings = bookingDAO.searchHotelBooking(userName, hotelName, sortBy);
                request.setAttribute("hotelBookings", bookings);

            } else {
                List<Object[]> statistics = null;

                switch (action) {
                    case "statByUser":
                        statistics = bookingDAO.getStatisticsByUser();
                        break;
                    case "statByHotel":
                        statistics = bookingDAO.getStatisticsByHotel();
                        break;
                    default:
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tham số 'action' không hợp lệ.");
                        return;
                }

                request.setAttribute("statistics", statistics);
            }

            // Gán tab hiện tại và chuyển hướng tới JSP
            request.setAttribute("tab", "hotelBooking");
            request.getRequestDispatcher("management.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Đã xảy ra lỗi khi xử lý dữ liệu: " + e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    if ("updateStatus".equals(action)) {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String newStatus = request.getParameter("status");

        HotelBookingDAO dao = new HotelBookingDAO(); // Hoặc bạn đang dùng DAO nào
        dao.updateStatusHotel(bookingId, newStatus);

        response.sendRedirect(request.getContextPath() + "/hotelBooking?tab=hotelBooking&action=search");
    }
}


}
