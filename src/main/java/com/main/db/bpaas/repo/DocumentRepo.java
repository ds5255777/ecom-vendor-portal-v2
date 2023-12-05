package com.main.db.bpaas.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.main.db.bpaas.entity.Document;

public interface DocumentRepo extends JpaRepository<Document, Integer> {

	List<Document> findByTypeAndForeignKeyOrderByIdDesc(String type, String foreignKey);

	List<Document> findByForeignKeyAndType(String pid, String setTypeRegistration);

//	List<Document> findDistinctTypeByForeignKeyAndTypeInAndStatus(String foreignKey, List<String> doctypeList,
//			String activeStatus);

	List<Document> findDistinctTypeByForeignKeyAndType(String foreignKey, String type);

	@Query(value = "select type from document where type in :doctypeList and\r\n"
			+ "foreign_key=:foreignKey and status=:activeStatus group by type ;\r\n"
			+ "", nativeQuery = true)
	List<Object[]> getAllTypeDetailsList(@Param("foreignKey") String foreignKey,
			@Param("doctypeList") List<String> doctypeList, @Param("activeStatus") String activeStatus);

	List<Document> findByTypeInAndForeignKey(List<String> doctypeList, String foreignKey);




}
