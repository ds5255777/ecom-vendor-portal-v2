package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


import com.main.db.bpaas.entity.PoDetails;


@Repository
public interface PoDetailsRepo extends JpaRepository<PoDetails, Long>{

	
	PoDetails findByPoNo(String poNo);
	
	@Query(value = "select * from po_details where status='Process'", nativeQuery = true)
	List<PoDetails> getAllProcessPo(String vendorCode);
	
	@Query(value = "select * from po_details where status='Unprocess' and vendor_code=?" , nativeQuery = true)
	List<PoDetails> getAllUnProcessPo(String vendorCode);
	
	@Query(value = "select count(*) from po_details where status='Process' and vendor_code=?", nativeQuery = true)
	int getAllProcessPoCount(String vendorCode);
	
	@Query(value = "select count(*) from po_details where status='Unprocess' and vendor_code=?", nativeQuery = true)
	int getAllUnProcessPoCount(String vendorCode);
	
	@Query(value = "select count(*) from query_details where reference_id=:vendorCode", nativeQuery = true)
	int getAllQueryCount(String vendorCode);
	
	
	
}
