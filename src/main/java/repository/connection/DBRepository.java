package repository.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;



public class DBRepository {
    private static final String jdbcURL = "jdbc:mysql://localhost:3306/bookstoredb";
    private static final String jdbcUsername = "root";
    private static final String jdbcPassword = "159357bapD";


    public static void main(String[] args) {
        try (Connection conn = getConnection()) {
            if (conn != null) {
                System.out.println("Kết nối MySQL thành công!");
            } else {
                System.out.println("Không thể kết nối đến MySQL!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getMessage());
y
        }
    }

    public static Connection getConnection() {
        try {

            if (connection == null || connection.isClosed()) {
                connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;

    }
}
