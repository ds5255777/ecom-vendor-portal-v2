package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.main.db.bpaas.entity.RolesEntity;

public interface RolesRepository extends JpaRepository<RolesEntity, Integer>{

	List<RolesEntity> findByIsActive(String status);

	
	@Query(value="select * from roles where is_active =:isactive and role_name in ('HR','Site User')",nativeQuery=true)
	List<RolesEntity> findByIsActiveAndRoleName(String isactive);

	@Query(value="select id from roles where role_name=:role",nativeQuery=true)
	Integer findByRoleName(String role);

}
