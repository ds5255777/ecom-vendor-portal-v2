package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

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
		 @Query(value="select invoice_number from invoice_generation where vendor_code =:vendorCode and invoice_number=:invoiceNumber ; ", nativeQuery=true)
		String checkForExistingInvoiceNumber(@Param("vendorCode") String vendorCode, @Param("invoiceNumber") String invoiceNumber);

		 @Query(value="select * from invoice_generation where invoice_status IN ('Processed', 'Approve')  ORDER by id desc limit 50; ", nativeQuery=true)
		List<InvoiceGenerationEntity> topFiftyUnProcessedInvoice();
	
		 @Query(value = "select * from invoice_generation where invoice_status IN ('Processed', 'Approve') ", nativeQuery = true)
			List<InvoiceGenerationEntity> getAllInvoiceByFinance();

}
