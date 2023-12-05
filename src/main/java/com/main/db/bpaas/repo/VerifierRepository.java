package com.main.db.bpaas.repo;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.main.db.bpaas.entity.Verifier;

public interface VerifierRepository extends JpaRepository<Verifier, Long> {

	List<Verifier> findByStatus(@Param("status") String status);

	Optional<Verifier> findByVerifierNameAndStatus(String verifierName, String activeStatus);

	Optional<Verifier> findByVerifierName(String verifierName);

	List<Verifier> findByStatusOrderByIdDesc(String activeStatus);

	Optional<Verifier> findByIdAndStatus(Long id, String activeStatus);

	List<Verifier> findByRegionId(Integer regionId);

	List<Verifier> findByRegionNameIn(List<String> regionList);

	List<Verifier> findByRegionIdIn(List<Integer> regionId);

	

	

}
