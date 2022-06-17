package com.main.service;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import com.main.db.bpaas.entity.User;

@Service
public interface UserService {

    void save(User user);

    User findByUsername(String username);

    @Query(value = "select  id from Users where bp_code=:bpCode "  , nativeQuery = true)
	Integer getUserId(String bpCode);
}
