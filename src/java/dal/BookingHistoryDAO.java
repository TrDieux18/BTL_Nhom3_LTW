/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.BookingHistory;
import java.sql.*;

/**
 *
 * @author pc
 */
public class BookingHistoryDAO extends DBContext {

    public List<BookingHistory> getAllBooking() {
        List<BookingHistory> bookingHistorys = new ArrayList<>();
        String sql = "SELECT bh.*, u.fullname, t.origin, t.destination, t.type "
                + "FROM booking_history bh "
                + "JOIN users u ON bh.user_id = u.id "
                + "JOIN ticket t ON bh.ticket_id = t.id where u.status = 1; ";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BookingHistory bk = new BookingHistory();
                bk.setId(rs.getInt("id"));

                bk.setUserId(rs.getInt("user_id"));
                bk.setUserName(rs.getString("fullname"));
                bk.setTicketId(rs.getInt("ticket_id"));
                bk.setOrigin(rs.getString("origin"));
                bk.setDestination(rs.getString("destination"));
                bk.setTypeTicket(rs.getString("type"));
                bk.setPayment(rs.getString("payment"));
                bk.setOrderStatus(rs.getString("orderstatus"));
                bk.setQuantity(rs.getInt("quantity"));

                bookingHistorys.add(bk);

            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi truy vấn dữ liệu tickets: " + e.getMessage());
        }

        return bookingHistorys;
    }
    
    public List<BookingHistory> searchBookingHistories(String userName, String typeTicket, String origin, String destination, String sortBy) {
    List<BookingHistory> bookingHistorys = new ArrayList<>();
    
    StringBuilder sql = new StringBuilder(
        "SELECT bh.*, u.fullname, t.origin, t.destination, t.type " +
        "FROM booking_history bh " +
        "JOIN users u ON bh.user_id = u.id " +
        "JOIN ticket t ON bh.ticket_id = t.id " +
        "WHERE u.status = 1 "
    );

    List<Object> params = new ArrayList<>();

    if (userName != null && !userName.trim().isEmpty()) {
        sql.append("AND LOWER(u.fullname) LIKE ? ");
        params.add("%" + userName.toLowerCase() + "%");
    }

    if (typeTicket != null && !typeTicket.trim().isEmpty()) {
        sql.append("AND LOWER(t.type) LIKE ? ");
        params.add("%" + typeTicket.toLowerCase() + "%");
    }

    if (origin != null && !origin.trim().isEmpty()) {
        sql.append("AND LOWER(t.origin) LIKE ? ");
        params.add("%" + origin.toLowerCase() + "%");
    }

    if (destination != null && !destination.trim().isEmpty()) {
        sql.append("AND LOWER(t.destination) LIKE ? ");
        params.add("%" + destination.toLowerCase() + "%");
    }

    // Sắp xếp
    if ("quantity".equals(sortBy)) {
        sql.append("ORDER BY bh.quantity ASC ");
    } else if ("userName".equals(sortBy)) {
        sql.append("ORDER BY u.fullname ASC ");
    }

    try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BookingHistory bk = new BookingHistory();
                bk.setId(rs.getInt("id"));
                bk.setUserId(rs.getInt("user_id"));
                bk.setUserName(rs.getString("fullname"));
                bk.setTicketId(rs.getInt("ticket_id"));
                bk.setOrigin(rs.getString("origin"));
                bk.setDestination(rs.getString("destination"));
                bk.setTypeTicket(rs.getString("type"));
                bk.setPayment(rs.getString("payment"));
                bk.setOrderStatus(rs.getString("orderstatus"));
                bk.setQuantity(rs.getInt("quantity"));
                bookingHistorys.add(bk);
            }
        }

    } catch (SQLException e) {
        System.err.println("❌ Lỗi khi tìm kiếm booking history: " + e.getMessage());
    }

    return bookingHistorys;
}


}
