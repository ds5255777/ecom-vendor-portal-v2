package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "tds_section_code")
public class TDSSectionCode {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "code")
	private String code;
	
	@Column(name = "lookup_code_meaning")
	private String lookupCodeMeaning;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getLookupCodeMeaning() {
		return lookupCodeMeaning;
	}

	public void setLookupCodeMeaning(String lookupCodeMeaning) {
		this.lookupCodeMeaning = lookupCodeMeaning;
	}
	
	

}
