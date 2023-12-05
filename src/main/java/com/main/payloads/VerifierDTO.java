package com.main.payloads;

import lombok.Data;

@Data
public class VerifierDTO {
	
	private Long id;
	private String verifierName;
	private String emailId;
	private String status;
	 private Integer regionId; 
	private String regionName;
}
