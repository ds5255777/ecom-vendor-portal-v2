package com.main.db.bpaas.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "invoice_generation")
@Getter
@Setter
public class InvoiceGenerationEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@Column(name = "ecom_invoice_nunmber")
	private String ecomInvoiceNumber;

	@Column(name = "vendor_code")
	private String vendorCode;
	@Column(name = "vendor_name")
	private String vendorName;
	@Column(name = "site_name")
	private String siteName;
	@Column(name = "invoice_date")
	private String invoiceDate;
	@Column(name = "invoice_number")
	private String invoiceNumber;
	@Column(name = "invoice_currency")
	private String invoiceCurrency;
	@Column(name = "invoice_amount")
	private String invoiceAmount;
	@Column(name = "invoice_receiving_date")
	private String invoiceReceivingDate;

	@Column(name = "invoice_status")
	private String invoiceStatus;
	@Column(name = "assign_to")
	private String assignTo;

	@Column(name = "processed_On")
	private String processedOn;

	@Column(name = "processed_By")
	private String processedBy;

	@Column(name = "hsn_code")
	private String hsnCode;

	@Column(name = "green_tax")
	private String greenTax;

	@Column(name = "extra_km_rate")
	private String extraKmRate;

	@Column(name = "miscellaneous")
	private String miscellaneous;

	@Column(name = "extera_km")
	private String exteraKM;

	@Column(name = "rate_per_km")
	private String ratePerKm;

	@Column(name = "taxable_amount")
	private String taxableAmount;
	@Column(name = "tax_amount")
	private String taxAmount;

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn
	private List<InvoiceLineItem> invoiceLineItem;

	@Transient
	private String invoiceFileName;
	@Transient
	private String invoiceFileText;
	@Transient
	private String documentFileOneName;
	@Transient
	private String documentFileOneText;
	@Transient
	private String documentFileTwoName;
	@Transient
	String documentFileTwoText;

}
