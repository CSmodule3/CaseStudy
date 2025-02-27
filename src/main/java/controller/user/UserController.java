package controller.user;

import model.User;
import service.impl.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserController", urlPatterns = "/users")
public class UserController extends HttpServlet {
    private UserService userService = new UserService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("search");
        List<User> users;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            users = userService.findByName(searchQuery);
        } else {
            users = userService.getAll();
        }

        request.setAttribute("users", users);
        request.setAttribute("searchQuery", searchQuery);
        request.getRequestDispatcher("WEB-INF/view/user/list-users.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            userService.remove(userId);
        } else if ("edit".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            int roleId = Integer.parseInt(request.getParameter("role_id"));

            User user = new User(userId, username, "", email, roleId, 1);

            userService.update(userId, user);
        }

        response.sendRedirect("users");
    }
}
