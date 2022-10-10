package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "invoice_number")
@Data
public class InvoiceNumber {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(unique = true, name = "ecom_invoice_nunmber")
	private String ecomInvoiceNumber;

	@Column(name = "invoice_status")
	private String status;

}
