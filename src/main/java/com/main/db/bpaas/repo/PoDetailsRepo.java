package com.main.db.bpaas.repo;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.PoDetails;

@Repository
public interface PoDetailsRepo extends JpaRepository<PoDetails, Long> {

	PoDetails findByPoNo(String poNo);

	@Query(value = "select * from po_details where status='In-Review'", nativeQuery = true)
	List<PoDetails> getAllProcessPo(String vendorCode);

	@Query(value = "select * from po_details where status='Unprocess' and vendor_code=?", nativeQuery = true)
	List<PoDetails> getAllUnProcessPo(String vendorCode);

	@Query(value = "select count(*) from po_details where status='In-Review' and vendor_code=?", nativeQuery = true)
	int getAllProcessPoCount(String vendorCode);

	@Query(value = "select count(*) from po_details where status='Unprocess' and vendor_code=?", nativeQuery = true)
	int getAllUnProcessPoCount(String vendorCode);

	@Query(value = "select count(*) from poinvoice_details where status='Query' and vendor_code=:vendorCode", nativeQuery = true)
	int getAllQueryCount(String vendorCode);

	@Query(value = "select * from po_details where po_number=? and vendor_code=?", nativeQuery = true)
	List<PoDetails> getPoDetailsByPoNo(String poNo, String vendorCode);

	@Query(value = "select  * from Po_Details WHERE  1=1 AND need_by_date BETWEEN (:startDate) AND (:endDate) ; ", nativeQuery = true)
	List<PoDetails> findByActualDepartureBetween(@Param("startDate") String startDate,
			@Param("endDate") String endDate);

	@Query(value = "select  * from Po_Details WHERE  vendor_code=:vendorCode AND need_by_date BETWEEN (:startDate) AND (:endDate) ; ", nativeQuery = true)
	List<PoDetails> findByActualDepartureBetween(@Param("startDate") String startDate, @Param("endDate") String endDate,
			@Param("vendorCode") String vendorCode);

	@Query(value = "select count(*) from po_details where  vendor_code=?", nativeQuery = true)
	int getAllPoCount(String vendorCode);



	@Transactional
	@Modifying
	@Query(value = "update po_details set status='Unprocess' where invoice_number=:invoiceNumber ", nativeQuery = true)
	void updatePoStatusagainsInvoiceNumber(@Param("invoiceNumber") String invoiceNumber);

	@Transactional
	@Modifying
	@Query(value = "update po_details set status='In-Review' where PO_Number=:poNumber ", nativeQuery = true)
	void updateVendorPoStatusAgainsInvoiceNumber(@Param("poNumber") String poNumber);

	@Transactional
	@Modifying
	@Query(value = "update PoLine_Details set remaning_quatity=:remaningQuatity where  id=:id", nativeQuery = true)
	void updateRemaningQuatity(@Param("remaningQuatity") String remaningQuatity, @Param("id") Long id);

	@Transactional
	@Modifying
	@Query(value = "update po_details set status='Unprocess' where PO_Number=:poNumber ", nativeQuery = true)
	void updateVendorPoStatusUnprocess(@Param("poNumber") String poNumber);

	@Transactional
	@Modifying
	@Query(value = "update PoLine_Details set remaning_quatity=:remaningQuatity where  line_Number=:lineNumber", nativeQuery = true)
	void updateRemaningQuantitydraft(@Param("remaningQuatity") String remaningQuatity,
			@Param("lineNumber") String lineNumber);

	@Query(value = "select  remaning_quatity from PoLine_Details WHERE  line_Number=:lineNumber ; ", nativeQuery = true)
	String getCurrentRemaningQty(@Param("lineNumber") String lineNumber);

}
