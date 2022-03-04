package com.main.db.bpaas.repo;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.WIHistory;

@Repository
public interface WIHistoryRepo extends JpaRepository<WIHistory, Long> {

	List<WIHistory> findComHis(Long wiId);
}
