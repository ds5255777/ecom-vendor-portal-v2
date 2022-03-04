package com.main.db.bpaas.repo;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.main.db.bpaas.entity.EmailConfiguration;



public interface EmailConfigurationRepository extends JpaRepository<EmailConfiguration, Integer>{

	List<EmailConfiguration> findByIsActive(String isActive);

	@Transactional
	@Modifying
	@Query(value="update email_configuration set is_active=:isActive where id=:id ; ", nativeQuery=true )
	void updateEmailConfigurationSatatusByid(@Param("isActive") String isActive, @Param("id") Integer id);

	

	

	
	
}
