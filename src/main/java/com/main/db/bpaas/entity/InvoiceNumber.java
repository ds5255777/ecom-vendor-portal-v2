package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "invoice_number")
public class InvoiceNumber {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(unique=true,name = "ecom_invoice_nunmber")
	private String ecomInvoiceNumber;

	@Column(name = "invoice_status")
	private String status;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEcomInvoiceNumber() {
		return ecomInvoiceNumber;
	}

	public void setEcomInvoiceNumber(String ecomInvoiceNumber) {
		this.ecomInvoiceNumber = ecomInvoiceNumber;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
