/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Hotel;

/**
 *
 * @author pc
 */
public class HotelDAO extends DBContext {

    public List<Hotel> getAllHotel() {
        List<Hotel> hotels = new ArrayList<>();
        String sql = "SELECT * FROM hotel";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Hotel hotel = new Hotel();
                hotel.setId(rs.getInt("id"));
                hotel.setName(rs.getString("name"));
                hotel.setAddress(rs.getString("address"));
                hotel.setContact_info(rs.getString("contact_info"));
                hotel.setRating(rs.getString("rating"));
                hotel.setPrice_per_night(rs.getString("price_per_night"));
                hotels.add(hotel);
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi truy vấn dữ liệu tickets: " + e.getMessage());
        }

        return hotels;
    }

    public void update(Hotel hotel) {
        String sql = "UPDATE hotel SET name = ?, address = ?, contact_info = ?, rating = ?, price_per_night = ?, createdby = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, hotel.getName());
            ps.setString(2, hotel.getAddress());
            ps.setString(3, hotel.getContact_info());

            BigDecimal rating = new BigDecimal(hotel.getRating());
            ps.setBigDecimal(4, rating);

            Long pricePerNight = Long.parseLong(hotel.getPrice_per_night());
            ps.setLong(5, pricePerNight);
            ps.setString(6, hotel.getCreatedBy());

            ps.setInt(7, hotel.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("❌ Lỗi khi truy vấn dữ liệu tickets: " + e.getMessage());
        }
    }

    public void insert(Hotel hotel) {
        String sql = "INSERT INTO hotel (name, address, contact_info, rating, price_per_night, createdby) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, hotel.getName());
            ps.setString(2, hotel.getAddress());
            ps.setString(3, hotel.getContact_info());

            ps.setString(4, hotel.getRating());

            long pricePerNight = 0L;
            if (hotel.getPrice_per_night() != null && !hotel.getPrice_per_night().trim().isEmpty()) {
                pricePerNight = Long.parseLong(hotel.getPrice_per_night().trim());
            }
            ps.setLong(5, pricePerNight);

            ps.setString(6, hotel.getCreatedBy());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("❌ Lỗi khi chèn dữ liệu hotel: " + e.getMessage());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            System.err.println("❌ Định dạng số không hợp lệ trong rating hoặc price_per_night");
        }
    }

    public void delete(int hotelId) {
        String sqlBooking = "DELETE FROM hotel_booking WHERE hotel_id = ?";
        String sqlHotel = "DELETE FROM hotel WHERE id = ?";
        try {
            connection.setAutoCommit(false); // bắt đầu transaction

            try (PreparedStatement psBooking = connection.prepareStatement(sqlBooking); PreparedStatement psHotel = connection.prepareStatement(sqlHotel)) {

                // Xóa booking liên quan
                psBooking.setInt(1, hotelId);
                psBooking.executeUpdate();

                // Xóa hotel
                psHotel.setInt(1, hotelId);
                psHotel.executeUpdate();

                connection.commit(); // commit nếu thành công
                System.out.println("✅ Đã xóa khách sạn và booking liên quan với hotel_id = " + hotelId);
            } catch (SQLException e) {
                connection.rollback(); // rollback nếu lỗi
                throw e;
            } finally {
                connection.setAutoCommit(true); // bật lại auto commit
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("❌ Lỗi khi xóa khách sạn: " + e.getMessage());
        }
    }

    public List<Hotel> searchHotels(String name, String address, String rating, String maxPrice, String sortBy) {
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

        if (rating != null && !rating.trim().isEmpty()) {
            try {
                double r = Double.parseDouble(rating.trim());
                sql += " AND CAST(rating AS DECIMAL(2,1)) >= ?";
                params.add(r);
            } catch (NumberFormatException e) {
                System.err.println("Rating không hợp lệ: " + rating);
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

        // Sắp xếp
        if (sortBy != null && !sortBy.trim().isEmpty()) {
            if (sortBy.equals("name")) {
                sql += " ORDER BY name ASC";
            } else if (sortBy.equals("price")) {
                sql += " ORDER BY price_per_night DESC";
                System.out.println("Đã chạy vào đây");
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
                h.setPrice_per_night(rs.getString("price_per_night"));
                h.setCreatedBy(rs.getString("createdBy"));
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

                hotel.setPrice_per_night(rs.getString("price_per_night"));

                hotel.setCreatedBy(rs.getString("createdby"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("❌ Lỗi khi truy vấn hotel theo id: " + e.getMessage());
        }

        return hotel;
    }

}
