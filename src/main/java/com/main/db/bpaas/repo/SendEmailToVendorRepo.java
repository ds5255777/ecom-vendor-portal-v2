package com.main.db.bpaas.repo;

import java.util.Date;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

//import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.SendEmailToVendor;

@Repository
public interface SendEmailToVendorRepo extends JpaRepository<SendEmailToVendor, Integer> {

	@Query(value = "select send_email_vendor.id, send_email_vendor.vendor_email, send_email_vendor.vendor_type, send_email_vendor.region, send_email_vendor.creditterms,"
			+ "send_email_vendor.comments,send_email_vendor.ehs_verification,send_email_vendor.third_party_verification,\r\n"
			+ "send_email_vendor.vendor_pid,sup.bp_code,sup.ven_status,send_email_vendor.process_on\r\n"
			+ "from supdetails sup Right join send_email_vendor\r\n"
			+ "on sup.pid = send_email_vendor.vendor_pid where send_email_vendor.process_by=:processBy ORDER BY id desc ;", nativeQuery = true)
	List<Object[]> findByProcessBy(String processBy);

	@Query(value = "select process_on from send_email_vendor where flag=?", nativeQuery = true)
	String processOn(Integer flag);

	@Transactional
	@Modifying
	@Query(value = "update send_email_vendor set vendor_pid=:processID where flag=:flag ;", nativeQuery = true)
	void updateVendorDetails(@Param("flag") Integer flag, @Param("processID") String processID);

	SendEmailToVendor findByFlag(Integer flag);

	List<SendEmailToVendor> findByFlagIn(List<Integer> flags);

	List<SendEmailToVendor> findByVendorTypeLikeAndRegionLikeAndCreditTermsLike(String vendorTypes, String regions,
			String creditTerms);

//	List<SendEmailToVendor> findByVendorTypeInAndRegionInAndCreditTermsIn(List<String> vendorTypes,
//			List<String> regions, List<String> creditTerms);

//	List<SendEmailToVendor> findByVendorTypeInOrRegionInOrCreditTermsIn(List<String> vendorTypes, List<String> regions,
//			List<String> creditTerms);

	List<SendEmailToVendor> findByVendorTypeInOrRegionInOrCreditTermsInOrVerifierName(List<String> vendorTypes,
			List<String> regions, List<String> creditTerms, String verifierName);

	@Transactional
	@Modifying
	@Query(value = "update send_email_vendor set vendor_pid=:processID where id=:id ;", nativeQuery = true)
	void vendorIdGenerate(@Param("id") Integer id, @Param("processID") String processID);
//	void vendorIdGenerate(Integer id, String processID);

//	@Query(value = "select id,verifier_name,process_on,vendor_key,region,status,flag,process_by,link_expiration_date,vendor_email,ehs_verification,creditTerms,comments_of_commercial_head,vendor_type,third_party_verification,comments,comm_his_id from send_email_vendor where status =:activeStatus", nativeQuery = true)
//	List<SendEmailToVendor> getlistDetails(@Param("activeStatus")String activeStatus);
//	
	@Transactional
	@Modifying
	@Query(value = "update send_email_vendor set comm_his_id=:commentId where id=:id ;", nativeQuery = true)
	void vendorCommentId(@Param("id") Integer id, @Param("commentId") Integer commentId);
//

	List<SendEmailToVendor> findByStatus(String activeStatus);

	@Query(value = "select * from send_email_vendor where send_email_vendor.vendor_pid=:vpid ;", nativeQuery = true)
	Optional<SendEmailToVendor> getVpidDetails(String vpid);

	@Query(value = "select * from send_email_vendor where send_email_vendor.vendor_pid=:vendorPid ;", nativeQuery = true)
	Optional<SendEmailToVendor> getByVendorPid(String vendorPid);
//	@Query(value = "update send_email_vendor set status=:raiseQuery  where vendor_pid=:vendorPid ;", nativeQuery = true)
//	SendEmailToVendor upDateStatus( @Param("raiseQuery") String raiseQuery, @Param("vendorPid") String vendorPid);
//	

	// Optional<SendEmailToVendor> findByVendorPidIn(String vendorPid);

	Optional<SendEmailToVendor> findByVendorPid(String vendorPid);

	List<SendEmailToVendor> findByVendorTypeInOrRegionInOrCreditTermsInOrVerifierNameOrStatusOrderByIdDesc(
			List<String> vendorTypes, List<String> regions, List<String> creditTerms, String verifierName,
			String status);

	Optional<SendEmailToVendor> findByVendorPid(Long id);

//	List<SendEmailToVendor> findAllByOrderByIdDesc();

	List<SendEmailToVendor> findByStatusInOrderByIdDesc(List<String> statusOfVendor);

	List<SendEmailToVendor> findByStatusOrderByIdDesc(String pendingAtVerifier);

//	@Modifying	
//	@Query(value = "update send_email_vendor set status=:approvedRequestStatus where send_email_vendor.vendor_pid=:pid ;", nativeQuery = true)
//	void statusUpdateInSendMailVendor(@Param("pid") String pid,
//			@Param("approvedRequestStatus") String approvedRequestStatus);

	Optional<SendEmailToVendor> findByVendorPidAndStatus(String pid, String pendingRequestStatus);

	List<SendEmailToVendor> findByCommercialHeadAndStatusOrderByIdDesc(String username, String status);

	List<SendEmailToVendor> findByStatusInAndAssignAtOrderByIdDesc(List<String> statusOfVendor, String username);

	/*
	 * List<SendEmailToVendor> findByUsernameAndStatusOrderByIdDesc(String username,
	 * String status);
	 * 
	 * List<SendEmailToVendor> findByProcessByAndStatusOrderByIdDesc(String
	 * username, String status);
	 */


	// void statusUpdateInSendMailVendor(@Param("pid") String pid);

//	Optional<SendEmailToVendor> findByVendorPidIn(String vendorPid);

	// List<SendEmailToVendor> search(List<String> vendorTypes, List<String>
	// regions, String creditTerms);
//	
//	@Query(value = "SELECT * FROM SendEmailToVendor WHERE LIKE % vendorType =:vendorTypes % and regions=:regions", nativeQuery = true)
//    List<SendEmailToVendor> searchVendors(
//            @Param("vendorTypes") List<String> vendorTypes,
//            @Param("regions") List<String> regions,
//            @Param("creditTerms") String creditTerms
//    );

	// List<SendEmailToVendor> findByStatusOrderByIdDesc(String activeStatus);

}
