package com.main.db.bpaas.repo;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.InvoiceLineItem;

@Repository
public interface InvoiceLineItemRepo extends JpaRepository<InvoiceLineItem, Long> {

	@Transactional
    @Modifying
    @Query(value = "DELETE FROM invoice_line_item WHERE trip_id=:tripID ; ", nativeQuery = true)
    void updateTrip(@Param("tripID") String tripID);
	
}
