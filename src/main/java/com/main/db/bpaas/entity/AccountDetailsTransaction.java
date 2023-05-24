package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "Account_Details_Transaction")
public class AccountDetailsTransaction {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "bank_name")
	private String bankName;

	@Column(name = "beneficiary_name")
	private String beneficiaryName;
	@Column(name = "ifsc_code")
	private String ifscCode;
	@Column(name = "accout_currency")
	private String accoutCurrency;
	@Column(name = "accout_number")
	private String accoutNumber;

}
