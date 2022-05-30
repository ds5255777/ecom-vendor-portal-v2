package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.SendEmail;

@Repository
public interface SendEmailRepo extends JpaRepository<SendEmail, Integer> {


	List<SendEmail> findByStatus(String string);

	void updateStatus(String setStatus);


}
