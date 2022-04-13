package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;



import com.main.db.bpaas.entity.PoInvoiceDetails;


@Repository
public interface PoInvoiceRepo extends JpaRepository<PoInvoiceDetails, Long>{

	@Query(value = "select count(*) from poinvoice_details where vendor_code=?", nativeQuery = true)
	int getAllInvoiceCount(String vendorCode);
	
	List<PoInvoiceDetails> findByVendorCode(String vendorCode);
	

	List<PoInvoiceDetails> findByInvoiceNumber(String invoiceAmount);
	
	
	 
	
}
