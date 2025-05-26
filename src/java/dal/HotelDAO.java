package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Hotel;

public class HotelDAO extends DBContext {

    public List<Hotel> getAllHotel() {
        List<Hotel> hotels = new ArrayList<>();
        String sql = "SELECT * FROM hotel ORDER BY price_per_night DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Hotel hotel = new Hotel();
                hotel.setId(rs.getInt("id"));
                hotel.setName(rs.getString("name"));
                hotel.setAddress(rs.getString("address"));
                hotel.setContact_info(rs.getString("contact_info"));
                hotel.setRating(rs.getString("rating"));
                hotel.setPrice_per_night(rs.getLong("price_per_night"));
                hotel.setRoomsAvailable(rs.getInt("rooms_available"));
                hotel.setCreatedBy(rs.getString("createdBy"));
                hotel.setImage(rs.getString("image"));
                hotel.setDescription(rs.getString("description"));
                hotels.add(hotel);
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi truy vấn dữ liệu hotel: " + e.getMessage());
        }

        return hotels;
    }

    public void update(Hotel hotel) {
        String sql = "UPDATE hotel SET name = ?, address = ?, contact_info = ?, rating = ?, price_per_night = ?, rooms_available = ?, createdBy = ?, image = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, hotel.getName());
            ps.setString(2, hotel.getAddress());
            ps.setString(3, hotel.getContact_info());
            ps.setString(4, hotel.getRating());
            ps.setLong(5, hotel.getPrice_per_night());
            ps.setInt(6, hotel.getRoomsAvailable() != null ? hotel.getRoomsAvailable() : 0);
            ps.setString(7, hotel.getCreatedBy());
            ps.setString(8, hotel.getImage());
            ps.setInt(9, hotel.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("❌ Lỗi khi cập nhật hotel: " + e.getMessage());
        }
    }

    public void insert(Hotel hotel) {
        String sql = "INSERT INTO hotel (name, address, contact_info, rating, price_per_night, rooms_available, createdBy, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, hotel.getName());
            ps.setString(2, hotel.getAddress());
            ps.setString(3, hotel.getContact_info());
            ps.setString(4, hotel.getRating());
            ps.setLong(5, hotel.getPrice_per_night() != null ? hotel.getPrice_per_night() : 0L);
            ps.setInt(6, hotel.getRoomsAvailable() != null ? hotel.getRoomsAvailable() : 0);
            ps.setString(7, hotel.getCreatedBy());
            ps.setString(8, hotel.getImage());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("❌ Lỗi khi chèn dữ liệu hotel: " + e.getMessage());
        }
    }

    public void delete(int hotelId) {
        String sqlBooking = "DELETE FROM hotel_booking WHERE hotel_id = ?";
        String sqlHotel = "DELETE FROM hotel WHERE id = ?";
        try {
            connection.setAutoCommit(false);

            try (PreparedStatement psBooking = connection.prepareStatement(sqlBooking); PreparedStatement psHotel = connection.prepareStatement(sqlHotel)) {
                psBooking.setInt(1, hotelId);
                psBooking.executeUpdate();

                psHotel.setInt(1, hotelId);
                psHotel.executeUpdate();

                connection.commit();
                System.out.println("✅ Đã xóa khách sạn và booking liên quan với hotel_id = " + hotelId);
            } catch (SQLException e) {
                connection.rollback();
                throw e;
            } finally {
                connection.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("❌ Lỗi khi xóa khách sạn: " + e.getMessage());
        }
    }

    public List<Hotel> searchHotels(String name, String address, String ratingTo, String ratingForm, String maxPrice, String sortBy) {
        List<Hotel> list = new ArrayList<>();
        String sql = "SELECT * FROM hotel WHERE 1=1";
        List<Object> params = new ArrayList<>();
        if (name != null && !name.trim().isEmpty()) {
            sql += " AND LOWER(name) LIKE ?";
            params.add("%" + name.trim().toLowerCase() + "%");
        }
        if (address != null && !address.trim().isEmpty()) {
            sql += " AND LOWER(address) LIKE ?";
            params.add("%" + address.trim().toLowerCase() + "%");
        }

        if (ratingTo != null && !ratingTo.trim().isEmpty()) {
            try {
                double rTo = Double.parseDouble(ratingTo.trim());
                sql += " AND CAST(rating AS DECIMAL(2,1)) >= ?";
                params.add(rTo);
            } catch (NumberFormatException e) {
                System.err.println("RatingTo không hợp lệ: " + ratingTo);
            }
        }
        if (ratingForm != null && !ratingForm.trim().isEmpty()) {
            try {
                double rForm = Double.parseDouble(ratingForm.trim());
                sql += " AND CAST(rating AS DECIMAL(2,1)) <= ?";
                params.add(rForm);
            } catch (NumberFormatException e) {
                System.err.println("RatingForm không hợp lệ: " + ratingForm);
            }
        }
        if (maxPrice != null && !maxPrice.trim().isEmpty()) {
            try {
                long p = Long.parseLong(maxPrice.trim());
                sql += " AND price_per_night <= ?";
                params.add(p);
            } catch (NumberFormatException e) {
                System.err.println("Giá không hợp lệ: " + maxPrice);
            }
        }

        if (sortBy != null && !sortBy.trim().isEmpty()) {
            if (sortBy.equals("name")) {
                sql += " ORDER BY name ASC";
            } else if (sortBy.equals("price")) {
                sql += " ORDER BY price_per_night DESC";
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Hotel h = new Hotel();
                h.setId(rs.getInt("id"));
                h.setName(rs.getString("name"));
                h.setAddress(rs.getString("address"));
                h.setContact_info(rs.getString("contact_info"));
                h.setRating(rs.getString("rating"));
                h.setPrice_per_night(rs.getLong("price_per_night"));
                h.setRoomsAvailable(rs.getInt("rooms_available"));
                h.setCreatedBy(rs.getString("createdBy"));
                h.setImage(rs.getString("image"));
                h.setDescription(rs.getString("description"));
                list.add(h);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Hotel getHotelById(int id) {
        String sql = "SELECT * FROM hotel WHERE id = ?";
        Hotel hotel = null;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                hotel = new Hotel();
                hotel.setId(rs.getInt("id"));
                hotel.setName(rs.getString("name"));
                hotel.setAddress(rs.getString("address"));
                hotel.setContact_info(rs.getString("contact_info"));
                hotel.setRating(rs.getString("rating"));
                hotel.setPrice_per_night(rs.getLong("price_per_night"));
                hotel.setRoomsAvailable(rs.getInt("rooms_available"));
                hotel.setCreatedBy(rs.getString("createdBy"));
                hotel.setDescription(rs.getString("description"));
                hotel.setImage(rs.getString("image"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("❌ Lỗi khi truy vấn hotel theo id: " + e.getMessage());
        }

        return hotel;
    }

    public List<Hotel> searchHotels(String address, String priceRange, Integer minRooms) {
        List<Hotel> hotels = new ArrayList<>();

        if (connection == null) {
            throw new IllegalStateException("Database connection is not initialized.");
        }

        StringBuilder sql = new StringBuilder("SELECT * FROM hotel WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (address != null && !address.trim().isEmpty()) {
            sql.append(" AND LOWER(address) LIKE ?");
            params.add("%" + address.trim().toLowerCase() + "%");
        }

        if (priceRange != null && !priceRange.trim().isEmpty()) {
            switch (priceRange) {
                case "1":
                    sql.append(" AND price_per_night < 1000000");
                    break;
                case "2":
                    sql.append(" AND price_per_night >= 1000000 AND price_per_night < 2500000");
                    break;
                case "3":
                    sql.append(" AND price_per_night >= 2500000");
                    break;
                default:
                    break;
            }
        }

        if (minRooms != null) {
            sql.append(" AND rooms_available >= ?");
            params.add(minRooms);
        }

        sql.append(" ORDER BY price_per_night DESC");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Hotel hotel = new Hotel();
                hotel.setId(rs.getInt("id"));
                hotel.setName(rs.getString("name"));
                hotel.setAddress(rs.getString("address"));
                hotel.setContact_info(rs.getString("contact_info"));
                hotel.setRating(rs.getString("rating"));
                hotel.setPrice_per_night(rs.getLong("price_per_night"));
                hotel.setRoomsAvailable(rs.getInt("rooms_available"));
                hotel.setCreatedBy(rs.getString("createdBy"));
                hotel.setImage(rs.getString("image"));
                hotel.setDescription(rs.getString("description"));
                hotels.add(hotel);
            }
        } catch (SQLException e) {
            System.err.println("Error during hotel search: " + e.getMessage());
            e.printStackTrace();
        }

        return hotels;
    }

    public void insertBooking(int userId, int hotelId, String hotelName, String checkIn, String checkOut,
            String bookingDate, int roomQuantity, String note, Long totalPrice, String status) {

        String sql = "INSERT INTO hotel_booking (user_id, hotel_id, checkin_date, checkout_date, "
                + "booking_date, room_quantity, notes, total_price, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, hotelId);
            ps.setDate(3, java.sql.Date.valueOf(checkIn));
            ps.setDate(4, java.sql.Date.valueOf(checkOut));
            ps.setTimestamp(5, java.sql.Timestamp.valueOf(bookingDate));
            ps.setInt(6, roomQuantity);
            ps.setString(7, note != null ? note : "");
            ps.setLong(8, totalPrice != null ? totalPrice : 0L);
            ps.setString(9, status);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi thêm đặt phòng vào cơ sở dữ liệu: " + e.getMessage());
        }
    }
}