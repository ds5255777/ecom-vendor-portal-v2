package com.main.db.bpaas.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.main.db.bpaas.entity.QueryEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface QueryRepo extends JpaRepository<QueryEntity, Integer>  {


  @Query(value = "SELECT id, comment, raised_again_query, raised_by, raised_on, reference_id, trip_query_fk FROM query_details where reference_id=?;", nativeQuery = true)
    List<QueryEntity> findCommentsByRefID(String reference_id);

}
