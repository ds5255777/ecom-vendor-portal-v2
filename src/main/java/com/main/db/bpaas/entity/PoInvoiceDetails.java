package com.main.db.bpaas.entity;

import java.util.Date;
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

import lombok.Data;

@Entity
@Table(name = "Poinvoice_details")
@Data
public class PoInvoiceDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "operating_Unit")
	private String operatingUnit;
	@Column(name = "Invoice_Type")
	private String invoiceType;

	@Column(name = "Trading_partner")
	private String tradingPartner;
	@Column(name = "Supplier_Num")
	private String supplierNum;

	@Column(name = "Supplier_Site")
	private String supplierSite;
	@Column(name = "Invoice_Date")
	private String invoiceDate;

	@Column(name = "poinvoice_Number")
	private String poInvoiceNumber;
	@Column(name = "Invoice_Num")
	private String invoiceNumber;

	@Column(name = "vendor_Invoice_Number")
	private String vendorInvoiceNumber;
	@Column(name = "Invoice_Currency")
	private String invoiceCurrency;

	@Column(name = "Invoice_Amount")
	private String invoiceAmount;
	@Column(name = "GL_Date")
	private Date glDate;

	@Column(name = "Payment_Currency")
	private String paymentCurrency;
	@Column(name = "Match_Option")
	private String matchOption;

	@Column(name = "Terms_Date")
	private String termsDate;
	@Column(name = "Terms")
	private String terms;

	@Column(name = "Payment_Method")
	private String paymentMethod;
	@Column(name = "Pay_Group")
	private String payGroup;

	@Column(name = "RemitTobank_accountName")
	private String remitToBankAccountName;
	@Column(name = "RemitTobank_accountNumber")
	private String remitToBankAccountNumber;

	@Column(name = "Supplier_invoice_date")
	private Date supplierInvoiceDate;

	@Column(name = "Supplier_Invoice_number")
	private String supplierInvoiceNumber;

	@Column(name = "Vendor_code")
	private String vendorCode;

	@Column(name = "Account")
	private String account;

	@Column(name = "Po_number")
	private String poNumber;

	@Column(name = "status")
	private String status;

	@Column(name = "Line_type")
	private String lineType;

	@Column(name = "Amount")
	private String amount;

	@Column(name = "gross_Total_Amt")
	private String grossTotalAmt;

	@Column(name = "assign_to")
	private String assignTo;

	@Column(name = "raised_on")
	private Date raisedOn;
	@Column(name = "raised_by")
	private String raisedBy;

	@Column(name = "gldatedistribution_date")
	private Date glDateDistributionDate;

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn
	private List<PoInvoiceLine> poInvoiceLine;

	@Transient
	private String invoiceFileName;
	@Transient
	private String invoiceFileText;
	@Transient
	private String documentFileOneName;
	@Transient
	private String documentFileOneText;

}
