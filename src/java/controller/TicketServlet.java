package controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Ticket;
import dal.TicketDAO;

@WebServlet(name = "TicketServlet", urlPatterns = {"/ticket"})
public class TicketServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            String idStr = request.getParameter("id");
            String airline = request.getParameter("airline");
            String origin = request.getParameter("origin");
            String destination = request.getParameter("destination");
            String departureStr = request.getParameter("departuretime");
            String arriveStr = request.getParameter("arrivetime");
            String type = request.getParameter("type");
            String price = request.getParameter("price");
            String estimatedTime = request.getParameter("estimatedtime");

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime departure = LocalDateTime.parse(departureStr, formatter);
            LocalDateTime arrive = LocalDateTime.parse(arriveStr, formatter);

            Ticket ticket = new Ticket();
            ticket.setAirline(airline);
            ticket.setOrigin(origin);
            ticket.setDestination(destination);
            ticket.setDeparturetime(departure);
            ticket.setArrivetime(arrive);
            ticket.setType(type);
            ticket.setPrice(price);
            ticket.setEstimatedtime(estimatedTime);
            ticket.setModifiedDate(LocalDateTime.now());
            ticket.setCreatedBy("admin");

            TicketDAO dao = new TicketDAO();

            if (idStr != null && !idStr.isEmpty()) {
                // ✅ Nếu có id → cập nhật
                ticket.setId(Integer.parseInt(idStr));
                dao.update(ticket);
            } else {
                // ✅ Nếu không có id → thêm mới
                dao.insert(ticket);
            }

            response.sendRedirect("management");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi thêm/cập nhật vé: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String id = request.getParameter("id");

        TicketDAO ticketDAO = new TicketDAO();

        try {
            if ("edit".equals(action)) {

                if (id != null && !id.isEmpty()) {
                    Ticket ticket = ticketDAO.getTicketById(Integer.parseInt(id));
                    request.setAttribute("ticket", ticket);
                    request.getRequestDispatcher("addTicket.jsp").forward(request, response);
                    return;
                } else {

                    response.sendRedirect("management");
                    return;
                }
            } else if ("delete".equals(action)) {

                if (id != null && !id.isEmpty()) {
                    ticketDAO.delete(Integer.parseInt(id));
                }
                response.sendRedirect("management");
            } else if ("search".equals(action)) {
                String airline = request.getParameter("airline");
                String origin = request.getParameter("origin");
                String destination = request.getParameter("destination");
                String priceStr = request.getParameter("price");
                String sortBy = request.getParameter("sortBy"); 

              

                TicketDAO dao = new TicketDAO();
                var result = dao.searchTickets(airline, origin, destination,priceStr, sortBy);
       
                request.setAttribute("tickets", result);
                  request.setAttribute("tab", "ticket");
                request.getRequestDispatcher("management.jsp").forward(request, response);
            
                return;
            } else {
                response.sendRedirect("management");
            }
        } catch (Exception e) {
            e.printStackTrace();

            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý yêu cầu: " + e.getMessage());
        }
    }

}
