package dal;

import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {

    public String registerUser(User user) {
        try {
            // Kiểm tra trùng username
            String checkUsernameQuery = "SELECT COUNT(*) FROM users WHERE username = ?";
            PreparedStatement checkUsernameStmt = connection.prepareStatement(checkUsernameQuery);
            checkUsernameStmt.setString(1, user.getUsername());
            ResultSet rsUsername = checkUsernameStmt.executeQuery();
            if (rsUsername.next() && rsUsername.getInt(1) > 0) {
                return "Tên tài khoản đã tồn tại.";
            }

            // Kiểm tra trùng email
            String checkEmailQuery = "SELECT COUNT(*) FROM users WHERE email = ?";
            PreparedStatement checkEmailStmt = connection.prepareStatement(checkEmailQuery);
            checkEmailStmt.setString(1, user.getEmail());
            ResultSet rsEmail = checkEmailStmt.executeQuery();
            if (rsEmail.next() && rsEmail.getInt(1) > 0) {
                return "Email đã tồn tại.";
            }

            // Kiểm tra trùng phonenumber
            String checkPhoneQuery = "SELECT COUNT(*) FROM users WHERE phonenumber = ?";
            PreparedStatement checkPhoneStmt = connection.prepareStatement(checkPhoneQuery);
            checkPhoneStmt.setString(1, user.getPhonenumber());
            ResultSet rsPhone = checkPhoneStmt.executeQuery();
            if (rsPhone.next() && rsPhone.getInt(1) > 0) {
                return "Số điện thoại đã tồn tại.";
            }
            System.out.println("da nhay vao DAO");
            // Nếu không có thông tin trùng, tiến hành đăng ký người dùng mới
            String insertUser = 
                "INSERT INTO [dbo].[users] " +
                "([fullname], [username], [email], [phonenumber], [password], [address], [status], [role_id]) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            // Chuẩn bị câu lệnh chèn dữ liệu vào bảng users
            PreparedStatement insertStmt = connection.prepareStatement(insertUser);
            insertStmt.setString(1, user.getFullname());
            insertStmt.setString(2, user.getUsername());
            insertStmt.setString(3, user.getEmail());
            insertStmt.setString(4, user.getPhonenumber());
            insertStmt.setString(5, user.getPassword());
            insertStmt.setString(6, user.getAddress());
            insertStmt.setString(7, user.getStatus());
            insertStmt.setInt(8, user.getRoleId());

            // Thực thi câu lệnh chèn
            int rowsAffected = insertStmt.executeUpdate();
            return rowsAffected > 0 ? null : "Lỗi khi lưu dữ liệu vào database.";

        } catch (SQLException e) {
            return "Lỗi kết nối database.";
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
                user.setId(rs.getString("id"));
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
                user.setId(rs.getString("id"));
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

    public boolean updatePassword(String username, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, username);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE users SET fullname = ?, email = ?, phonenumber = ?, address = ? WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhonenumber());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getUsername());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

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
            ps.setString(9, user.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi cập nhật người dùng: " + e.getMessage());
        }
    }

    public void delete(String userId) {
        String sql = "UPDATE users SET status = ? WHERE id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, 0);
            ps.setString(2, userId);

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
                    user.setId(rs.getString("id"));
                    user.setFullname(rs.getString("fullname"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setPhonenumber(rs.getString("phonenumber"));
                    user.setAddress(rs.getString("address"));
                    user.setStatus(rs.getString("status"));
                    user.setRoleId(rs.getInt("role_id"));

                    users.add(user);
                }
            }
        }
        return users;
    }

    public User getUserById(String id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getString("id"));
                    user.setFullname(rs.getString("fullname"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
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
    public boolean isEmailUsedByAnotherUser(String email, String currentUserId) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ? AND id != ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, currentUserId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isPhoneUsedByAnotherUser(String phone, String currentUserId) {
        String query = "SELECT COUNT(*) FROM users WHERE phonenumber = ? AND id != ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, phone);
            stmt.setString(2, currentUserId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public User findByEmail(String email) {
    String sql = "SELECT * FROM users WHERE email = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {

        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            User user = new User();
            user.setId(rs.getString("id"));
            user.setFullname(rs.getString("fullname"));
            user.setUsername(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setPhonenumber(rs.getString("phonenumber"));
            user.setPassword(rs.getString("password"));
            user.setStatus(rs.getString("status"));
            user.setAddress(rs.getString("address"));
            user.setRoleId(rs.getInt("role_id"));
            return user;
        }

        } catch (Exception e) {
            e.printStackTrace(); // hoặc log ra hệ thống
        }
        return null;
    }
    public boolean updatePassword2(String email, String password) {
        String sql = "UPDATE users SET password = ? WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, password);
            ps.setString(2, email);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
