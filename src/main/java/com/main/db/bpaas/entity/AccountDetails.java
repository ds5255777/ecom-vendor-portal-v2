package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "AccountDetails")
public class AccountDetails {
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
