package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.main.db.bpaas.entity.Region;

public interface RegionRepo extends JpaRepository<Region, Integer>{

	@Query(value = "select region_name from region ",nativeQuery = true)
	List<String> getRegion();

}
