package com.main.db.bpaas.repo;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.WFDetails;

@Repository
public interface WFDetailsRepo extends JpaRepository<WFDetails, Long> {

	List<WFDetails> findUserPending(String userName);

	List<WFDetails> findByStatusAndAssignedTo(String string, String userName);

}
