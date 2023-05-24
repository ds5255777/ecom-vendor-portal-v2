package com.main.payloads;

import lombok.Data;

@Data
public class AccountDetailsTransactionDTO {
	
	private Integer id;
	private String bankName;
	private String beneficiaryName;
	private String ifscCode;
	private String accoutCurrency;
	private String accoutNumber;

}
