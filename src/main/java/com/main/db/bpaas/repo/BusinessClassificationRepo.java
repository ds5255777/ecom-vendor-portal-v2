package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.BusinessClassification;


@Repository
public interface BusinessClassificationRepo  extends JpaRepository<BusinessClassification, Integer>{
	
	@Query(value = "select name from business_classification ",nativeQuery = true)
	List<String> getBusinessClassification();

}
