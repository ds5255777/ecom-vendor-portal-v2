package com.main.db.bpaas.repo;

import java.util.List;
import java.util.Optional;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.main.db.bpaas.entity.Region;


public interface RegionRepository extends JpaRepository<Region, Integer> {
	

	List<Region> findByStatus(String activeStatus);

	Optional<Region> findByRegionNameAndStatus(String regionName, String activeStatus);

	
	@Query(value = "SELECT region_Name FROM region where status = '1' ; ", nativeQuery = true)
	List<String> getRegion();

	List<Region> findByStatusOrderByIdDesc(String activeStatus);
	
	

	/*
	 * @Query(value = "SELECT * FROM region WHERE status = :status", nativeQuery =
	 * true) List<Region> findByStatus(@Param("status") String status);
	 */
	
	

}
