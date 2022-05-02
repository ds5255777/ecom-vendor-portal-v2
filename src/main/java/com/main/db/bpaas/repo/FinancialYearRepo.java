package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.FinancialYear;



@Repository
public interface FinancialYearRepo extends JpaRepository<FinancialYear, Integer>{
	
	@Query(value = "select financial_year from financial_year ",nativeQuery = true)
	List<String> getFinancialYear();
	
	

}
