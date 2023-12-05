package com.main.payloads;

import java.util.Date;



import lombok.Data;

@Data
public class CommentHistoryDTO {

	private Integer id;
	
	private String createdBy;
	
	private Date createdOn;
	
	private String remark;
	
	private String vendorPid;
	
	private Integer roleId;
	
	private String roleName;
	
	
	
}
