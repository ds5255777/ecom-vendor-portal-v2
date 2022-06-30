package com.main.db.bpaas.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.UserLevel;

@Repository
public interface UserLevelRepo extends JpaRepository<UserLevel, Integer> {

}
