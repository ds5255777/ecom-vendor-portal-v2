package com.main.db.bpaas.repo;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.SendEmail;

@Repository
public interface SendEmailRepo extends JpaRepository<SendEmail, Integer> {

	List<SendEmail> findByStatus(String string);

	@Transactional
	@Modifying
	@Query(value = "update send_email set status=:status where id=:id ; ", nativeQuery = true)
	void updateStatus(String status,Integer id);

}
