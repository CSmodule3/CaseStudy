package service.impl;

import model.Book;

import model.Order;

import model.User;

import repository.book.BookRepository;
import service.IBookService;
import service.IService;

import java.util.List;

public class BookService implements IService<Book>, IBookService {
    private static BookRepository bookRepository = new BookRepository();
    @Override
    public List<Book> getAll() {
        return bookRepository.findAll();
    }

    @Override
    public void remove(int id) {

    }

    @Override
    public void update(int id, Book o) {

    }

    @Override
    public void update(int id, Order o) {

    }

    @Override
    public Book findById(int id) {
        return bookRepository.findById(id);
    }


    @Override
    public List<Book> findByName(String name) {
        return bookRepository.findByName(name);
    }

    @Override
    public void add(Book book) {

    }

    @Override
    public List<Book> findByAuthor(String name) {
        return bookRepository.findByAuthor(name);
    }

    @Override

    public void update(int id, User user) {

    }

    @Override
    public Book findById(int id) {
        return null;
    }

    @Override
    public List<Book> findByName(String name) {
        return bookRepository.findByName(name);
    }

    @Override
    public User login(String userName, String password) {
        return null;

    }

    @Override
    public List<Book> findByAuthor(String name) {
        return bookRepository.findByAuthor(name);
    }

    @Override
    public List<Book> findByAuthorFr() {
        return bookRepository.findByAuthorFr();
    }
}
