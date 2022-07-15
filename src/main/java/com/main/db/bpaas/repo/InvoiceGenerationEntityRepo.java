package com.main.db.bpaas.repo;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.TripDetails;

public interface InvoiceGenerationEntityRepo extends JpaRepository<InvoiceGenerationEntity, Long> {

	@Query(value = "select * from invoice_generation where invoice_status='In-Review' and vendor_code=?", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllProcessedInvoice(String vendorCode);

	@Query(value = "select * from invoice_generation where invoice_status='Approved' and vendor_code=?", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllApproveInvoice(String vendorCode);

	@Query(value = "select * from invoice_generation where invoice_status='Draft-Invoicing'  and vendor_code=?", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllRejectInvoice(String vendorCode);

	@Query(value = "select * from invoice_generation where invoice_status IN ('In-Review','Pending For Approval', 'Approved','Payment Relase', 'Query') and vendor_code=? ", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllInvoice(String vendorCode);

	@Query(value = "select * from invoice_generation where invoice_status IN ('In-Review','Pending For Approval', 'Approved','Payment Relase', 'Query') ", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllNetworkInvoice();

	@Query(value = "select * from invoice_generation WHERE invoice_status='Draft-Invoicing' and vendor_code=?", nativeQuery = true)
	List<InvoiceGenerationEntity> getDraftInvoice(String vendorCode);

	@Query(value = "select count(*) from invoice_generation where invoice_status='In-Review' and vendor_code=?", nativeQuery = true)
	int getPendingInvoiceCount(String vendorCode);

	@Query(value = "select count(*) from invoice_generation where invoice_status='Draft-Invoicing' and vendor_code=?", nativeQuery = true)
	int getDraftInvoiceCount(String vendorCode);

	@Query(value = "select count(*) from invoice_generation where invoice_status='Query' And assign_to ='Vendor' and vendor_code=?", nativeQuery = true)
	int getQueryInvoiceCount(String vendorCode);

	@Query(value = "select ID from invoice_generation where ecom_invoice_nunmber=?", nativeQuery = true)
	Long getIdByinvocienumber(String invocienumber);

	InvoiceGenerationEntity findByEcomInvoiceNumber(String invoiceNumber);

	@Query(value = "select count(*) from invoice_generation where invoice_status='Approved' and vendor_code=? ", nativeQuery = true)
	int getApproveInvoiceCount(String vendorCode);

	@Query(value = "select count(*) from invoice_generation", nativeQuery = true)
	int getCountForAllInvoices();

	@Query(value = "select count(*) from invoice_generation where invoice_status='Processed'", nativeQuery = true)
	int getCountForAllProcessedInvoice();

	@Query(value = "select count(*) from invoice_generation where invoice_status IN ('In-Review','Pending For Approval', 'Approved','Payment Relase', 'Query') ", nativeQuery = true)
	int getCountForAllInvoice();

	@Query(value = "select count(*) from invoice_generation where invoice_status='In-Review' ", nativeQuery = true)
	int getCountForInReviewInvoice();

	@Query(value = "select count(*) from invoice_generation where invoice_status='Pending For Approval' ", nativeQuery = true)
	int getCountForPendingForApprovalInvoice();

	@Query(value = "select count(*) from invoice_generation where invoice_status='Approved' ", nativeQuery = true)
	int getCountForApprovedInvoice();

	@Query(value = "select count(*) from invoice_generation where invoice_status='Payment Relase' ", nativeQuery = true)
	int getCountForPaymentrelaseInvoice();

	@Query(value = "select count(*) from invoice_generation where invoice_status='Approve'", nativeQuery = true)
	int getCountForAllApproveInvoice();

	@Query(value = "select invoice_number from invoice_generation where vendor_code =:vendorCode and invoice_number=:invoiceNumber ; ", nativeQuery = true)
	String checkForExistingInvoiceNumber(@Param("vendorCode") String vendorCode,
			@Param("invoiceNumber") String invoiceNumber);

	@Query(value = "select * from invoice_generation where invoice_status ='Pending For Approval' ORDER by id desc limit 50; ", nativeQuery = true)
	List<InvoiceGenerationEntity> topFiftyUnProcessedInvoice();

	@Query(value = "select * from invoice_generation where invoice_status ='In-Review' ORDER by id desc limit 50; ", nativeQuery = true)
	List<InvoiceGenerationEntity> topFiftyInProcessedInvoice();

	@Query(value = "select * from invoice_generation where invoice_status IN ('In-Review','Pending For Approval', 'Approved','Payment Relase', 'Query') ", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllInvoiceByFinance();

	@Query(value = "select * from invoice_generation where invoice_status ='Approved' ", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllProcessInvoice();

	@Query(value = "select * from invoice_generation where invoice_status ='Pending For Approval' ", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllUnProcessInvoice();

	@Query(value = "select * from invoice_generation where invoice_status ='Query' And assign_to ='Finance' ", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllQueryInvoice();

	@Query(value = "select count(*) from invoice_generation where invoice_status='Query' And assign_to ='Finance' ", nativeQuery = true)
	int getQueryzInvoice();

	@Query(value = "select * from invoice_generation where invoice_status ='In-Review' ", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllInReviewInvoice();

	@Query(value = "select * from invoice_generation where invoice_status ='Payment Relase' ", nativeQuery = true)
	List<InvoiceGenerationEntity> getPaymentReleaseInvoice();

	@Transactional
	@Modifying
	@Query(value = "update invoice_generation set processed_on=:processedOn , processed_by=:processedBy, invoice_status=:status where ecom_invoice_nunmber=:invoiceNumber ; ", nativeQuery = true)
	void updateInvoiceStatus(@Param("processedOn")String processedOn, @Param("processedBy") String processedBy,@Param("invoiceNumber") String invoiceNumber, @Param("status") String status);

	@Query(value = "select * from invoice_generation where invoice_status ='Query' And assign_to ='Vendor'  and vendor_code=? ", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllQueryInvoiceVendor(String vendorCode);

	@Query(value = "select * from invoice_generation where invoice_status ='Query' And assign_to ='Vendor' ", nativeQuery = true)
	List<InvoiceGenerationEntity> getAllQueryInvoiceVendor();

	List<InvoiceGenerationEntity> findByInvoiceDateBetween(String fromDate, String toDate);

	@Query(value = "SELECT DISTINCT vendor_code FROM invoice_generation order by vendor_code asc ; ", nativeQuery = true)
	List<String> getDistnictVendorList();

	@Query(value = "select * from invoice_generation where invoice_status IN ('In-Review','Pending For Approval', 'Approved','Payment Relase', 'Query') and vendor_code=? ;", nativeQuery = true)
	List<InvoiceGenerationEntity> getInvoiceFiltersByVendorcode(String vendorCode);

	@Query(value = "select * from invoice_generation where  vendor_code=? and invoice_status=? ", nativeQuery = true)
	List<InvoiceGenerationEntity> getInvoiceFiltersByVendorcode(String vendorCode, String invoiceStatus);

	@Query(value = "select * from invoice_generation where  vendor_code=? and ecom_invoice_nunmber=? ", nativeQuery = true)
	InvoiceGenerationEntity getQueryInvoice(String vendorCode, String invoiceNumber);

	@Query(value = "select * from invoice_generation where ecom_invoice_nunmber=? ", nativeQuery = true)
	InvoiceGenerationEntity getQueryInvoice(String invoiceNumber);

	@Query(value = "select ecom_invoice_nunmber, invoice_receiving_date, invoice_number, invoice_amount,invoice_status \r\n"
			+ "FROM invoice_generation where vendor_code=? and invoice_status IN ('In-Review','Pending For Approval', 'Approved','Payment Relase', 'Query') "
			+ "ORDER BY id desc limit ?",nativeQuery = true) 
	List<Object[]> getTopInvoiceRecords(String vendorCode, int parseInt);

	/*
	 * @Transactional
	 * 
	 * @Modifying
	 * 
	 * @Query(value =
	 * "update invoice_generation set assign_to=:assignTo, invoice_status=:invoiceStatus, invoice_amount=:invoiceAmount, taxable_amount=:taxableAmount where id=:idByinvocienumber ; "
	 * , nativeQuery = true) void updateInvoiceStatusAndAssingTo(String assignTo,
	 * String invoiceStatus, String invoiceAmount, String taxableAmount, Long
	 * idByinvocienumber);
	 */

}
