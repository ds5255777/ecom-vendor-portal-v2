package com.main.payloads;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QueryDto {

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
