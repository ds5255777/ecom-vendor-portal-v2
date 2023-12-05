package com.main.db.bpaas.repo;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.main.db.bpaas.entity.CommentHistory;

public interface CommentHistoryRepo extends JpaRepository<CommentHistory, Integer> {


	List<CommentHistory> findByVendorPidOrderByIdDesc(String vendorPid);

	CommentHistory findByVendorPid(String processID);



}
