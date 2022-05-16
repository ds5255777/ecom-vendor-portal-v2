package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "payment_terms")
public class PaymentTerms {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column(name = "payment_term")
	private String PaymentTerm;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPaymentTerm() {
		return PaymentTerm;
	}

	public void setPaymentTerm(String paymentTerm) {
		PaymentTerm = paymentTerm;
	}
	
	
	
	
	

}
