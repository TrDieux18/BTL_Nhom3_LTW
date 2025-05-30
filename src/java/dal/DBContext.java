package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=flightticket;encrypt=false";
    private static final String USER = "sa"; // đổi nếu bạn dùng user khác
    private static final String PASSWORD = "123"; // thay bằng mật khẩu thật
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    protected Connection connection;

    public DBContext() {
        try {
            Class.forName(DRIVER); // Load SQL Server driver
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Kết nối thành công đến SQL Server!");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Không tìm thấy driver SQL Server: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("❌ Lỗi kết nối CSDL SQL Server: " + e.getMessage());
        }
    }

    public Connection getConnection() {
        return connection;
    }
}
