package com.main.payloads;

import java.util.Date;

import lombok.Data;

@Data
public class QueryEntityDTO {
	
	private Integer id;
	private Date raisedOn;
	private String referenceid;
	private String raisedBy;// Vendor Code
	private String comment;
	private String raisedAgainQuery;
	private String role;
	private Integer foreignKey;
	private String type;


}
