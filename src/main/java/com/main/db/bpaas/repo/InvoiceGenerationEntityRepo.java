package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.main.db.bpaas.entity.InvoiceGenerationEntity;

public interface InvoiceGenerationEntityRepo extends JpaRepository<InvoiceGenerationEntity, Long> {

	@Query(value = "select * from invoice_generation where invoice_status='Processed' and vendor_code=?", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllProcessedInvoice(String vendorCode);

	@Query(value = "select * from invoice_generation where invoice_status='Approve' and vendor_code=?", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllApproveInvoice(String vendorCode);

	@Query(value = "select * from invoice_generation where invoice_status='Draft-Invoicing'  and vendor_code=?", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllRejectInvoice(String vendorCode);
	
	@Query(value = "select * from invoice_generation where invoice_status IN ('Processed', 'Approve') and vendor_code=? ", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllInvoice(String vendorCode);
	
	 @Query(value = "select * from invoice_generation WHERE invoice_status='Draft-Invoicing' and vendor_code=?", nativeQuery = true)
	    List<InvoiceGenerationEntity> getDraftInvoice(String vendorCode);

	@Query(value = "select count(*) from invoice_generation where invoice_status='Processed' and vendor_code=?", nativeQuery = true)
	int getPendingInvoiceCount(String vendorCode);

	@Query(value = "select count(*) from invoice_generation where invoice_status='Draft-Invoicing' and vendor_code=?", nativeQuery = true)
	int getDraftInvoiceCount(String vendorCode);
	
	@Query(value = "select ID from invoice_generation where ecom_invoice_nunmber=?", nativeQuery = true)
	Long getIdByinvocienumber(String invocienumber);

	InvoiceGenerationEntity findByInvoiceNumber(String invoiceNumber);
	
	@Query(value = "select count(*) from invoice_generation where invoice_status='Approve' and vendor_code=? ", nativeQuery = true)
	int getApproveInvoiceCount(String vendorCode);

	// Saurabh
	@Query(value = "select count(*) from invoice_details", nativeQuery = true)
	int getCountForAllInvoices();

//
	//Manish Added , count for Admin
		@Query(value = "select count(*) from invoice_generation where invoice_status='Processed'", nativeQuery = true)
		int  getCountForAllProcessedInvoice();

		@Query(value = "select count(*) from invoice_generation where invoice_status='Approve'", nativeQuery = true)
		int  getCountForAllApproveInvoice();
	//End
	
		@Query(value = "select * from invoice_generation where invoice_status ='Query' And assign_to ='Vendor'  and vendor_code=? ", nativeQuery = true)
		List<InvoiceGenerationEntity> getAllQueryInvoiceVendorPo(String vendorCode);
		
		
		
}
