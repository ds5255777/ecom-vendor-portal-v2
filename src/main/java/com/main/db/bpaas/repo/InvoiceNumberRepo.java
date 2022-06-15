package com.main.db.bpaas.repo;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.main.db.bpaas.entity.InvoiceNumber;

@EnableJpaRepositories
public interface InvoiceNumberRepo extends JpaRepository<InvoiceNumber, Integer> {
	
	@Transactional
    @Modifying
    @Query(value = "update invoice_number set invoice_status='Delete' WHERE ecom_invoice_nunmber=:invoiceNumber ; ", nativeQuery = true)
    void removeInvoice(String invoiceNumber);
}
