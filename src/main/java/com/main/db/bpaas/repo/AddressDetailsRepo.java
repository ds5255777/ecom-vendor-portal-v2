package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.AddressDetails;

@Repository
public interface AddressDetailsRepo extends JpaRepository<AddressDetails, Long> {
	
	@Query(value="select * from addressdetails ad where addressdetails_id in (select id from supdetails where supp_name=:vendorName) ;  ", nativeQuery = true)
	List<AddressDetails>  getVendorAddress(String vendorName);

}
