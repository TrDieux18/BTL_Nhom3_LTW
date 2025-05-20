package controller;

import dal.BookingHistoryDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BookingHistory;

@WebServlet(name = "BookingHistoryServlet", urlPatterns = {"/bookingHistory"})
public class BookingHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        BookingHistoryDAO dao = new BookingHistoryDAO();

        try {
            if ("search".equals(action)) {
                String userName = request.getParameter("userName");
                String typeTicket = request.getParameter("typeTicket");
                String origin = request.getParameter("origin");
                String destination = request.getParameter("destination");
                String sortBy = request.getParameter("sortBy");

                List<BookingHistory> list = dao.searchBookingHistories(userName, typeTicket, origin, destination, sortBy);
                 request.setAttribute("tab", "bookingHistory");
                request.setAttribute("bookingHistorys", list);
                 request.getRequestDispatcher("management.jsp").forward(request, response);
                 return;
            } else {
                // Hiển thị mặc định nếu không search
                  response.sendRedirect("management");
            return;
            }

           

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý yêu cầu: " + e.getMessage());
        }
    }
}
