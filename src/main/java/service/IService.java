package service;


import model.Order;

import model.User;

import java.util.List;

public interface IService<T> {
    List<T> getAll();
    void remove(int id);
    void update(int id, T t);


    // Cập nhật thông tin người dùng
    void update(int id, User user);

    T findById(int id);
    List<T> findByName(String name);


    User login(String userName, String password);


}
