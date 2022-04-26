package com.main.db.bpaas.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.FinancialYear;



@Repository
public interface FinancialYearRepo extends JpaRepository<FinancialYear, Integer>{
	
	

}
