package com.main.db.bpaas.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.main.db.bpaas.entity.QueryEntity;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Modifying;

public interface QueryRepo extends JpaRepository<QueryEntity, Integer> {

	@Transactional
	@Modifying
	@Query(value = "update trip_details set vendor_trip_status=:status, assign_to=:assign where id=:id ; ", nativeQuery = true)
	void updateStatusByUserid(@Param("status") String status,@Param("assign") String assign, @Param("id") Integer id);

	@Query(value = "SELECT * FROM query_details where reference_id=?;", nativeQuery = true)
	List<QueryEntity> findCommentsByRefID(String reference_id);
	
	@Transactional
	@Modifying
	@Query(value = "update invoice_generation set invoice_status=:status, assign_to=:assign where id=:id ; ", nativeQuery = true)
	void updateInvoiceStatus(@Param("status") String status,@Param("assign") String assign, @Param("id") Integer id);

	@Query(value = "SELECT * FROM query_details where reference_id=?;", nativeQuery = true)
	List<QueryEntity> findByReferenceId(String invoiceNumber);

	List<QueryEntity> findByReferenceidAndTypeOrderByIdDesc(String referenceid, String type);

}
