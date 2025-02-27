package controller.Servlets;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email"); // Lấy email từ form
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User newUser = new User(username, password, email); // email đúng vị trí

        boolean isRegistered = userDAO.registerUser(newUser);

        if (isRegistered) {
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            response.sendRedirect("login");
        } else {
            request.setAttribute("errorMessage", "Đăng ký thất bại, vui lòng thử lại.");
            request.getRequestDispatcher("/WEB-INF/view/login/loginPage.jsp").forward(request, response);
        }
    }
}
