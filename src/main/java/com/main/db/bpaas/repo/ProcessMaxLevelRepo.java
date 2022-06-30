package com.main.db.bpaas.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.ProcessMaxLevel;

@Repository
public interface ProcessMaxLevelRepo extends JpaRepository<ProcessMaxLevel, Integer> {

}
