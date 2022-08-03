package com.main.db.bpaas.repo;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.SupDetails;

@Repository
public interface SupDetailsRepo extends JpaRepository<SupDetails, Long> {

	@Query(value = "select  supp_name from sup_details", nativeQuery = true)
	SupDetails findByName();

	@Query(value = "select pan_number from supdetails where pan_number=:panNumber and flag=:flag", nativeQuery = true)
	String checkPanNumber(String panNumber, String flag);

	@Query(value = "select pid from sup_details", nativeQuery = true)
	List<String> findByPid();

	@Query(value = "SELECT supp_name,bp_code,businessclassification, vendor_type, ven_status, supdetails.introduced_by_name, supdetails.introduced_by_email_id, flag FROM supdetails where ven_status in('Approved','Update') ", nativeQuery = true)
	List<Object[]> getAllInActiveVendor();

	@Query(value = "select * from SupDetails where bp_code=:bpCode  ", nativeQuery = true)
	List<SupDetails> findByVendorCode(String bpCode);

	/*
	 * @Query(value = "select * from SupDetails where pid=:pid  ", nativeQuery =
	 * true) List<SupDetails> findBypid(@Param("pid") String pid);
	 */

	@Query(value = "select  username from users where vendor_name=:vendorName and role_id='2' ", nativeQuery = true)
	String getVendorCode(String vendorName);

	@Query(value = "select vendor_type from SupDetails where bp_code=:bpCode  ", nativeQuery = true)
	String findVendorType(String bpCode);

	@Query(value = "select credit_terms from SupDetails where bp_code=:bpCode  ", nativeQuery = true)
	String findCreditTerms(String bpCode);

	@Query(value = "select * from SupDetails where bp_code=:bpCode  ", nativeQuery = true)
	List<SupDetails> findbankAccountNumber(String bpCode);

	@Query(value = "select * from SupDetails ", nativeQuery = true)
	List<SupDetails> allVendorData();

	@Transactional
	@Modifying
	@Query(value = "update SupDetails set pid=:pid where id=:id ; ", nativeQuery = true)
	void updatePidInSupDetails(Long id, String pid);

	@Query(value = "select supdetails.pid, introduced_by_email_id, introduced_by_name, supp_name,vendor_type, ven_status from supdetails where ven_status=:pendingRequestStatus Order By id Desc", nativeQuery = true)
	List<Object[]> findByPendingVenStatus(String pendingRequestStatus);

	SupDetails findByPid(String pid);

	List<SupDetails> findByVenStatus(String approvedRequestStatus);

	Integer countByVenStatus(String status);

	@Transactional
	@Modifying
	@Query(value = "update SupDetails set ven_status=:queryRequestStatus where id=:getid ; ", nativeQuery = true)
	void updateVendorStatus(String queryRequestStatus, Integer getid);

	@Transactional
	@Modifying
	@Query(value = "update SupDetails set ven_status=:approvedRequestStatus where pid=:pid ; ", nativeQuery = true)
	void approveRequestByPid(String pid, String approvedRequestStatus);

	@Transactional
	@Modifying
	@Query(value = "update SupDetails set ven_status=:approvedRequestStatus,bp_code=:vendorCode where pid=:pid ; ", nativeQuery = true)
	void approveRequestByPid(String vendorCode, String pid, String approvedRequestStatus);

	SupDetails findBybpCode(String bpCode);

	@Query(value = "select vendor_type from supdetails where bp_code=:vendorCode", nativeQuery = true)
	String findByVendorType(String vendorCode);

}