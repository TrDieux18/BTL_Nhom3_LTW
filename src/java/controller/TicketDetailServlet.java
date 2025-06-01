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
import model.Ticket;

/**
 *
 * @author DELL
 */
@WebServlet(name="TicketDetailServlet", urlPatterns={"/ticketDetail"})
public class TicketDetailServlet extends HttpServlet {

  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HotelDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HotelDetailServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String ticketId = request.getParameter("ticketId");
        Ticket ticket = null;
        String error = null;
        if (ticketId == null || ticketId.trim().isEmpty()) {
            error = "Không tìm thấy ID vé máy bay.";
        } else {
            try {
                TicketDAO ticketDAO = new TicketDAO();
                ticket = ticketDAO.getTicketById(Integer.parseInt(ticketId));
                if (ticket == null) {
                    error = "Không tìm thấy vé máy bay với ID: " + ticketId;
                }
            } catch (NumberFormatException e) {
                error = "ID vé máy bay không hợp lệ.";
            } catch (Exception e) {
                e.printStackTrace();
                error = "Lỗi khi truy xuất thông tin vé máy bay " + e.getMessage();
            }
        }
        if (error != null) {
            request.setAttribute("error", error);
        } else {
            request.setAttribute("ticket", ticket);
        }
        request.getRequestDispatcher("ticketDetail.jsp").forward(request, response);
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