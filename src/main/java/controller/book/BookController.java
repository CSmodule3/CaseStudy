package controller.book;

import model.Book;
import service.impl.BookService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BookController",urlPatterns = {"/book", "/"})
public class BookController extends HttpServlet {
    private final BookService bookService = new BookService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("type");
        String searchQuery = req.getParameter("query");

        List<Book> books;
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            switch (action) {
                case "author":
                    books = bookService.findByAuthor(searchQuery);
                    break;
                case "foreign_author":
                    books = bookService.findByAuthorFr();
                    break;
                default:
                    books = bookService.findByName(searchQuery);
                    break;
            }
        } else {
            books = bookService.getAll();
        }

        req.setAttribute("books", books);
        req.getRequestDispatcher("WEB-INF/view/book/listbook.jsp").forward(req, resp);
    }

}
