package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.BusinessPartnerType;


@Repository
public interface BusinessPartnerTypeRepo extends JpaRepository<BusinessPartnerType, Integer>{
	
	@Query(value = "select name from business_partner_type ",nativeQuery = true)
	List<String> getBusinessPartnerType();

}
