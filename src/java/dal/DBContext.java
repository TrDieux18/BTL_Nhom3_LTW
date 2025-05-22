package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            String url = "jdbc:mysql://localhost:3306/flightticket";
            String username = "root";
            String password = "trandieu2210";

            Class.forName("com.mysql.cj.jdbc.Driver"); 
            connection = DriverManager.getConnection(url, username, password);
            System.out.println("✅ Kết nối thành công đến MySQL!");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Không tìm thấy driver MySQL: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("❌ Lỗi kết nối CSDL: " + e.getMessage());
        }
    }
}
