package com.main.db.bpaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;

@Entity
@Data
public class Document {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "doc_name", columnDefinition = "TEXT")
	private String docName;

	@Column(name = "doc_path", length = 1000)
	private String docPath;

	@Column(name = "created_date")
	private Date createdDate = new Date();

	private String type;

	private String status;

	@Column(name = "foreign_key")
	private String foreignKey;

}
