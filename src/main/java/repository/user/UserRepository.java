package repository.user;


import model.Role;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import repository.connection.DBRepository;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserRepository {
    private static final Logger LOGGER = Logger.getLogger(UserRepository.class.getName());

    private static final String INSERT_USER_SQL =
            "INSERT INTO users (username, password, email, role_id, status) VALUES (?, ?, ?, ?, 1)";

    private static final String GET_USER_BY_USERNAME_PASSWORD =
            "SELECT * FROM users WHERE username = ? AND status = 1"; // Chỉ lấy user chưa bị xóa

    private static final String GET_ALL_USERS =
            "SELECT id, username, email, role_id FROM users WHERE status = 1"; // Chỉ lấy user chưa bị xóa

    private static final String UPDATE_USER_STATUS =
            "UPDATE users SET status = ? WHERE id = ?"; // Dùng cho xóa hoặc khôi phục

    public void saveUser(User user) {
        try (Connection connection = DBRepository.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {

            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()); // Mã hóa mật khẩu
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, hashedPassword);
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setInt(4, user.getRoleId());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi thêm user: ", e);
        }
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();

        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_ALL_USERS);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        null, // Không trả về mật khẩu
                        rs.getString("email"),
                        rs.getInt("role_id"),
                        1 // Mặc định status = 1 vì chỉ lấy user chưa bị xóa
                ));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách user: ", e);
        }
        return users;
    }
    public User login(String username, String password) {
        try (Connection connection = DBRepository.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_BY_USERNAME_PASSWORD)) {

            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String storedPassword = resultSet.getString("password");

                // So sánh mật khẩu đã mã hóa
                if (BCrypt.checkpw(password, storedPassword)) {
                    return new User(
                            resultSet.getInt("id"),
                            resultSet.getString("username"),
                            null, // Không trả về mật khẩu
                            resultSet.getString("email"),
                            resultSet.getInt("role_id"),
                            resultSet.getInt("status")
                    );
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi đăng nhập: ", e);
        }
        return null;
    }


}


