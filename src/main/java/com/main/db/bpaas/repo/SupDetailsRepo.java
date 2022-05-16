package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.SupDetails;

@Repository
public interface SupDetailsRepo extends JpaRepository<SupDetails, Long> {
	
//	@Query(value="update SupDetails set ven_status=:ven_status where id=:id ; ", nativeQuery=true)
//	void updateStatusBySupDetailsid(@Param("ven_status") String ven_status, @Param("id") Long id);

	@Query(value = "select  supp_name from sup_details", nativeQuery = true)
	SupDetails findByName();

	@Query(value = "select comp_email from sup_details", nativeQuery = true)
	List<String> checkEmail();
	
	@Query(value = "select pid from sup_details", nativeQuery = true)
	List<String> findByPid();
	@Query(value="select * from SupDetails  ", nativeQuery=true)
	List<SupDetails> getAllInActiveVendor();
	
	@Query(value="select * from SupDetails where bp_code=:bpCode  ", nativeQuery=true)
	List<SupDetails> findByVendorCode(String bpCode);
	
	@Query(value="select vendor_type from SupDetails where bp_code=:bpCode  ", nativeQuery=true)
	String findVendorType(String bpCode);

															 
}
