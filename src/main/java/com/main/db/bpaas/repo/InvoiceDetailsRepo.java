package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.InvoiceDetails;


@Repository
public interface InvoiceDetailsRepo extends JpaRepository<InvoiceDetails, Long> {
	
	@Query(value = "select * from invoice_details where invoice_status='Pending'", nativeQuery = true)
	List<InvoiceDetails> getAllPendingInvoice();
	
	@Query(value = "select * from invoice_details where invoice_status='Approve'", nativeQuery = true)
	List<InvoiceDetails> getAllApproveInvoice();
	
	@Query(value = "select * from invoice_details where invoice_status='Reject'", nativeQuery = true)
	List<InvoiceDetails> getAllRejectInvoice();
	
	@Query(value = "select * from invoice_generation", nativeQuery = true)
	List<InvoiceDetails> getAllInvoice();
	
	@Query(value = "select count(*) from invoice_details where invoice_status='Approve'", nativeQuery = true)
	int getApproveInvoiceCount();
	
	@Query(value = "select count(*) from invoice_details where invoice_status='Pending'", nativeQuery = true)
	int getPendingInvoiceCount();
	
	@Query(value = "select count(*) from invoice_details where invoice_status='Reject'", nativeQuery = true)
	int getRejecteInvoiceCount();
	
	
	
	
	

}
