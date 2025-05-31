/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.HotelDAO;
import model.Ticket;
import model.Hotel;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.http.*;
/**
 *
 * @author manhdung
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    private TicketDAO ticketDAO;
    private HotelDAO hotelDAO;

    @Override
    public void init() throws ServletException {
        ticketDAO = new TicketDAO();
        hotelDAO = new HotelDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
          
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Ticket> ticketsInCart = new ArrayList<>();
        List<Hotel> hotelsInCart = new ArrayList<>();

        // Lấy tất cả cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                // Định dạng cookie: ticket_123, hotel_45
                String name = cookie.getName();
                String value = cookie.getValue(); // Không cần thiết nếu chỉ cần tên

                try {
                    if (name.startsWith("ticket_")) {
                        int ticketId = Integer.parseInt(name.substring(7));
                        Ticket ticket = ticketDAO.getTicketById(ticketId);
                        if (ticket != null) ticketsInCart.add(ticket);
                    } else if (name.startsWith("hotel_")) {
                        int hotelId = Integer.parseInt(name.substring(6));
                        Hotel hotel = hotelDAO.getHotelById(hotelId);
                        if (hotel != null) hotelsInCart.add(hotel);
                    }
                } catch (NumberFormatException e) {
                    // Bỏ qua cookie không hợp lệ
                    e.printStackTrace();
                }
            }
        }

        // Gửi danh sách sang JSP
        request.setAttribute("ticketsInCart", ticketsInCart);
        request.setAttribute("hotelsInCart", hotelsInCart);

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
