package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.MailContent;
@Repository
public interface MailContentRepo extends JpaRepository<MailContent, Integer> {

	List<MailContent> findByType(String type);
	

}
