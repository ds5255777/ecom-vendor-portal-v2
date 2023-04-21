package com.main.payloads;

import lombok.Data;

@Data
public class ContactDetailsTransactionDTO {
	
	private Long id;
	private String conFname;
	private String conLname;
	private String conPhone;
	private String conEmail;

}
