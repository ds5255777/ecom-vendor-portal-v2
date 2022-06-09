package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


import com.main.db.bpaas.entity.PaymentTerms;

@Repository
public interface PaymentTermRepo extends JpaRepository<PaymentTerms, Integer>{
	
	@Query(value = "select payment_term from payment_terms order by payment_term asc ",nativeQuery = true)
	List<String> getPaymentTerms();

}
