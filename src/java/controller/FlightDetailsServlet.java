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
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.Ticket;

/**
 *
 * @author admin
 */
@WebServlet(name="FlightDetailsServlet", urlPatterns={"/flight-details"})
public class FlightDetailsServlet extends HttpServlet {
    private static final long serialVersionUID=1L;
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet FlightDetailsServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FlightDetailsServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        
        String minPriceStr=request.getParameter("minPrice");
        String maxPriceStr=request.getParameter("maxPrice");
        String []selectedAirlines=request.getParameterValues("airline");
        
        //Lấy tham số sắp xếp
        String sortBy=request.getParameter("sortBy");
        if(sortBy==null||sortBy.isEmpty()){
            sortBy="price_asc";
        }
        
        Long minPrice=null;
        Long maxPrice=null;
        List<String> airlines=null;
        
        try{
            if(minPriceStr!=null&&!minPriceStr.isEmpty()){
                minPrice=Long.parseLong(minPriceStr);
            }
            if(maxPriceStr!=null&&!maxPriceStr.isEmpty()){
                maxPrice=Long.parseLong(maxPriceStr);
            }            
        }
        catch (NumberFormatException e){
            request.setAttribute("errorMessage", "Định dạng giá không hợp lệ.");
        }
        
        if(selectedAirlines!=null&&selectedAirlines.length>0){
            airlines=Arrays.asList(selectedAirlines);
            if(airlines.contains("all")){
                airlines=null;
            }
        }
        
        TicketDAO ticketDAO=new TicketDAO();
        List<Ticket> flightResults=null;
        
        if (origin!=null&&destination!=null&&!origin.isEmpty()&&!destination.isEmpty()){
            flightResults=ticketDAO.getFilteredTickets(origin, destination, minPrice, maxPrice, airlines, sortBy);
        }
        else{
            System.out.println("Cảnh báo");
            request.setAttribute("errorMessage", "Vui lòng cung cấp điểm đi và điểm đến.");
            request.getRequestDispatcher("flight-details"
                    + ".jsp");
            return;
        }
        //Đặt các thuộc tính vào request scope để JSP có thể truy cập
        request.setAttribute("origin", origin);
        request.setAttribute("destination", destination);
        request.setAttribute("flightResults", flightResults);
        
        request.setAttribute("selectedMinPrice", minPrice);
        request.setAttribute("selectedMaxPrice", maxPrice);
        request.setAttribute("selectedAirlines", (airlines!=null ? new ArrayList<>(airlines) : new ArrayList<>()));
        request.setAttribute("selectedSortBy", sortBy);
        
        //Chuyển tiếp request và response đến trang JSP hiển thị kết quả
        request.getRequestDispatcher("flight-details.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
