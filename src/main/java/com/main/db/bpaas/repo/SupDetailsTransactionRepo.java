package com.main.db.bpaas.repo;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.SupDetailsTransaction;

@Repository
public interface SupDetailsTransactionRepo extends JpaRepository<SupDetailsTransaction, Long> {

	Integer countByVenStatus(String updatingRequestStatus);

	@Query(value = "select pid,  supp_name,vendor_type, create_date from Sup_Details_Transaction where ven_status=:updatingRequestStatus Order By id Desc", nativeQuery = true)
	List<Object[]> findByVenStatus(String updatingRequestStatus);

	SupDetailsTransaction findByPidAndVenStatus(String pid, String updatingRequestStatus);

	SupDetailsTransaction findByBpCodeAndVenStatus(String bpCode, String updatingRequestStatus);

	@Transactional
	@Modifying
	@Query(value = "update sup_details_transaction set ven_status=:approvedRequestStatus,bp_code=:vendorCode,processed_by=:userEmail,processed_on=:strDate where pid=:pid ; ", nativeQuery = true)
	void approveRequestByPid(@Param("vendorCode") String vendorCode, 
							@Param("pid") String pid,
							@Param("userEmail") String userEmail,
							@Param("strDate") String strDate,
							@Param("approvedRequestStatus") String approvedRequestStatus);

}