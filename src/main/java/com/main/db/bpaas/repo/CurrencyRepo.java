package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.Currency;

@Repository
public interface CurrencyRepo extends JpaRepository<Currency, Integer>{
	
	@Query(value = "select currency_name from currency ",nativeQuery = true)
	List<String> getCurrencyType();

}
