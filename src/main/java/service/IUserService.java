package service;

import model.User;

public interface IUserService {
    User login(String userName, String password);
}
