package controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Ticket;
import dal.TicketDAO;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)

@WebServlet(name = "TicketServlet", urlPatterns = {"/ticket"})
public class TicketServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

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
            
            Part imagePart = request.getPart("imageFile");
             String imageFileName = null;

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
            if (imagePart != null && imagePart.getSize() > 0) {
                String realPath = getServletContext().getRealPath("/uploads");
                File uploadDir = new File(realPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                imageFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String imagePath = realPath + File.separator + imageFileName;

                imagePart.write(imagePath);

                ticket.setImage("assets/images/flight/" + imageFileName);
            } else if (ticket.getImage() == null || ticket.getImage().isEmpty()) {
                response.getWriter().println("Bạn cần thêm hình ảnh.");
                return;
            }

            if (idStr != null && !idStr.isEmpty()) {
                ticket.setId(Integer.parseInt(idStr));
                dao.update(ticket);
                session.setAttribute("message", "Cập nhật vé thành công!");
                session.setAttribute("alertType", "success");
                  request.getRequestDispatcher("addTicket.jsp").forward(request, response);
            } else {
                dao.insert(ticket);
                session.setAttribute("message", "Thêm vé mới thành công!");
                session.setAttribute("alertType", "success");
                request.getRequestDispatcher("addTicket.jsp").forward(request, response);
            }

      

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi khi thêm/cập nhật vé: " + e.getMessage());
            request.setAttribute("alertType", "error");
            request.getRequestDispatcher("addTicket.jsp").forward(request, response);
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
                var result = dao.searchTickets(airline, origin, destination, priceStr, sortBy);

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
