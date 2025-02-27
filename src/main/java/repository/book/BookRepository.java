package repository.book;

import model.Book;
import repository.connection.DBRepository;


import java.sql.*;
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
                books.add(new Book(idBook,title,author,price,quantity,imageURL,description));
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
                books.add(new Book(idBook, title, author, price, quantity, imageURL, description));
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
                books.add(new Book(idBook, title, authorName, price, quantity, imageURL, description));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return books;
    }

}
