/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.HotelDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Hotel;

/**
 *
 * @author DELL
 */
@WebServlet(name="HotelDetailServlet", urlPatterns={"/detail"})
public class HotelDetailServlet extends HttpServlet {

  
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
        String hotelId = request.getParameter("hotelId");
        Hotel hotel = null;
        String error = null;
        if (hotelId == null || hotelId.trim().isEmpty()) {
            error = "Không tìm thấy ID khách sạn.";
        } else {
            try {
 
                HotelDAO hotelDAO = new HotelDAO();
                hotel = hotelDAO.getHotelById(Integer.parseInt(hotelId));
                if (hotel == null) {
                    error = "Không tìm thấy khách sạn với ID: " + hotelId;
                }
            } catch (NumberFormatException e) {
                error = "ID khách sạn không hợp lệ.";
            } catch (Exception e) {
                e.printStackTrace();
                error = "Lỗi khi truy xuất thông tin khách sạn: " + e.getMessage();
            }
        }
        if (error != null) {
            request.setAttribute("error", error);
        } else {
            request.setAttribute("hotel", hotel);
        }
        request.getRequestDispatcher("hotelDetail.jsp").forward(request, response);
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