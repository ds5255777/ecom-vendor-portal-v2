package com.main.db.bpaas.repo;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.main.db.bpaas.entity.Flag;

public interface FlagRepo extends JpaRepository<Flag, Integer> {

	@Query(value="select flag_name from flag" , nativeQuery = true)
	List<String> getFlag();
	

}
