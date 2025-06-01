package controller;

import dal.TicketDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Ticket;

@WebServlet(name = "TicketSearchServlet", urlPatterns = {"/ticketList"})
public class TicketSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        String departuretime = request.getParameter("departuretime");

        String type = request.getParameter("type");

        TicketDAO ticketDAO = new TicketDAO();
        List<Ticket> tickets;

        boolean isEmptySearch
                = (origin == null || origin.trim().isEmpty())
                && (destination == null || destination.trim().isEmpty())
                && (departuretime == null || departuretime.trim().isEmpty())
                && (type == null || type.trim().isEmpty());

        if (isEmptySearch) {
            tickets = ticketDAO.getAllTickets();
        } else {
            tickets = ticketDAO.searchTicketsForm(origin, destination, departuretime, type);
        }

        int mid = tickets.size() / 3;
        List<Ticket> recommendedTickets = tickets.subList(0, mid);

        request.setAttribute("recommendedTickets", recommendedTickets);

        request.getRequestDispatcher("ticket.jsp").forward(request, response);
    }
}
