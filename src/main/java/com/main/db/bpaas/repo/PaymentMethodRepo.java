package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.main.db.bpaas.entity.PaymentMethod;

public interface PaymentMethodRepo extends JpaRepository<PaymentMethod, Integer> {
	
	@Query(value = "select name from payment_method ",nativeQuery = true)
	List<String> PaymentMethod();

}
