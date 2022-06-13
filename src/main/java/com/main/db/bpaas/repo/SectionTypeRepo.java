package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.main.db.bpaas.entity.SectionType;

public interface SectionTypeRepo extends JpaRepository<SectionType, Integer> {

	@Query(value = "select type from section_type ",nativeQuery = true)
	List<String> getSectionType();

}
