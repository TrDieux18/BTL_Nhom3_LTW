/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author pc
 */
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import model.HotelBooking;

public class HotelBookingDAO extends DBContext {

    public List<HotelBooking> getAllHotelBooking() {

        List<HotelBooking> hotelBookings = new ArrayList<>();

        String sql = "SELECT hb.*, u.fullname, h.name "
                + "FROM hotel_booking hb "
                + "JOIN users u ON hb.user_id = u.id "
                + "JOIN hotel h ON hb.hotel_id = h.id where u.status = 1;";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                HotelBooking hb = new HotelBooking();
                hb.setUserName(rs.getString("fullname"));
                hb.setHotelName(rs.getString("name"));
                hb.setCheckInDate(rs.getString("checkin_date"));
                hb.setCheckOutDate(rs.getString("checkout_date"));
                hb.setRoomQuantity(rs.getInt("room_quantity"));
                hb.setTotalPrice(rs.getLong("total_price"));
                hb.setStatus(rs.getString("status"));
                hb.setNotes(rs.getString("notes"));
                hotelBookings.add(hb);

            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi truy vấn dữ liệu tickets: " + e.getMessage());
        }
        return hotelBookings;
    }

    public List<HotelBooking> searchHotelBooking(String userName, String hotelName, String sortBy) {
        List<HotelBooking> hotelBookings = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT hb.*, u.fullname, h.name "
                + "FROM hotel_booking hb "
                + "JOIN users u ON hb.user_id = u.id "
                + "JOIN hotel h ON hb.hotel_id = h.id "
                + "WHERE u.status = 1 "
        );

        List<Object> params = new ArrayList<>();

        if (userName != null && !userName.trim().isEmpty()) {
            sql.append("AND LOWER(u.fullname) LIKE ? ");
            params.add("%" + userName.trim().toLowerCase() + "%");
        }
        if (hotelName != null && !hotelName.trim().isEmpty()) {
            sql.append("AND LOWER(h.name) LIKE ? ");
            params.add("%" + hotelName.trim().toLowerCase() + "%");
        }

        if ("roomQuantity".equals(sortBy)) {
            sql.append("ORDER BY hb.room_quantity DESC ");
        } else if ("totalPrice".equals(sortBy)) {
            sql.append("ORDER BY hb.total_price DESC ");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    HotelBooking hb = new HotelBooking();
                    hb.setUserName(rs.getString("fullname"));
                    hb.setHotelName(rs.getString("name"));
                    hb.setCheckInDate(rs.getString("checkin_date"));
                    hb.setCheckOutDate(rs.getString("checkout_date"));
                    hb.setRoomQuantity(rs.getInt("room_quantity"));
                    hb.setTotalPrice(rs.getLong("total_price"));
                    hb.setStatus(rs.getString("status"));
                    hb.setNotes(rs.getString("notes"));
                    hotelBookings.add(hb);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi tìm kiếm hotel bookings: " + e.getMessage());
        }

        return hotelBookings;
    }

    public List<HotelBooking> getHotelBookingsByUserId(int userId) {
        List<HotelBooking> hotelBookings = new ArrayList<>();

        String sql = "SELECT hb.*, u.fullname, h.name "
                + "FROM hotel_booking hb "
                + "JOIN users u ON hb.user_id = u.id "
                + "JOIN hotel h ON hb.hotel_id = h.id where hb.user_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    HotelBooking hb = new HotelBooking();
                    hb.setUserName(rs.getString("fullname"));
                    hb.setHotelName(rs.getString("name"));
                    hb.setCheckInDate(rs.getString("checkin_date"));
                    hb.setCheckOutDate(rs.getString("checkout_date"));
                    hb.setRoomQuantity(rs.getInt("room_quantity"));
                    hb.setTotalPrice(rs.getLong("total_price"));
                    hb.setStatus(rs.getString("status"));
                    hb.setNotes(rs.getString("notes"));
                    hotelBookings.add(hb);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi truy vấn dữ liệu tickets: " + e.getMessage());
        }
        return hotelBookings;
    }
   


}
