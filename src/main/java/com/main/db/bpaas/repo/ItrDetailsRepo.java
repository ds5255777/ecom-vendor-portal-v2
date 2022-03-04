package com.main.db.bpaas.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.ItrDetails;

@Repository
public interface ItrDetailsRepo extends JpaRepository<ItrDetails, Long>{

}
