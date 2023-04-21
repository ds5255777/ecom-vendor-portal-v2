package com.main.db.bpaas.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.main.db.bpaas.entity.AddressDetailsTransaction;

public interface AddressDetailsTransactionRepo extends JpaRepository<AddressDetailsTransaction, Long> {

}
