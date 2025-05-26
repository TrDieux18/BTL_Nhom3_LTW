package controller;

import dal.HotelDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;
import model.Hotel;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)

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
            String roomsAvailable = request.getParameter("roomsAvailable");

            Part imagePart = request.getPart("imageFile");
            String imageFileName = null;

            HotelDAO dao = new HotelDAO();
            Hotel hotel;

            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                hotel = dao.getHotelById(id);
                if (hotel == null) {
                    response.getWriter().println("Không tìm thấy khách sạn.");
                    return;
                }
            } else {
                hotel = new Hotel();
                hotel.setCreatedBy("admin");
            }

            hotel.setName(name);
            hotel.setAddress(address);
            hotel.setContact_info(contactInfo);
            hotel.setRating(rating);
            hotel.setPrice_per_night(Long.parseLong(pricePerNight));
            hotel.setRoomsAvailable(Integer.parseInt(roomsAvailable));

            if (imagePart != null && imagePart.getSize() > 0) {
                String realPath = getServletContext().getRealPath("/uploads");
                File uploadDir = new File(realPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                imageFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String imagePath = realPath + File.separator + imageFileName;

                imagePart.write(imagePath);

                hotel.setImage("assets/images/" + imageFileName);
            } else if (hotel.getImage() == null || hotel.getImage().isEmpty()) {
                response.getWriter().println("Bạn cần thêm hình ảnh.");
                return;
            }

            if (hotel.getId() != null) {
                dao.update(hotel);
            } else {
                dao.insert(hotel);
            }

            response.sendRedirect("management");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi thêm/cập nhật khách sạn: " + e.getMessage());
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
                if (id != null && !id.isEmpty()) {
                    Hotel hotel = hotelDAODAO.getHotelById(Integer.parseInt(id));
                    request.setAttribute("hotel", hotel);
                    request.getRequestDispatcher("addHotel.jsp").forward(request, response);
                    return;
                } else {
                    response.sendRedirect("management");
                    return;
                }
            } else if ("delete".equals(action)) {
                if (id != null && !id.isEmpty()) {
                    hotelDAODAO.delete(Integer.parseInt(id));
                }
                response.sendRedirect("management");
            } else if ("search".equals(action)) {
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                String ratingTo = request.getParameter("ratingTo");
                String ratingForm = request.getParameter("ratingForm");
                String priceStr = request.getParameter("price");
                String sortBy = request.getParameter("sortBy");

                HotelDAO hotelDAO = new HotelDAO();
                List<Hotel> result = hotelDAO.searchHotels(name, address, ratingTo, ratingForm, priceStr, sortBy);

                request.setAttribute("hotels", result);
                request.setAttribute("tab", "hotel");
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