package controller;

import dal.TicketDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Ticket;

import java.io.IOException;
import java.util.*;

@WebServlet(name = "SelectTicketServlet", urlPatterns = {"/selectticket"})
public class SelectTicketServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        String maxPriceParam = request.getParameter("maxPrice");
        String minPriceParam = request.getParameter("minPrice");
        String[] selectedAirlines = request.getParameterValues("airline");
        String sortBy = request.getParameter("sortBy");

        // Kiểm tra đầu vào cơ bản
        if (origin == null || destination == null || origin.isEmpty() || destination.isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng chọn nơi đi và nơi đến.");
            request.getRequestDispatcher("selectTicket.jsp").forward(request, response);
            return;
        }

        // Chuyển đổi giá
        int maxPrice = 3500000;
        int minPrice = 500000;
        try {
            if (maxPriceParam != null) maxPrice = Integer.parseInt(maxPriceParam);
            if (minPriceParam != null) minPrice = Integer.parseInt(minPriceParam);
        } catch (NumberFormatException e) {
            // ignore, giữ giá mặc định
        }

        // Xử lý danh sách hãng hàng không
        List<String> airlineFilter = new ArrayList<>();
        if (selectedAirlines != null && !Arrays.asList(selectedAirlines).contains("all")) {
            airlineFilter.addAll(Arrays.asList(selectedAirlines));
        }

        // Gọi DAO lọc danh sách vé
        TicketDAO dao = new TicketDAO();
        List<Ticket> ticketList = dao.searchSelectTickets(origin, destination, minPrice, maxPrice, airlineFilter, sortBy);

        // Đưa dữ liệu về cho JSP
        request.setAttribute("origin", origin);
        request.setAttribute("destination", destination);
        request.setAttribute("selectedMaxPrice", maxPrice);
        request.setAttribute("selectedSortBy", sortBy);
        request.setAttribute("selectedAirlines", airlineFilter);
        request.setAttribute("ticketList", ticketList);

        request.getRequestDispatcher("selectTicket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Đảm bảo POST cũng xử lý như GET
    }

    @Override
    public String getServletInfo() {
        return "SelectTicketServlet - xử lý lọc và sắp xếp vé máy bay";
    }
}
