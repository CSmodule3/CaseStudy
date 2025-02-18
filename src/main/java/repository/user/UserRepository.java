package repository.user;


import model.User;
import org.mindrot.jbcrypt.BCrypt;
import repository.connection.DBRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserRepository {
    private static final String INSERT_USER_SQL = "INSERT INTO user (username, password, email, roleId) VALUES (?, ?, ?, ?)";

    public void saveUser(User user) {
        try (Connection connection = DBRepository.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword()); // Lưu ý: Cần mã hóa mật khẩu
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setInt(4, user.getRoleId());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public User getUserByUsername(String username) {
        User user = null;
        String query = "SELECT id, username, password, email, role_id FROM users WHERE username = ?";

        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("password"), // Lấy mật khẩu đã mã hóa
                            rs.getString("email"),
                            rs.getInt("role_id")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public User getUserByUsernameAndPassword(String username, String password) {
        User user = getUserByUsername(username);
        if (user == null) {
            return null; // Trả về null ngay lập tức nếu không tìm thấy user
        }
        if (BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT id, username, email, role_id FROM users"; // Không lấy password

        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        null, // Không trả về mật khẩu
                        rs.getString("email"),
                        rs.getInt("role_id")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

}

