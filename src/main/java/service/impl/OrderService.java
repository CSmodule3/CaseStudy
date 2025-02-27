package service.impl;


import dao.OrderDAO;
import dao.OrderDetailDAO;
import model.Order;
import model.OrderDetail;
import model.User;
import repository.connection.DBRepository;
import repository.order.OrderRepository;
import service.IService;

import java.sql.Connection;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderService implements IService<Order> {
    private static final Logger LOGGER = Logger.getLogger(OrderService.class.getName());

    private final OrderDAO orderDAO;
    private final OrderDetailDAO orderDetailDAO;
    private final OrderRepository orderRepository;

    public OrderService() {
        Connection conn = DBRepository.getConnection();
        this.orderDAO = new OrderDAO(conn);
        this.orderDetailDAO = new OrderDetailDAO(conn);
        this.orderRepository = new OrderRepository();
    }

    @Override
    public List<Order> getAll() {
        try {
            return orderDAO.getAllOrders();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách đơn hàng", e);
            return List.of();
        }
    }

    public List<OrderDetail> findAllOrderDetails() {
        try {
            return orderRepository.findAllOrderDetails();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách chi tiết đơn hàng", e);
            return List.of();
        }
    }

    @Override
    public void remove(int id) {
        try {
            orderDAO.deleteOrder(id);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa đơn hàng có ID: " + id, e);
        }
    }

    @Override
    public void update(int id, Order order) {
        try {
            orderDAO.updateOrder(id, order);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật đơn hàng có ID: " + id, e);
        }
    }

    @Override
    public void update(int id, User user) {

    }

    public void updateOrderDetail(int id, OrderDetail orderDetail) {
        try {
            orderDetailDAO.updateOrderDetail(id, orderDetail);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật chi tiết đơn hàng có ID: " + id, e);
        }
    }

    @Override
    public Order findById(int id) {
        try {
            Order order = orderDAO.getOrderById(id);
            return order != null ? order : new Order(); // Trả về đối tượng Order rỗng nếu không tìm thấy
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm đơn hàng có ID: " + id, e);
            return new Order(); // Tránh trả về null
        }
    }


    @Override
    public List<Order> findByName(String name) {
        try {
            return orderDAO.getOrdersByCustomerName(name);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tìm đơn hàng của khách hàng: " + name, e);
            return List.of();
        }
    }

    @Override
    public User login(String userName, String password) {
        return null;
    }
}
