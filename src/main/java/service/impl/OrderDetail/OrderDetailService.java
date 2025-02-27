package service.impl.OrderDetail;

import dao.OrderDetailDAO;
import model.Order;
import model.OrderDetail;
import model.User;
import repository.connection.DBRepository;
import service.IService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class OrderDetailService implements IService<OrderDetail> {
    private final OrderDetailDAO orderDetailDAO;

    public OrderDetailService(Connection conn) {
        this.orderDetailDAO = new OrderDetailDAO(conn);
    }

    @Override
    public List<OrderDetail> getAll() {
        return orderDetailDAO.getAllOrderDetails();
    }

    @Override
    public void remove(int id) {
        orderDetailDAO.deleteOrderDetail(id);
    }

    @Override
    public void update(int id, OrderDetail orderDetail) {
        orderDetailDAO.updateOrderDetail(id, orderDetail);
    }

    @Override

    public void update(int id, User user) {

    }

    @Override
    public OrderDetail findById(int id) {
        return orderDetailDAO.getOrderDetailById(id);
    }

    @Override
    public List<OrderDetail> findByName(String name) {
        throw new UnsupportedOperationException("findByName không được hỗ trợ cho OrderDetail");
    }

    @Override

    public void add(OrderDetail orderDetail) {
        orderDetailDAO.add(orderDetail);
    }

    public User login(String userName, String password) {
        return null;
    }

    public boolean updateOrderDetail(int id, int orderId, String fullName, String phoneNumber, String address, String status) {
        String sql = "UPDATE Order_Details SET fullName=?, phoneNumber=?, address=?, status=? WHERE id=? AND orderId=?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, fullName);
            stmt.setString(2, phoneNumber);
            stmt.setString(3, address);
            stmt.setString(4, status);
            stmt.setInt(5, id);
            stmt.setInt(6, orderId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
