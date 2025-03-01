package service.impl;

import model.Order;
import model.User;
import repository.connection.DBRepository;
import repository.user.UserRepository;
import service.IService;
import service.IUserService;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserService implements IService , IUserService {
    private final UserRepository userRepository = new UserRepository();

    private Connection conn;
    public UserService() {
        this.conn = DBRepository.getConnection();
    }

    @Override
    public List<User> getAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, username, email, role_id, status FROM Users WHERE status = 1";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        "", // Không lấy password để bảo mật
                        rs.getString("email"),
                        rs.getInt("role_id"),
                        rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Xóa mềm người dùng (đổi status thành 0)
    @Override
    public void remove(int id) {
        String sql = "UPDATE Users SET status = 0 WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(int id, Object o) {

    }
    // Cập nhật thông tin người dùng

    public void update(int id, User user) {
        String sql = "UPDATE Users SET username = ?, email = ?, role_id = ? WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setInt(3, user.getRoleId());
            stmt.setInt(4, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(int id, Order o) {

    }

    // Tìm người dùng theo ID
    @Override
    public User findById(int id) {
        String sql = "SELECT id, username, email, role_id, status FROM Users WHERE id = ?";
        User user = null;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        "",  // Không lấy password để bảo mật
                        rs.getString("email"),
                        rs.getInt("role_id"),
                        rs.getInt("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    // Tìm người dùng theo tên
    @Override
    public List<User> findByName(String name) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, username, email, role_id, status FROM Users WHERE username LIKE ? AND status = 1";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + name + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        "",
                        rs.getString("email"),
                        rs.getInt("role_id"),
                        rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    @Override
    public void add(Object o) {
    }

    @Override
    public void add(User user) {
        userRepository.saveUser(user);
    }


    @Override
    public User login(String userName, String password) {
        return userRepository.login(userName,password);
    }
}
