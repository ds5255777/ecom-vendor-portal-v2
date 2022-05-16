package com.main.db.bpaas.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.main.db.bpaas.entity.InvoiceLineItem;

public interface InvoiceLineItemRepo extends JpaRepository<InvoiceLineItem, Long> {

	

}
