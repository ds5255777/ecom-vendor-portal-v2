package com.main.payloads;

import lombok.Data;

@Data
public class AccountDetailsDTO {
	
	private Integer id;
	private String bankName;
	private String beneficiaryName;
	private String ifscCode;
	private String accoutCurrency;
	private String accoutNumber;

}
