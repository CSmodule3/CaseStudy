package repository.order;

import model.Order;
import model.OrderDetail;
import repository.connection.DBRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderRepository {

    public static List<OrderDetail> findAllOrderDetails() {
        List<OrderDetail> orderDetails = new ArrayList<>();
        try {
            Statement statement = DBRepository.getConnection().createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT od.*, o.status FROM order_details od JOIN orders o ON od.order_id = o.id");

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                int orderId = resultSet.getInt("order_id");
                int bookId = resultSet.getInt("book_id");
                int quantity = resultSet.getInt("quantity");
                String fullName = resultSet.getString("full_name");
                String phoneNumber = resultSet.getString("phone_number");
                String provinceCity = resultSet.getString("province_city");
                String district = resultSet.getString("district");
                String ward = resultSet.getString("ward");
                String street = resultSet.getString("street");
                String noteOrder = resultSet.getString("note_order");
                String paymentMethod = resultSet.getString("payment_method");
                String status = resultSet.getString("status"); // Lấy trạng thái đơn hàng

                orderDetails.add(new OrderDetail(id, orderId, bookId, quantity,
                        fullName, phoneNumber, provinceCity,
                        district, ward, street, noteOrder,
                        paymentMethod, status));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách chi tiết đơn hàng", e);
        }
        return orderDetails;
    }

    private final String url = "jdbc:mysql://localhost:3306/bookstore";
    private final String user = "root";
    private final String password = "159357bapD";

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Orders")) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("id"),
                        rs.getInt("customer_id"),
                        rs.getTimestamp("order_date").toLocalDateTime(),
                        rs.getDouble("total_price"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }


    public OrderDetail getOrderById(int id) {
        OrderDetail order = null;
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Orders WHERE id = ?")) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                order = new OrderDetail(
                        rs.getInt("id"),
                        rs.getInt("order_id"),  // Thêm order_id
                        rs.getInt("book_id"),   // Thêm book_id
                        rs.getInt("quantity"),
                        rs.getString("fullName"),
                        rs.getString("phoneNumber"),
                        rs.getString("provinceCity"), // Thêm thông tin địa chỉ
                        rs.getString("district"),
                        rs.getString("ward"),
                        rs.getString("street"),
                        rs.getString("noteOrder"),
                        rs.getString("paymentMethod"),
                        rs.getString("status")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public void deleteOrder(int id) {
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM Orders WHERE id = ?")) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(int id, OrderDetail orderDetail) {
        String sql = "UPDATE Order_Details SET full_name = ?, phone_number = ?, address = ?, status = ? WHERE id = ?";

        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, orderDetail.getFullName());
            stmt.setString(2, orderDetail.getPhoneNumber());
            stmt.setString(3, orderDetail.getAddress());
            stmt.setString(4, orderDetail.getStatus());
            stmt.setInt(5, id);

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


}