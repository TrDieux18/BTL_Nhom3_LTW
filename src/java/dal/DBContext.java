package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    protected Connection connection;

    public DBContext() {
        try {
             String url = "jdbc:sqlserver://localhost:1433;databaseName= flightticket";
            String username = "sa";
            String password = "1234";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
            System.out.println("✅ Kết nối thành công đến SQL sever");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Không tìm thấy driver SQL sever: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("❌ Lỗi kết nối CSDL: " + e.getMessage());
        }
    }
}
