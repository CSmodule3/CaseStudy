package controller.cart;

import model.CartItem;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        for (CartItem item : cart) {
            if (item.getId() == id) {
                item.setQuantity(quantity);
                session.setAttribute("cart", cart);
                response.sendRedirect("cart.jsp");
                return;
            }
        }

        response.sendRedirect("cart.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        String action = request.getParameter("action");
        if ("remove".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            cart.removeIf(item -> item.getId() == id);
        }

        session.setAttribute("cart", cart);

        // Chuyển tiếp request đến trang cart.jsp trong WEB-INF
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/order/cart.jsp");
        dispatcher.forward(request, response);
    }

}
