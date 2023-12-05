package com.main.service;
import java.util.List;

import org.springframework.stereotype.Service;

import com.main.db.bpaas.entity.User;

@Service
public interface UserService {

    void save(User user);
    
    User Update(User user, Integer id);

//    List<User> findByUsername(String username);

	List<User> findByRoleId(Integer roleidCommercialHead);

	User findByUsername(String name);

   
}
