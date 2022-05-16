package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "financial_year")
public class FinancialYear {
	

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column(name = "financial_year")
	private String financialyear ;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFinancialyear() {
		return financialyear;
	}

	public void setFinancialyear(String financialyear) {
		this.financialyear = financialyear;
	}


}
