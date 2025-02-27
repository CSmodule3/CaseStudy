package controller.order;

import dao.OrderDetailDAO;
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null){
            action = "";
        }
        switch (action){
            case "update" :
                updateOrderDetail(request, response);
                break;
            case "create" :
                insertOrderDetails(request,response);
                break;
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
    private void insertOrderDetails(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String provinceCity = request.getParameter("provinceCity");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String street = request.getParameter("street");
        String noteOrder = request.getParameter("noteOrder");
        String paymentMethod = request.getParameter("paymentMethod");

        String totalPriceStr = request.getParameter("totalPrice");
        double totalPrice = 0.0; // Giá trị mặc định

        if (totalPriceStr != null && !totalPriceStr.trim().isEmpty()) {
            try {
                totalPrice = Double.parseDouble(totalPriceStr);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid totalPrice format");
                return; // Dừng phương thức nếu lỗi
            }
        }

        OrderDetail orderDetail = new OrderDetail(bookId, fullName, email, phoneNumber, provinceCity, district, ward, street, noteOrder, totalPrice, paymentMethod);
        orderDetailService.add(orderDetail);

        response.sendRedirect("orderDetails?action=list");
    }


}


