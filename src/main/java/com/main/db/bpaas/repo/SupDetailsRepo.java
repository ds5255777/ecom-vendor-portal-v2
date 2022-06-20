package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.AddressDetails;
import com.main.db.bpaas.entity.SupDetails;

@Repository
public interface SupDetailsRepo extends JpaRepository<SupDetails, Long> {


	@Query(value = "select  supp_name from sup_details", nativeQuery = true)
	SupDetails findByName();

	@Query(value = "select comp_email from sup_details", nativeQuery = true)
	List<String> checkEmail();
	
	@Query(value = "select pid from sup_details", nativeQuery = true)
	List<String> findByPid();
	@Query(value="select s.introduced_by_name,s.supp_name,s.comp_email,s.introduced_by_email_id,s.comp_gstn,\r\n"
			+ "s.nature_of_transactions,s.partner_type,s.vendor_type,s.phone_number, u.status, s.bp_code\r\n"
			+ "from supdetails s, users u where s.bp_code=u.bp_code and u.role_id='2' ", nativeQuery=true)
	List<Object[]> getAllInActiveVendor();
	
	@Query(value="select * from SupDetails where bp_code=:bpCode  ", nativeQuery=true)
	List<SupDetails> findByVendorCode(String bpCode);
	
	@Query(value="select * from SupDetails where pid=:pid  ", nativeQuery=true)
	List<SupDetails> findBypid(@Param("pid")String pid);

	 @Query(value ="select  username from users where vendor_name=:vendorName and role_id='2' ",nativeQuery = true)
	  String getVendorCode(String vendorName);

	@Query(value="select vendor_type from SupDetails where bp_code=:bpCode  ", nativeQuery=true)
	String findVendorType(String bpCode);
	
	@Query(value="select credit_terms from SupDetails where bp_code=:bpCode  ", nativeQuery=true)
	String findCreditTerms(String bpCode);

	@Query(value="select * from SupDetails where bp_code=:bpCode  ", nativeQuery=true)
	List<SupDetails> findbankAccountNumber(String bpCode);

	@Query(value="select * from SupDetails ", nativeQuery=true)
	List<SupDetails> allVendorData();

}
