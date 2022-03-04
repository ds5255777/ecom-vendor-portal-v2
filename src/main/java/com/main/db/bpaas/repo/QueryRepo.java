package com.main.db.bpaas.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.main.db.bpaas.entity.QueryEntity;

public interface QueryRepo extends JpaRepository<QueryEntity, Integer>  {

}
