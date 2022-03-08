package com.main.db.bpaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "query_details")
public class QueryEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "raised_on")
	private Date raisedOn;

	@Column(name = "raised_by")
	private String raisedBy;// Vendor Code

	@Column(name = "comment")
	private String comment;

	@Column(name = "raised_again_query")
	private String raisedAgainQuery;
	
	/*@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name="trip_ID")*/
	//private TripDetails tripDetails;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getRaisedOn() {
		return raisedOn;
	}

	public void setRaisedOn(Date raisedOn) {
		this.raisedOn = raisedOn;
	}

	public String getRaisedBy() {
		return raisedBy;
	}

	public void setRaisedBy(String raisedBy) {
		this.raisedBy = raisedBy;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getRaisedAgainQuery() {
		return raisedAgainQuery;
	}

	public void setRaisedAgainQuery(String raisedAgainQuery) {
		this.raisedAgainQuery = raisedAgainQuery;
	}

}
