package dal;

import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {

    public boolean registerUser(User user) {
        if (connection == null) {
            System.err.println("❌ Không thể kết nối đến database trong hàm registerUser()");
            return false;
        }

        try {
            String checkQuery = "SELECT COUNT(*) FROM users WHERE username = ? OR email = ? OR phonenumber = ?";
            PreparedStatement checkStmt = connection.prepareStatement(checkQuery);
            checkStmt.setString(1, user.getUsername());
            checkStmt.setString(2, user.getEmail());
            checkStmt.setString(3, user.getPhonenumber());

            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return false;
            }

            String insertUser = "INSERT INTO users (fullname, username, email, phonenumber, password, address, status, role_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement insertStmt = connection.prepareStatement(insertUser);
            insertStmt.setString(1, user.getFullname());
            insertStmt.setString(2, user.getUsername());
            insertStmt.setString(3, user.getEmail());
            insertStmt.setString(4, user.getPhonenumber());
            insertStmt.setString(5, user.getPassword());
            insertStmt.setString(6, user.getAddress());
            insertStmt.setInt(7, Integer.parseInt(user.getStatus()));
            insertStmt.setInt(8, user.getRoleId());

            return insertStmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi đăng ký người dùng: " + e.getMessage());
            return false;
        }
    }

    public User check(String username, String password) {
        User user = null;

        if (connection == null) {
            System.err.println("❌ Không thể kết nối đến database trong hàm check()");
            return null;
        }

        try {
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullname(rs.getString("fullname"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhonenumber(rs.getString("phonenumber"));
                user.setPassword(rs.getString("password"));
                user.setAddress(rs.getString("address"));
                user.setStatus(rs.getString("status"));
                user.setRoleId(rs.getInt("role_id"));
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.err.println("❌ Lỗi truy vấn DB: " + e.getMessage());
        }

        return user;
    }

    public List<User> getAllUser() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullname(rs.getString("fullname"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhonenumber(rs.getString("phonenumber"));
                user.setPassword(rs.getString("password"));
                user.setAddress(rs.getString("address"));
                user.setStatus(rs.getString("status"));
                user.setRoleId(rs.getInt("role_id"));

                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi truy vấn dữ liệu người dùng: " + e.getMessage());
        }

        return users;
    }

    // ✅ THÊM MỚI NGƯỜI DÙNG (dùng cho UserServlet)
    public void insert(User user) {
        String sql = "INSERT INTO users (fullname, username, email, phonenumber, address, status, role_id, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhonenumber());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getStatus());
            ps.setInt(7, user.getRoleId());
            ps.setString(8, user.getPassword());

            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi thêm người dùng: " + e.getMessage());
        }
    }

    public void update(User user) {
        String sql = "UPDATE users SET fullname = ?, username = ?, email = ?, phonenumber = ?, address = ?, status = ?, role_id = ?, password = ? WHERE id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhonenumber());
            ps.setString(5, user.getAddress());
            ps.setInt(6, Integer.parseInt(user.getStatus()));
            ps.setInt(7, user.getRoleId());
            ps.setString(8, user.getPassword());
            ps.setInt(9, user.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi cập nhật người dùng: " + e.getMessage());
        }
    }

    public void delete(int userId) {
         String sql = "UPDATE users SET status = ? WHERE id = ?";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, 0);
        ps.setInt(2, userId);

        ps.executeUpdate();
    } catch (SQLException e) {
        System.err.println("❌ Lỗi khi cập nhật người dùng: " + e.getMessage());
    }
    }
    
    public List<User> searchUsers(String fullname, String username, String address, Integer roleId, String sortBy) throws SQLException {
    List<User> users = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE 1=1 ");

    if (fullname != null && !fullname.trim().isEmpty()) {
        sql.append("AND LOWER(fullname) LIKE ? ");
    }
    if (username != null && !username.trim().isEmpty()) {
        sql.append("AND LOWER(username) LIKE ? ");
    }
    if (address != null && !address.trim().isEmpty()) {
        sql.append("AND LOWER(address) LIKE ? ");
    }
    if (roleId != null && roleId > 0) {
        sql.append("AND role_id = ? ");
    }

    if ("fullname".equalsIgnoreCase(sortBy)) {
        sql.append("ORDER BY fullname ASC ");
    } else if ("phonenumber".equalsIgnoreCase(sortBy)) {
        sql.append("ORDER BY phonenumber ASC ");
    }

    try (
         PreparedStatement ps = connection.prepareStatement(sql.toString())) {

        int paramIndex = 1;
        if (fullname != null && !fullname.trim().isEmpty()) {
            ps.setString(paramIndex++, "%" + fullname.trim().toLowerCase() + "%");
        }
        if (username != null && !username.trim().isEmpty()) {
            ps.setString(paramIndex++, "%" + username.trim().toLowerCase() + "%");
        }
        if (address != null && !address.trim().isEmpty()) {
            ps.setString(paramIndex++, "%" + address.trim().toLowerCase() + "%");
        }
        if (roleId != null && roleId > 0) {
            ps.setInt(paramIndex++, roleId);
        }

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullname(rs.getString("fullname"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhonenumber(rs.getString("phonenumber"));
                user.setAddress(rs.getString("address"));
                user.setStatus(rs.getString("status"));
                user.setRoleId(rs.getInt("role_id"));
                // Gán thêm các trường khác nếu có
                users.add(user);
            }
        }
    }
    return users;
}


    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setFullname(rs.getString("fullname"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPhonenumber(rs.getString("phonenumber"));
                    user.setAddress(rs.getString("address"));
                    user.setStatus(rs.getString("status"));
                    user.setRoleId(rs.getInt("role_id"));
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy người dùng theo ID: " + e.getMessage());
        }
        return null;
    }

}
