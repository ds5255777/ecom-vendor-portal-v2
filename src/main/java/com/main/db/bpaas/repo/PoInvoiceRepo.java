package com.main.db.bpaas.repo;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.PoDetails;
import com.main.db.bpaas.entity.PoInvoiceDetails;

@Repository
public interface PoInvoiceRepo extends JpaRepository<PoInvoiceDetails, Long> {

	@Query(value = "select count(*) from poinvoice_details where  status in('In-Review','Query') and vendor_code=?", nativeQuery = true)
	int getAllInvoiceCount(String vendorCode);

	@Query(value = "select * from poinvoice_details where status in('In-Review','Query')  and vendor_code=:vendorCode", nativeQuery = true)
	List<PoInvoiceDetails> getAllInvoiceDetails( @Param("vendorCode") String vendorCode);
	
	@Query(value = "select * from poinvoice_details where status in('In-Review','Query')  ", nativeQuery = true)
	List<PoInvoiceDetails> getAllInvoiceDetailsForFinance( );

	@Query(value = "select * from poinvoice_details where  vendor_code=:vendorCode and invoice_num=:invoiceNumber", nativeQuery = true)
	List<PoInvoiceDetails> findByInvoiceNumber(@Param("vendorCode") String vendorCode , @Param("invoiceNumber")  String invoiceNumber);
	
	@Query(value = "select * from poinvoice_details where  invoice_num=:invoiceNumber", nativeQuery = true)
	List<PoInvoiceDetails> findByInvoiceNumberByFinance(@Param("invoiceNumber")  String invoiceNumber);

	@Query(value = "select * from poinvoice_details where vendor_code=? and Invoice_Num=?", nativeQuery = true)
	List<PoInvoiceDetails> getAllDraftPODetailsByInvoiceNo(String vendorCode , String invoiceNo);
	
	@Transactional
	@Modifying
	@Query(value = "delete from poinvoice_details where Invoice_Num=?", nativeQuery = true)
	void deleteByInvoiceNumber(String invoiceNumber);

	@Query(value = "select id from poinvoice_details where invoice_num=?", nativeQuery = true)
	Long getId(String ecomInvoiceNumber);

	@Query(value = "select count(*) from po_details where vendor_code=?", nativeQuery = true)
	int getAllPOcount(String vendorCode);
	
	@Query(value = "select count(*) from poinvoice_details where status='Draft-Invoicing' and  vendor_code=?", nativeQuery = true)
	int getTotalDraftInvoiceCount(String vendorCode);
	
	 @Query(value = "select * from poinvoice_details where status ='Query' And assign_to ='Vendor'  and vendor_code=? ", nativeQuery = true)
	List<PoInvoiceDetails> getAllQueryInvoiceVendorPo(String vendorCode);

	 @Query(value = "select count(*) from poinvoice_details where  vendor_code=?", nativeQuery = true)
		int getAllInvoiceCountForInvoiceNo(String vendorCode);
	 
	 @Query(value = "select * from poinvoice_details where status='Draft-Invoicing' and vendor_code=?" , nativeQuery = true)
	List<PoInvoiceDetails> getAllDraftPoInvoice(String vendorCode);

	 @Query(value = "select invoice_num from poinvoice_details " , nativeQuery = true)
	List<String> getExitingInvoiceNo();

}
