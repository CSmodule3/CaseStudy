package service;

import model.Book;

import java.util.List;

public interface IBookService {
    List<Book> findByAuthor(String name);
    List<Book> findByAuthorFr();

}
