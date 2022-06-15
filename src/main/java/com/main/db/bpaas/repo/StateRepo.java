package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


import com.main.db.bpaas.entity.State;
@Repository
public interface StateRepo extends JpaRepository<State, Integer>{

	@Query(value = "select state_name from state order by state_name asc",nativeQuery = true)
	List<String> getStateName();

}
