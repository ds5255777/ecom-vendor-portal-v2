package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.BusinessPartnerType;

@Repository
public interface BusinessPartnerRepo extends JpaRepository<BusinessPartnerType, Integer>{

	@Query(value = "select business_partner_name from business_partner ",nativeQuery = true)
	List<String> getBusinessPartner();
}
