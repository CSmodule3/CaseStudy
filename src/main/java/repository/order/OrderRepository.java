package repository.order;

import model.Order;
import model.OrderDetail;
import repository.connection.DBRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderRepository {

    public List<OrderDetail> findAllOrderDetails() {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String query = "SELECT od.*, o.status FROM order_details od " +
                "JOIN orders o ON od.order_id = o.id";
        try (Connection conn = DBRepository.getConnection();
             Statement statement = conn.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                orderDetails.add(new OrderDetail(
                        resultSet.getInt("id"),
                        resultSet.getInt("order_id"),
                        resultSet.getInt("book_id"),
                        resultSet.getInt("quantity"),
                        resultSet.getString("full_name"),
                        resultSet.getString("phone_number"),
                        resultSet.getString("province_city"),
                        resultSet.getString("district"),
                        resultSet.getString("ward"),
                        resultSet.getString("street"),
                        resultSet.getString("note_order"),
                        resultSet.getString("payment_method"),
                        resultSet.getString("status")
                ));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách chi tiết đơn hàng", e);
        }
        return orderDetails;
    }

    public List<Order> findAllOrders() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("id"),
                        rs.getInt("book_id"),
                        rs.getInt("customer_id"),
                        rs.getTimestamp("order_date").toLocalDateTime(),
                        rs.getDouble("total_price"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách đơn hàng", e);
        }
        return orders;
    }

    public Order findOrderById(int id) {
        Order order = null;
        String query = "SELECT * FROM orders WHERE id = ?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                order = new Order(
                        rs.getInt("id"),
                        rs.getInt("book_id"),
                        rs.getInt("customer_id"),
                        rs.getTimestamp("order_date").toLocalDateTime(),
                        rs.getDouble("total_price"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy đơn hàng theo ID", e);
        }
        return order;
    }

    public void deleteOrder(int id) {
        String query = "DELETE FROM orders WHERE id = ?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi xóa đơn hàng", e);
        }
    }

    public void updateOrderDetail(int id, OrderDetail orderDetail) {
        String query = "UPDATE order_details SET full_name = ?, phone_number = ?, " +
                "province_city = ?, district = ?, ward = ?, street = ?, " +
                "note_order = ?, payment_method = ?, status = ? WHERE id = ?";

        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, orderDetail.getFullName());
            stmt.setString(2, orderDetail.getPhoneNumber());
            stmt.setString(3, orderDetail.getProvinceCity());
            stmt.setString(4, orderDetail.getDistrict());
            stmt.setString(5, orderDetail.getWard());
            stmt.setString(6, orderDetail.getStreet());
            stmt.setString(7, orderDetail.getNoteOrder());
            stmt.setString(8, orderDetail.getPaymentMethod());
            stmt.setString(9, orderDetail.getStatus());
            stmt.setInt(10, id);

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi cập nhật chi tiết đơn hàng", e);
        }
    }

    public static Order findById(int id) {
        String sql = "SELECT * FROM Orders WHERE id = ?";
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstoredb", "root", "admin4320");
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Order(
                        rs.getInt("id"),
                        rs.getInt("book_id"),
                        rs.getInt("customer_id"),
                        rs.getTimestamp("order_date").toLocalDateTime(),
                        rs.getDouble("total_price"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy đơn hàng
    }

}
