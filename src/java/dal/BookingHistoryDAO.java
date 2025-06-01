/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.BookingHistory;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.Ticket;

/**
 *
 * @author pc
 */
public class BookingHistoryDAO extends DBContext {

    public List<BookingHistory> getAllBooking() {
        List<BookingHistory> bookingHistorys = new ArrayList<>();
        String sql = "SELECT bh.*, u.fullname, t.origin, t.destination, t.type, SUM(bh.quantity * t.price) AS total_price "
                + "FROM booking_history bh "
                + "JOIN users u ON bh.user_id = u.id "
                + "JOIN ticket t ON bh.ticket_id = t.id "
                + "WHERE u.status = 1 "
                + "GROUP BY bh.id, u.fullname, t.origin, t.destination, t.type";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BookingHistory bk = new BookingHistory();
                bk.setId(rs.getInt("id"));

                bk.setUserId(rs.getString("user_id"));
                bk.setUserName(rs.getString("fullname"));
                bk.setTicketId(rs.getInt("ticket_id"));
                bk.setOrigin(rs.getString("origin"));
                bk.setDestination(rs.getString("destination"));
                bk.setTypeTicket(rs.getString("type"));
                bk.setPayment(rs.getString("payment"));
                bk.setOrderStatus(rs.getString("orderstatus"));
                bk.setQuantity(rs.getInt("quantity"));
                long totalPriceLong = rs.getLong("total_price");
                double totalPrice = (double) totalPriceLong;
                bk.setTotalPrice(totalPrice);

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
                "SELECT bh.*, u.fullname, t.origin, t.destination, t.type, SUM(bh.quantity * t.price) AS total_price "
                + "FROM booking_history bh "
                + "JOIN users u ON bh.user_id = u.id "
                + "JOIN ticket t ON bh.ticket_id = t.id "
                + "WHERE u.status = 1 "
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
          sql.append("GROUP BY bh.id, u.fullname, t.origin, t.destination, t.type ");

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
                    bk.setUserId(rs.getString("user_id"));
                    bk.setUserName(rs.getString("fullname"));
                    bk.setTicketId(rs.getInt("ticket_id"));
                    bk.setOrigin(rs.getString("origin"));
                    bk.setDestination(rs.getString("destination"));
                    bk.setTypeTicket(rs.getString("type"));
                    bk.setPayment(rs.getString("payment"));
                    bk.setOrderStatus(rs.getString("orderstatus"));
                    bk.setQuantity(rs.getInt("quantity"));
                    long totalPriceLong = rs.getLong("total_price");
                    double totalPrice = (double) totalPriceLong;
                    bk.setTotalPrice(totalPrice);
                    bookingHistorys.add(bk);
                }
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi tìm kiếm booking history: " + e.getMessage());
        }

        return bookingHistorys;
    }

    public List<Ticket> getTicketsByUserId(String userId) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT t.* "
                + "FROM Booking_History bh "
                + "JOIN Ticket t ON bh.ticket_id = t.id "
                + "WHERE bh.user_id = ? ";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ticket ticket = new Ticket();
                    ticket.setId(rs.getInt("id"));
                    ticket.setAirline(rs.getString("airline"));
                    ticket.setOrigin(rs.getString("origin"));
                    ticket.setDestination(rs.getString("destination"));
                    ticket.setDeparturetime(rs.getTimestamp("departuretime").toLocalDateTime());
                    ticket.setArrivetime(rs.getTimestamp("arrivetime").toLocalDateTime());
                    ticket.setType(rs.getString("type"));
                    ticket.setPrice(rs.getString("price"));
                    tickets.add(ticket);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tickets;
    }

    public List<Object[]> statisticByUser() throws SQLException {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT u.fullname, t.type, t.price "
                + "FROM booking_history bh "
                + "JOIN users u ON bh.user_id = u.id "
                + "JOIN ticket t ON bh.ticket_id = t.id "
                + "WHERE u.status = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String fullname = rs.getString("fullname");
                String type = rs.getString("type");
                double price = rs.getDouble("price");
                list.add(new Object[]{fullname, type, price});
            }
        }
        return list;
    }

    public List<Object[]> statisticByTicketType() throws SQLException {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT t.type, SUM(bh.quantity) AS total_quantity, SUM(bh.quantity * t.price) AS total_price "
                + "FROM booking_history bh "
                + "JOIN ticket t ON bh.ticket_id = t.id "
                + "GROUP BY t.type";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String type = rs.getString("type");
                int totalQuantity = rs.getInt("total_quantity");
                long totalPriceLong = rs.getLong("total_price");
                double totalPrice = (double) totalPriceLong;
                list.add(new Object[]{type, totalQuantity, totalPrice});
            }
        }
        return list;
    }
    
    public void updateStatus(int bookingId, String newStatus) {
        String sql = "UPDATE booking_history SET orderstatus = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public boolean deleteTicket(int bookingId) {
    String sql = "DELETE FROM booking_history WHERE ticket_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, bookingId);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        System.err.println("❌ Lỗi khi xóa vé máy bay: " + e.getMessage());
        return false;
    }
}
public boolean insertBooking(BookingHistory booking, String bookingDate) {
    String sql = "INSERT INTO booking_history (user_id, ticket_id, quantity, payment, orderstatus, modifieddate) "
               + "VALUES (?, ?, ?, ?, ?, ?)";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, booking.getUserId());
        ps.setInt(2, booking.getTicketId());
        ps.setInt(3, booking.getQuantity());
        ps.setString(4, booking.getPayment());
        ps.setString(5, booking.getOrderStatus());

        if (bookingDate != null && !bookingDate.trim().isEmpty()) {
            // Chuẩn hóa chuỗi ngày giờ, ví dụ: "2025-06-02 15:30:00"
            String normalizedDateTime = bookingDate.replace("/", "-");
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss dd-MM-yyyy");
LocalDateTime localDateTime = LocalDateTime.parse(normalizedDateTime, formatter);
Timestamp timestamp = Timestamp.valueOf(localDateTime);
ps.setTimestamp(6, timestamp);


            ps.setTimestamp(6, timestamp);
        } else {
            ps.setTimestamp(6, null);
        }

        int rowsInserted = ps.executeUpdate();
        return rowsInserted > 0;
    } catch (SQLException e) {
        System.err.println("❌ Lỗi khi thêm booking history: " + e.getMessage());
        return false;
    } catch (java.time.format.DateTimeParseException e) {
        System.err.println("❌ Lỗi định dạng ngày giờ: " + e.getMessage());
        return false;
    }
}
}
