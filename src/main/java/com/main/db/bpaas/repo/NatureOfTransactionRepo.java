package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


import com.main.db.bpaas.entity.NatureOfTransaction;

@Repository
public interface NatureOfTransactionRepo extends JpaRepository<NatureOfTransaction, Integer>{
	
	@Query(value = "select supplier_type from nature_of_transaction ",nativeQuery = true)
	List<String> getNatureOfTransaction();

}
