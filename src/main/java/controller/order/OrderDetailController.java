package controller.order;

import model.OrderDetail;
import repository.connection.DBRepository;
import service.impl.OrderDetail.OrderDetailService;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/orderDetails")
public class OrderDetailController extends HttpServlet {
    private OrderDetailService orderDetailService;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBRepository.getConnection(); // Lấy kết nối từ DatabaseConnection
            this.orderDetailService = new OrderDetailService(conn); // Truyền Connection vào Service
        } catch (Exception e) {
            throw new ServletException("Lỗi khởi tạo OrderDetailService", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            listOrderDetails(request, response);
        } else {
            switch (action) {
                case "delete":
                    deleteOrderDetail(request, response);
                    break;
                default:
                    listOrderDetails(request, response);
                    break;
            }
        }
    }

    private void listOrderDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<OrderDetail> orderDetails = orderDetailService.getAll();
        request.setAttribute("orderDetails", orderDetails);
        request.getRequestDispatcher("WEB-INF/view/order/orders-list.jsp").forward(request, response);
    }

    private void deleteOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID để xóa");
            return;
        }

        try {
            int orderDetailId = Integer.parseInt(idParam);
            orderDetailService.remove(orderDetailId);
            response.sendRedirect("orderDetails?action=list");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ: " + idParam);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            updateOrderDetail(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Hành động không hợp lệ");
        }
    }

    private void updateOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String noteOrder = request.getParameter("noteOrder");
            String status = request.getParameter("status");

            OrderDetail existingOrderDetail = orderDetailService.findById(id);
            if (existingOrderDetail != null) {
                existingOrderDetail.setQuantity(quantity);
                existingOrderDetail.setNoteOrder(noteOrder);
                existingOrderDetail.setStatus(status);
                orderDetailService.update(id, existingOrderDetail);
            }

            response.sendRedirect("orderDetails?action=list");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ");
        }
    }
}
