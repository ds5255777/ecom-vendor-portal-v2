package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "onboard_query")
public class OnboardQuery {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "reg_id")
	private Integer regId;

	@Column(name = "query")
	private String query;

	@Column(name = "remarks", columnDefinition = "TEXT")
	private String remarks;

	@JsonIgnore
	@ManyToOne
	@JoinColumn
	private SupDetails supDetails;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getRegId() {
		return regId;
	}

	public void setRegId(Integer regId) {
		this.regId = regId;
	}

	public String getQuery() {
		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public SupDetails getSupDetails() {
		return supDetails;
	}

	public void setSupDetails(SupDetails supDetails) {
		this.supDetails = supDetails;
	}

}
