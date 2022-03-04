package com.main.service;
import org.springframework.stereotype.Service;

import com.main.db.bpaas.entity.User;

@Service
public interface UserService {

    void save(User user);

    User findByUsername(String username);
}
