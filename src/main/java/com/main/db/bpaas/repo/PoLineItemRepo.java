package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.main.db.bpaas.entity.PoLineDetails;

public interface PoLineItemRepo extends JpaRepository<PoLineDetails, Long > {

	@Query(value="select * from poline_details where line_number=:lineNumber ; ", nativeQuery=true)
	List<PoLineDetails> getDataByLineNumber(@Param("lineNumber") String lineNumber);

}
