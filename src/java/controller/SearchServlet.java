    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.TicketFlightDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.TicketFlight;
import model.TicketFlight_inter;

/**
 *
 * @author DELL
 */
@WebServlet(name = "searchServlet", urlPatterns = {"/deal"})
public class SearchServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet searchServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet searchServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       TicketFlightDAO dao = new TicketFlightDAO();
    // lấy danh sách categories
    List<Category> list = dao.getAll();
    request.setAttribute("categories", list);

    String cid_raw = request.getParameter("key");
    String price = request.getParameter("price");
    int cid = 0;
    if (cid_raw != null && !cid_raw.isEmpty()) {
        try {
            cid = Integer.parseInt(cid_raw);
        } catch (NumberFormatException e) {
            System.err.println("Lỗi chuyển đổi category ID: " + e.getMessage());
        }
    }
    if (price == null) price = "all";

    // Lấy dữ liệu vé nội địa
    List<TicketFlight> tickets = dao.getTicketFlightsByFilter(cid, price);
    // Lấy dữ liệu vé quốc tế
    List<TicketFlight_inter> tickets_inter = dao.getTicketFlightsInterByFilter(cid, price);

    request.setAttribute("tickets", tickets);
    request.setAttribute("tickets_inter", tickets_inter);
    request.getRequestDispatcher("deals").forward(request, response);
        
    }
    

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
