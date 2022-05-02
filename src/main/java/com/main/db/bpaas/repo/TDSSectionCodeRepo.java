package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


import com.main.db.bpaas.entity.TDSSectionCode;

@Repository
public interface TDSSectionCodeRepo extends JpaRepository<TDSSectionCode, Integer>{
	
	@Query(value = "select code from tds_section_code ",nativeQuery = true)
	List<String> getTDSSectionCode();

}
