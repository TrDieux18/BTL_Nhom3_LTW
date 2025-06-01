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
                hb.setId(rs.getInt("id"));
                hb.setUserName(rs.getString("fullname"));
                hb.setHotelName(rs.getString("name"));
                hb.setCheckInDate(rs.getString("checkin_date"));
                hb.setCheckOutDate(rs.getString("checkout_date"));
                hb.setBookingDate(rs.getString("booking_date"));
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
                      hb.setId(rs.getInt("id"));
                    hb.setUserName(rs.getString("fullname"));
                    hb.setHotelName(rs.getString("name"));
                    hb.setCheckInDate(rs.getString("checkin_date"));
                    hb.setCheckOutDate(rs.getString("checkout_date"));
                    hb.setBookingDate(rs.getString("booking_date"));
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
                      hb.setId(rs.getInt("id"));
                    hb.setUserName(rs.getString("fullname"));
                    hb.setHotelName(rs.getString("name"));
                    hb.setCheckInDate(rs.getString("checkin_date"));
                    hb.setCheckOutDate(rs.getString("checkout_date"));
                    hb.setBookingDate(rs.getString("booking_date"));
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

    public List<Object[]> getStatisticsByUser() {
        List<Object[]> statistics = new ArrayList<>();
        String sql = "SELECT u.fullname, h.name AS hotelname, SUM(hb.room_quantity) AS total_rooms, SUM(hb.total_price) AS total_price "
                + "FROM hotel_booking hb "
                + "JOIN users u ON hb.user_id = u.id "
                + "JOIN hotel h ON hb.hotel_id = h.id "
                + "WHERE u.status = 1 "
                + "GROUP BY u.id, u.fullname, h.id, h.name";  

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String fullName = rs.getString("fullname");
                String hotelName = rs.getString("hotelname");
                int totalRooms = rs.getInt("total_rooms");
                long totalPrice = rs.getLong("total_price");
                statistics.add(new Object[]{fullName, hotelName, totalRooms, totalPrice});
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi thống kê theo người đặt: " + e.getMessage());
        }

        return statistics;
    }

    public List<Object[]> getStatisticsByHotel() {
        List<Object[]> statistics = new ArrayList<>();
        String sql = "SELECT h.name AS hotel_name, COUNT(*) AS total_bookings, SUM(hb.total_price) AS total_price "
                + "FROM hotel_booking hb "
                + "JOIN hotel h ON hb.hotel_id = h.id "
                + "GROUP BY h.name";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String hotelName = rs.getString("hotel_name");
                int totalBookings = rs.getInt("total_bookings");
                long totalPrice = rs.getLong("total_price");
                statistics.add(new Object[]{hotelName, totalBookings, totalPrice});
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi thống kê theo khách sạn: " + e.getMessage());
        }

        return statistics;
    }
    
    public void updateStatusHotel(int bookingId, String newStatus) {
        String sql = "UPDATE hotel_booking SET status = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public boolean deleteHotelBooking(int bookingId) {
    String sql = "DELETE FROM hotel_booking WHERE id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, bookingId);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        System.err.println("❌ Lỗi khi xóa đặt phòng khách sạn: " + e.getMessage());
        return false;
    }
}

}
