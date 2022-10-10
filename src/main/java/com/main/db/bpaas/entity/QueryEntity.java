package com.main.db.bpaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "query_details")
@Data
public class QueryEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "raised_on")
	private Date raisedOn;

	@Column(name = "reference_id")
	private String referenceid;

	@Column(name = "raised_by")
	private String raisedBy;

	@Column(name = "comment", columnDefinition = "TEXT")
	private String comment;

	@Column(name = "raised_again_query")
	private String raisedAgainQuery;

	@Column(name = "role")
	private String role;

	@Column(name = "foreign_key")
	private Integer foreignKey;

	@Column(name = "type")
	private String type;

}
