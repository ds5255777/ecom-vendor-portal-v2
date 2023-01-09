package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.main.db.bpaas.entity.Document;

public interface DocumentRepo extends JpaRepository<Document, Integer> {

	List<Document> findByTypeAndForeignKeyOrderByIdDesc(String type, String foreignKey);
	
	List<Document> findByForeignKeyAndType(String pid, String setTypeRegistration);


}
