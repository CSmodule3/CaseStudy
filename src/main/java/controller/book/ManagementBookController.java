package controller.book;

import model.Book;
import repository.book.BookRepository;
import service.impl.BookService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = "/managementBook")
public class ManagementBookController extends HttpServlet {
    private final BookService bookService = new BookService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action =req.getParameter("action");
        if (action == null){
            action = "";
        }
        switch (action){
            case "editForm" :
                editForm(req, resp);
                break;
            case "delete":
                break;
            default:
                listBook(req, resp);
                break;
        }
    }
    private void listBook(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
        request.setAttribute("books", bookService.getAll());
        request.getRequestDispatcher("WEB-INF/view/book/managementBook.jsp").forward(request, response);
    }
    private void editForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Book book = bookService.findById(id);

        if (book != null) {
            request.setAttribute("book", book);
            request.getRequestDispatcher("WEB-INF/view/book/editBook.jsp").forward(request, response);
        } else {
            response.sendRedirect("/managementBook?error=notfound");
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null){
            action = "";
        }
        switch (action){
            case "edit":
                updateBook(req, resp);
                break;
        }
    }
    private void updateBook(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String title = req.getParameter("title");
        String author = req.getParameter("author");
        Double price = Double.parseDouble(req.getParameter("price"));
        String image = req.getParameter("ImageURL");
        int stock = Integer.parseInt(req.getParameter("stock_quantity"));
        String description = req.getParameter("book_description");
        Book book = new Book(id,title ,author, price,image, stock,description);
        bookService.updateBook(book);
        resp.sendRedirect("/managementBook");
    }
}
