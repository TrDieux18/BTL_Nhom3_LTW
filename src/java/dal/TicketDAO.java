package dal;

import model.Ticket;

import java.sql.*;
//import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TicketDAO extends DBContext {

    public List<Ticket> getAllTickets() {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT * FROM ticket";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Ticket ticket = new Ticket();
                ticket.setId(rs.getInt("id"));
                ticket.setAirline(rs.getString("airline"));
                ticket.setOrigin(rs.getString("origin"));
                ticket.setDestination(rs.getString("destination"));
                ticket.setEstimatedtime(rs.getString("estimatedtime"));

                // ✅ Convert Timestamp -> LocalDateTime
                ticket.setDeparturetime(rs.getTimestamp("departuretime").toLocalDateTime());
                ticket.setArrivetime(rs.getTimestamp("arrivetime").toLocalDateTime());
                ticket.setImage(rs.getString("image"));
                ticket.setType(rs.getString("type"));
                ticket.setPrice(rs.getString("price"));
                ticket.setModifiedDate(rs.getTimestamp("modifiedDate").toLocalDateTime());
                ticket.setCreatedBy(rs.getString("createdBy"));

                tickets.add(ticket);
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi truy vấn dữ liệu tickets: " + e.getMessage());
        }

        return tickets;
    }

    public void insert(Ticket ticket) {
        String sql = "INSERT INTO ticket (airline, origin, destination, departuretime, arrivetime, type, price, estimatedtime, modifiedDate, createdBy) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, ticket.getAirline());
            ps.setString(2, ticket.getOrigin());
            ps.setString(3, ticket.getDestination());

            // ✅ LocalDateTime -> Timestamp
            ps.setTimestamp(4, Timestamp.valueOf(ticket.getDeparturetime()));
            ps.setTimestamp(5, Timestamp.valueOf(ticket.getArrivetime()));

            ps.setString(6, ticket.getType());
            ps.setString(7, ticket.getPrice());
            ps.setString(8, ticket.getEstimatedtime());

            ps.setTimestamp(9, Timestamp.valueOf(ticket.getModifiedDate()));
            ps.setString(10, ticket.getCreatedBy());
            ps.setString(10, ticket.getImage());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Ticket ticket) {
        String sql = "UPDATE ticket SET airline = ?, origin = ?, destination = ?, departuretime = ?, arrivetime = ?, type = ?, price = ?, estimatedtime = ?, modifiedDate = ?, createdBy = ? WHERE id = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, ticket.getAirline());
            ps.setString(2, ticket.getOrigin());
            ps.setString(3, ticket.getDestination());
            ps.setObject(4, ticket.getDeparturetime());
            ps.setObject(5, ticket.getArrivetime());
            ps.setString(6, ticket.getType());
            ps.setString(7, ticket.getPrice());
            ps.setString(8, ticket.getEstimatedtime());
            ps.setObject(9, ticket.getModifiedDate());
            ps.setString(10, ticket.getCreatedBy());
            ps.setInt(11, ticket.getId());
            ps.setString(12, ticket.getImage());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String sqlDeleteBookingHistory = "DELETE FROM booking_history WHERE ticket_id = ?";
        String sqlDeleteTicket = "DELETE FROM ticket WHERE id = ?";
        try {
            // Tắt auto-commit để transaction thủ công
            connection.setAutoCommit(false);

            try (PreparedStatement ps1 = connection.prepareStatement(sqlDeleteBookingHistory); PreparedStatement ps2 = connection.prepareStatement(sqlDeleteTicket)) {

                ps1.setInt(1, id);
                ps1.executeUpdate();

                ps2.setInt(1, id);
                ps2.executeUpdate();

                // Commit nếu thành công
                connection.commit();
            } catch (SQLException e) {
                // Rollback nếu lỗi
                connection.rollback();
                throw e;
            } finally {
                // Bật lại auto-commit sau khi xong
                connection.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Ticket getTicketById(int id) {
        String sql = "SELECT * FROM ticket WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Ticket ticket = new Ticket();
                    ticket.setId(rs.getInt("id"));
                    ticket.setAirline(rs.getString("airline"));
                    ticket.setOrigin(rs.getString("origin"));
                    ticket.setDestination(rs.getString("destination"));
                    ticket.setEstimatedtime(rs.getString("estimatedtime"));
                    ticket.setDeparturetime(rs.getTimestamp("departuretime").toLocalDateTime());
                    ticket.setArrivetime(rs.getTimestamp("arrivetime").toLocalDateTime());
                    ticket.setType(rs.getString("type"));
                    ticket.setPrice(rs.getString("price"));
                    ticket.setModifiedDate(rs.getTimestamp("modifiedDate").toLocalDateTime());
                    ticket.setCreatedBy(rs.getString("createdBy"));
                    ticket.setImage(rs.getString("image"));
                    return ticket;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Ticket> searchTickets(String airline, String origin, String destination, String maxPrice, String sortBy) {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT * FROM ticket WHERE 1=1";
        List<Object> params = new ArrayList<>();

        if (airline != null && !airline.trim().isEmpty()) {
            sql += " AND LOWER(airline) LIKE ?";
            params.add("%" + airline.trim().toLowerCase() + "%");
        }
        if (origin != null && !origin.trim().isEmpty()) {
            sql += " AND LOWER(origin) LIKE ?";
            params.add("%" + origin.trim().toLowerCase() + "%");
        }
        if (destination != null && !destination.trim().isEmpty()) {
            sql += " AND LOWER(destination) LIKE ?";
            params.add("%" + destination.trim().toLowerCase() + "%");
        }
        if (maxPrice != null && !maxPrice.trim().isEmpty()) {
            try {
                long price = Long.parseLong(maxPrice.trim());
                sql += " AND price <= ?";
                params.add(price);
            } catch (NumberFormatException e) {
                System.err.println("Không thể parse maxPrice: " + maxPrice);
            }
        }

        if (sortBy != null) {
            if (sortBy.equals("airline")) {
                sql += " ORDER BY airline ASC";
            } else if (sortBy.equals("price")) {
                sql += " ORDER BY price ASC";
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ticket t = new Ticket();
                t.setId(rs.getInt("id"));
                t.setAirline(rs.getString("airline"));
                t.setOrigin(rs.getString("origin"));
                t.setDestination(rs.getString("destination"));
                t.setEstimatedtime(rs.getString("estimatedtime"));
                t.setDeparturetime(rs.getTimestamp("departuretime").toLocalDateTime());
                t.setArrivetime(rs.getTimestamp("arrivetime").toLocalDateTime());
                t.setPrice(rs.getString("price"));
                t.setType(rs.getString("type"));
                t.setCreatedBy(rs.getString("createdBy"));
                t.setModifiedDate(rs.getTimestamp("modifiedDate").toLocalDateTime());
                t.setCreatedBy(rs.getString("image"));
                
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Ticket> getLimitedFlightOffers(int limit) {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT id, airline, origin, destination, estimatedtime, departuretime, arrivetime, type, price, image "
                + "FROM ticket "
                + "ORDER BY departuretime ASC, price ASC "
                + "LIMIT ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, limit);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Ticket t = new Ticket();
                t.setId(rs.getInt("id"));
                t.setAirline(rs.getString("airline"));
                t.setOrigin(rs.getString("origin"));
                t.setDestination(rs.getString("destination"));
                t.setEstimatedtime(rs.getString("estimatedtime"));
                t.setDeparturetime(rs.getTimestamp("departuretime").toLocalDateTime());
                t.setArrivetime(rs.getTimestamp("arrivetime").toLocalDateTime());
                t.setPrice(rs.getString("price"));
                t.setType(rs.getString("type"));
                t.setImage(rs.getString("image"));
                list.add(t);
            }
        } catch (Exception e) {
            System.out.println("Error in TicketDAO.getLimitedFlightOffers(): " + e.getMessage());
        }
        return list;
    }

    public List<Ticket> getFilteredTickets(String origin, String destination, Long minPrice, Long maxPrice, List<String> airlines, String sortBy) {
        List<Ticket> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Ticket WHERE origin=? AND destination = ?");
        List<Object> params = new ArrayList<>();

        params.add(origin);
        params.add(destination);

        if (minPrice != null) {
            sql.append(" AND price >= ?");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append(" AND price <= ?");
            params.add(maxPrice);
        }

        if (airlines != null && !airlines.isEmpty()) {
            sql.append(" AND airline IN (");
            for (int i = 0; i < airlines.size(); i++) {
                sql.append("?");
                if (i < airlines.size() - 1) {
                    sql.append(",");
                }
                params.add(airlines.get(i));
            }
            sql.append(")");
        }


        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "price_asc":
                    sql.append(" ORDER BY price ASC");
                    break;
                case "duration_asc":
                    sql.append(" ORDER BY estimatedtime ASC");
                    break;
                case "departure_asc":
                    sql.append(" ORDER BY departuretime ASC");
                    break;
                case "arrival_asc":
                    sql.append(" ORDER BY arrivetime ASC");
                    break;
                default:
                    sql.append(" ORDER BY price ASC, departuretime ASC");
                    break;
            }
        } else {
            sql.append(" ORDER BY price ASC, departuretime ASC");
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Ticket t = new Ticket();
                t.setId(rs.getInt("id"));
                t.setAirline(rs.getString("airline"));
                t.setOrigin(rs.getString("origin"));
                t.setDestination(rs.getString("destination"));
                t.setEstimatedtime(rs.getString("estimatedtime"));
                t.setDeparturetime(rs.getTimestamp("departuretime").toLocalDateTime());
                t.setArrivetime(rs.getTimestamp("arrivetime").toLocalDateTime());
                t.setPrice(rs.getString("price"));
                t.setType(rs.getString("type"));
                t.setImage(rs.getString("image"));
                list.add(t);
            }
        } catch (SQLException e) {
            System.out.println("Error in TicketDAO.getFilter: " + e.getMessage());
        }
        return list;
    }
    public List<Ticket> searchSelectTickets(String origin, String destination,
                                        Integer minPrice, Integer maxPrice,
                                        List<String> airlines, String sortBy) {
    List<Ticket> tickets = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT * FROM Ticket WHERE origin = ? AND destination = ?");
    List<Object> params = new ArrayList<>();

    params.add(origin);
    params.add(destination);

    if (minPrice != null && minPrice >= 0) {
        sql.append(" AND price >= ?");
        params.add(minPrice);
    }

    if (maxPrice != null && maxPrice >= 0) {
        sql.append(" AND price <= ?");
        params.add(maxPrice);
    }

    if (airlines != null && !airlines.isEmpty()) {
        sql.append(" AND airline IN (");
        for (int i = 0; i < airlines.size(); i++) {
            sql.append("?");
            if (i < airlines.size() - 1) {
                sql.append(", ");
            }
            params.add(airlines.get(i));
        }
        sql.append(")");
    }

    if (sortBy != null && !sortBy.isEmpty()) {
        switch (sortBy) {
            case "price_asc":
                sql.append(" ORDER BY price ASC");
                break;
            case "duration_asc":
                sql.append(" ORDER BY estimatedtime ASC");
                break;
            case "departure_asc":
                sql.append(" ORDER BY departuretime ASC");
                break;
            case "arrival_asc":
                sql.append(" ORDER BY arrivetime ASC");
                break;
            default:
                sql.append(" ORDER BY price ASC, departuretime ASC");
                break;
        }
    } else {
        sql.append(" ORDER BY price ASC, departuretime ASC");
    }

    try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
        for (int i = 0; i < params.size(); i++) {
            st.setObject(i + 1, params.get(i));
        }
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Ticket ticket = new Ticket();
            ticket.setId(rs.getInt("id"));
            ticket.setAirline(rs.getString("airline"));
            ticket.setOrigin(rs.getString("origin"));
            ticket.setDestination(rs.getString("destination"));
            ticket.setEstimatedtime(rs.getString("estimatedtime"));
            ticket.setDeparturetime(rs.getTimestamp("departuretime").toLocalDateTime());
            ticket.setArrivetime(rs.getTimestamp("arrivetime").toLocalDateTime());
            ticket.setType(rs.getString("type"));
            ticket.setPrice(rs.getString("price"));  // Nếu kiểu số thì chuyển getInt/getLong
            ticket.setImage(rs.getString("image"));
            tickets.add(ticket);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return tickets;
}

}
