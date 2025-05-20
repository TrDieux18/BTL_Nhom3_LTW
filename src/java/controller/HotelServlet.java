/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.HotelDAO;
import dal.TicketDAO;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.Hotel;
import model.Ticket;

/**
 *
 * @author pc
 */
@WebServlet(name = "HotelServlet", urlPatterns = {"/hotel"})
public class HotelServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            String idStr = request.getParameter("id");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String contactInfo = request.getParameter("contactInfo");
            String rating = request.getParameter("rating");
            String pricePerNight = request.getParameter("pricePerNight");

            Hotel hotel = new Hotel();

            hotel.setName(name);
            hotel.setAddress(address);
            hotel.setContact_info(contactInfo);
            hotel.setRating(rating);
            hotel.setPrice_per_night(pricePerNight);
            hotel.setCreatedBy("admin");

            HotelDAO dao = new HotelDAO();

            if (idStr != null && !idStr.isEmpty()) {
                // ✅ Nếu có id → cập nhật
                hotel.setId(Integer.parseInt(idStr));
                dao.update(hotel);
            } else {
                // ✅ Nếu không có id → thêm mới
                dao.insert(hotel);
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

        HotelDAO hotelDAODAO = new HotelDAO();

        try {
            if ("edit".equals(action)) {
                // Xử lý sửa
                if (id != null && !id.isEmpty()) {
                    Hotel hotel = hotelDAODAO.getHotelById(Integer.parseInt(id));
                    request.setAttribute("hotel", hotel);
                    request.getRequestDispatcher("addHotel.jsp").forward(request, response);
                    return;
                } else {
                    // id không hợp lệ, chuyển hướng về management
                    response.sendRedirect("management");
                    return;
                }
            } else if ("delete".equals(action)) {
                // Xử lý xóa
                if (id != null && !id.isEmpty()) {
                    hotelDAODAO.delete(Integer.parseInt(id));
                }
                response.sendRedirect("management"); // hoặc trang danh sách vé sau khi xóa
            } else if ("search".equals(action)) {
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                String rating = request.getParameter("rating");
                String priceStr = request.getParameter("price");
                String sortBy = request.getParameter("sortBy");

                HotelDAO hotelDAO = new HotelDAO();
                List<Hotel> result = hotelDAO.searchHotels(name, address, rating, priceStr, sortBy);

                request.setAttribute("hotels", result);
                  request.setAttribute("tab", "hotel");
                request.getRequestDispatcher("management.jsp").forward(request, response);
                return;
            } else {
                response.sendRedirect("management");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Có thể show trang lỗi hoặc trả về thông báo lỗi
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý yêu cầu: " + e.getMessage());
        }
    }

}
