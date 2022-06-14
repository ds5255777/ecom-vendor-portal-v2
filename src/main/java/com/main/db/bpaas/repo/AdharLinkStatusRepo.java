package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.main.db.bpaas.entity.AdharLinkStatus;

public interface AdharLinkStatusRepo extends  JpaRepository<AdharLinkStatus,Integer>{

	@Query(value = "select status from adhar_link_status ",nativeQuery = true)
	List<String> getAdharLinkStatus();
}
