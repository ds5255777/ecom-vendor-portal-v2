package com.main.db.bpaas.repo;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.main.db.bpaas.entity.QueryEntity;

public interface QueryRepo extends JpaRepository<QueryEntity, Integer> {

	@Transactional
	@Modifying
	@Query(value = "update trip_details set processed_on=:date,processed_by=:userName, vendor_trip_status=:status, assign_to=:assign where id=:id ; ", nativeQuery = true)
	void updateStatusByUserid( @Param("date") String date,@Param("userName") String userName, @Param("status") String status,@Param("assign") String assign, @Param("id") Integer id);

	@Query(value = "SELECT * FROM query_details where reference_id=? ORDER BY id DESC;", nativeQuery = true)
	List<QueryEntity> findCommentsByRefID(String reference_id);
	
	@Transactional
	@Modifying
	@Query(value = "update invoice_generation set processed_on=:date,processed_by=:userName, invoice_status=:status, assign_to=:assign where id=:id ; ", nativeQuery = true)
	void updateInvoiceStatus( @Param("date") String date,@Param("userName") String userName,  @Param("status") String status,@Param("assign") String assign, @Param("id") Integer id);

	@Query(value = "SELECT * FROM query_details where reference_id=? ORDER BY id DESC ;", nativeQuery = true)
	List<QueryEntity> findByReferenceId(String invoiceNumber);

	List<QueryEntity> findByReferenceidAndTypeOrderByIdDesc(String referenceid, String type);
	
	@Query(value = "SELECT * FROM query_details where reference_id=? and raised_By=? ;", nativeQuery = true)
	List<QueryEntity> findCommentsByRefIDPo(String reference_id ,String raisedBy);


}
