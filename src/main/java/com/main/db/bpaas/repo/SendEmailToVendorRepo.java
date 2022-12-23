package com.main.db.bpaas.repo;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.SendEmailToVendor;

@Repository
public interface SendEmailToVendorRepo extends JpaRepository<SendEmailToVendor, Integer> {

	@Query(value = "select send_email_vendor.id, send_email_vendor.vendor_email, send_email_vendor.vendor_type, send_email_vendor.region, send_email_vendor.creditterms,\r\n"
			+ "send_email_vendor.vendor_pid,sup.bp_code,sup.ven_status,send_email_vendor.process_on\r\n"
			+ "from supdetails sup Right join send_email_vendor\r\n"
			+ "on sup.pid = send_email_vendor.vendor_pid where send_email_vendor.process_by=:processBy ORDER BY id desc ;", nativeQuery = true)
	List<Object[]> findByProcessBy(String processBy);
	
	@Query(value = "select process_on from send_email_vendor where flag=?", nativeQuery = true)
	String processOn(Integer flag);

	SendEmailToVendor findByFlag(Integer commercialFlag);

	@Transactional
	@Modifying
	@Query(value = "update send_email_vendor set vendor_pid=:processID where flag=:flag ;", nativeQuery = true)
	void updateVendorDetails(@Param("flag")Integer flag, @Param("processID")String processID);

}
