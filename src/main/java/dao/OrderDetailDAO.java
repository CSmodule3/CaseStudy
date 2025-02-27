package dao;

import model.OrderDetail;
import repository.connection.DBRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO {
    private Connection conn;

    public OrderDetailDAO(Connection conn) {
        this.conn = conn;
    }

    public List<OrderDetail> getAllOrderDetails() {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM Order_Details";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt("id"),
                        rs.getInt("book_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getString("province_city"),
                        rs.getString("district"),
                        rs.getString("ward"),
                        rs.getString("street"),
                        rs.getString("note_order"),
                        rs.getDouble("total_price"),
                        rs.getString("payment_method"),
                        rs.getString("order_status")
                );
                orderDetails.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    // Tìm chi tiết đơn hàng theo ID
    public OrderDetail getOrderDetailById(int id) {
        String sql = "SELECT * FROM Order_Details WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new OrderDetail(
                        rs.getInt("id"),
                        rs.getInt("order_id"),
                        rs.getInt("book_id"),
                        rs.getInt("quantity"),
                        rs.getString("full_name"),
                        rs.getString("phone_number"),
                        rs.getString("province_city"),
                        rs.getString("district"),
                        rs.getString("ward"),
                        rs.getString("street"),
                        rs.getString("note_order"),
                        rs.getString("payment_method"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật chi tiết đơn hàng
    public void updateOrderDetail(int id, OrderDetail orderDetail) {
        String sql = "UPDATE Order_Details SET quantity=?, note_order=?, status=? WHERE id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderDetail.getQuantity());
            stmt.setString(2, orderDetail.getNoteOrder());
            stmt.setString(3, orderDetail.getStatus());
            stmt.setInt(4, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa chi tiết đơn hàng
    public void deleteOrderDetail(int id) {
        String sql = "DELETE FROM Order_Details WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void add(OrderDetail orderDetail) {
        String sql = "INSERT INTO order_details(book_id,full_name,email,phone_number,province_city,district,ward,street,note_order, total_price,payment_method) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = new DBRepository().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1,orderDetail.getBookId());
            preparedStatement.setString(2,orderDetail.getFullName());
            preparedStatement.setString(3, orderDetail.getEmail());
            preparedStatement.setString(4, orderDetail.getPhoneNumber());
            preparedStatement.setString(5, orderDetail.getProvinceCity());
            preparedStatement.setString(6, orderDetail.getDistrict());
            preparedStatement.setString(7, orderDetail.getWard());
            preparedStatement.setString(8, orderDetail.getStreet());
            preparedStatement.setString(9, orderDetail.getNoteOrder());
            preparedStatement.setDouble(10, orderDetail.getPrice());
            preparedStatement.setString(11, orderDetail.getPaymentMethod());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm sản phẩm!", e);
        }
    }

}
