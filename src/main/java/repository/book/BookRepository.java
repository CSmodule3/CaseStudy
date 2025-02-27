package repository.book;

import model.Book;
import repository.connection.DBRepository;


import java.sql.*;

import java.time.LocalDate;


import java.util.ArrayList;
import java.util.List;

public class BookRepository {

    private static List<Book> books = new ArrayList<>();

    public static List<Book> findAll() {
        List<Book> books = new ArrayList<>();
        try {
            Statement statement = DBRepository.getConnection().
                    createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * from books");
            while (resultSet.next()){
                int idBook =resultSet.getInt("id");
                String title = resultSet.getString("title");
                String author = resultSet.getString("author");
                Double price = resultSet.getDouble("price");
                String imageURL = resultSet.getString("ImageURL");
                int quantity = resultSet.getInt("stock_quantity");
                String description = resultSet.getString("book_description");
                books.add(new Book(idBook,title,author,price,imageURL,quantity,description));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return books;
    }
    public static List<Book> findByName(String name) {
        List<Book> books = new ArrayList<>();
        try {
            String query = "SELECT * FROM books WHERE title LIKE ?";
            PreparedStatement preparedStatement = DBRepository.getConnection().prepareStatement(query);
            preparedStatement.setString(1, "%" + name + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int idBook = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String author = resultSet.getString("author");
                Double price = resultSet.getDouble("price");
                String imageURL = resultSet.getString("ImageURL");
                int quantity = resultSet.getInt("stock_quantity");
                String description = resultSet.getString("book_description");
                books.add(new Book(idBook, title, author, price,imageURL, quantity, description));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return books;
    }

    public static List<Book> findByAuthor(String author) {
        List<Book> books = new ArrayList<>();
        try {
            String query = "SELECT * FROM books WHERE author LIKE ?";
            PreparedStatement preparedStatement = DBRepository.getConnection().prepareStatement(query);
            preparedStatement.setString(1, "%" + author + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int idBook = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String authorName = resultSet.getString("author");
                Double price = resultSet.getDouble("price");
                String imageURL = resultSet.getString("ImageURL");
                int quantity = resultSet.getInt("stock_quantity");
                String description = resultSet.getString("book_description");
                books.add(new Book(idBook, title, authorName, price,imageURL, quantity, description));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return books;
    }
    public static List<Book> findByAuthorFr() {
        List<Book> books = new ArrayList<>();
        try {
            String query = "SELECT * FROM books WHERE author NOT IN ('Nam Cao', 'Vũ Trọng Phụng', 'Nguyễn Nhật Ánh')";
            PreparedStatement preparedStatement = DBRepository.getConnection().prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                int idBook = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String authorName = resultSet.getString("author");
                Double price = resultSet.getDouble("price");
                String imageURL = resultSet.getString("ImageURL");
                int quantity = resultSet.getInt("stock_quantity");
                String description = resultSet.getString("book_description");
                books.add(new Book(idBook, title, authorName, price,imageURL, quantity, description));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return books;
    }


    public Book findById(int id) {
        Book book = null;
        Connection conn = DBRepository.getConnection();
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(
                    "SELECT id, title, author, price, ImageURL, stock_quantity,  book_description FROM books WHERE id = ?"
            );
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                String title = rs.getString("title");
                String author = rs.getString("author");
                Double price = rs.getDouble("price");
                String image = rs.getString("ImageURL");
                int stock = rs.getInt("stock_quantity");
                String description = rs.getString("book_description");
                book = new Book(id,title , author, price,image, stock, description);

    public static List<Book> findByName(String name) {
        List<Book> books = new ArrayList<>();
        try {
            String query = "SELECT * FROM books WHERE title LIKE ?";
            PreparedStatement preparedStatement = DBRepository.getConnection().prepareStatement(query);
            preparedStatement.setString(1, "%" + name + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int idBook = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String author = resultSet.getString("author");
                Double price = resultSet.getDouble("price");
                String imageURL = resultSet.getString("ImageURL");
                int quantity = resultSet.getInt("stock_quantity");
                String description = resultSet.getString("book_description");
                books.add(new Book(idBook, title, author, price, quantity, imageURL, description));

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return book;
    }
    public void update(Book book) {
        Connection conn = DBRepository.getConnection();
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(
                    "UPDATE books SET title = ?,author = ? , price = ?,ImageURL = ?  , stock_quantity = ?, book_description = ?  WHERE id = ?"
            );
            preparedStatement.setString(1, book.getTitle());
            preparedStatement.setString(2, book.getAuthor());
            preparedStatement.setDouble(3, book.getPrice());
            preparedStatement.setString(4, book.getImageURL());
            preparedStatement.setInt(5, book.getStockQuantity());
            preparedStatement.setString(6, book.getBookDescription());
            preparedStatement.setInt(7, book.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void delete(int id){
        String sql = "UPDATE books set status = 0 where id = ?";
        Connection connection = DBRepository.getConnection();
        try (PreparedStatement preparedStatement= connection.prepareStatement(sql)) {
            preparedStatement.setInt(1,id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){

        return books;
    }

    public static List<Book> findByAuthor(String author) {
        List<Book> books = new ArrayList<>();
        try {
            String query = "SELECT * FROM books WHERE author LIKE ?";
            PreparedStatement preparedStatement = DBRepository.getConnection().prepareStatement(query);
            preparedStatement.setString(1, "%" + author + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int idBook = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String authorName = resultSet.getString("author");
                Double price = resultSet.getDouble("price");
                String imageURL = resultSet.getString("ImageURL");
                int quantity = resultSet.getInt("stock_quantity");
                String description = resultSet.getString("book_description");
                books.add(new Book(idBook, title, authorName, price, quantity, imageURL, description));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return books;
    }
    public static List<Book> findByAuthorFr() {
        List<Book> books = new ArrayList<>();
        try {
            String query = "SELECT * FROM books WHERE author NOT IN ('Nam Cao', 'Vũ Trọng Phụng', 'Nguyễn Nhật Ánh')";
            PreparedStatement preparedStatement = DBRepository.getConnection().prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                int idBook = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String authorName = resultSet.getString("author");
                Double price = resultSet.getDouble("price");
                String imageURL = resultSet.getString("ImageURL");
                int quantity = resultSet.getInt("stock_quantity");
                String description = resultSet.getString("book_description");

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
=======
        return books;
    }


}
