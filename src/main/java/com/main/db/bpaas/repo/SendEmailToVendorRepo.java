package com.main.db.bpaas.repo;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.SendEmailToVendor;

@Repository
public interface SendEmailToVendorRepo extends JpaRepository<SendEmailToVendor, Integer> {

	@Query(value = "select * from send_email_vendor where process_by=?", nativeQuery = true)
	List<SendEmailToVendor> findByProcessBy(String processBy);
	
	@Query(value = "select process_on from send_email_vendor where flag=?", nativeQuery = true)
	String processOn(Integer flag);

}
