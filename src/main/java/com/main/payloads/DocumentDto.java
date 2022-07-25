package com.main.payloads;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DocumentDto {

	private Integer id;
	private String docName;
	private String docPath;
	private Date createdDate = new Date();
	private String type;
	private String status;
	private String foreignKey;

}
