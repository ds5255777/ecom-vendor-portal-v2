package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.main.db.bpaas.entity.InvoiceGenerationEntity;

public interface InvoiceGenerationEntityRepo extends JpaRepository<InvoiceGenerationEntity, Long> {

	@Query(value = "select * from invoice_generation where invoice_status='Processed'", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllProcessedInvoice();

	@Query(value = "select * from invoice_generation where invoice_status='Approve'", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllApproveInvoice();

	@Query(value = "select * from invoice_generation where invoice_status='Reject'", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllRejectInvoice();

	@Query(value = "select * from invoice_generation", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllInvoice();

	@Query(value = "select count(*) from invoice_generation where invoice_status='Pending'", nativeQuery = true)
	int getPendingInvoiceCount();

	@Query(value = "select count(*) from invoice_generation where invoice_status='Reject'", nativeQuery = true)
	int getRejecteInvoiceCount();
	
	InvoiceGenerationEntity findByInvoiceNumber(String invoiceNumber);

 //Saurabh
@Query(value = "select count(*) from invoice_details", nativeQuery = true)
    int getCountForAllInvoices();
//

}
