package controller;

import dal.HotelDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Hotel;

@WebServlet(name = "HotelSearchServlet", urlPatterns = {"/hotelList"})
public class HotelSearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String address = request.getParameter("address");
        String priceRange = request.getParameter("priceRange"); 
        String minRoomsRaw = request.getParameter("minRooms");

        Integer minRooms = null;
        if (minRoomsRaw != null && !minRoomsRaw.trim().isEmpty()) {
            try {
                minRooms = Integer.parseInt(minRoomsRaw);
            } catch (NumberFormatException e) {
                minRooms = null;
            }
        }

        HotelDAO hotelDAO = new HotelDAO();
        List<Hotel> hotels;

        boolean isEmptySearch = 
                (address == null || address.trim().isEmpty()) &&
                (priceRange == null || priceRange.trim().isEmpty()) &&
                minRooms == null;

        if (isEmptySearch) {
            hotels = hotelDAO.getAllHotel();
        } else {
            hotels = hotelDAO.searchHotels(address, priceRange, minRooms);
        }

       
        int mid = hotels.size() / 2;
        List<Hotel> recommendedHotels = hotels.subList(0, mid);
        List<Hotel> discountHotels = hotels.subList(mid, hotels.size());

        request.setAttribute("recommendedHotels", recommendedHotels);
        request.setAttribute("discountHotels", discountHotels);
        request.getRequestDispatcher("/hotel.jsp").forward(request, response);
    }
}
