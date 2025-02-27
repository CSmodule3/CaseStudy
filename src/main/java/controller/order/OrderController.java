package controller.order;

import model.Order;
import service.impl.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderController",urlPatterns = "/orderpage")
public class OrderController extends HttpServlet {
    private OrderService OrderService = new OrderService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Order> orders = OrderService.getAll();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("WEB-INF/view/order/orderpage.jsp").forward(request, response);
    }
}