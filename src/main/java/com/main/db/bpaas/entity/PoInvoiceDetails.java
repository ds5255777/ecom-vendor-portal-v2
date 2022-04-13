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


@Entity
@Table(name = "Poinvoice_details")
public class PoInvoiceDetails {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name = "operating_Unit")
	private String operatingUnit;
	@Column(name = "Invoice_Type")
	private String invoiceType;


	@Column(name = "Trading_partner")
	private String tradingPartner;//supplier
	@Column(name = "Supplier_Num")
	private String supplierNum;

	
	@Column(name = "Supplier_Site")
	private String supplierSite;
	@Column(name = "Invoice_Date")
	private Date invoiceDate;

	
	@Column(name = "Invoice_Num")
	private String invoiceNumber;
	@Column(name = "Invoice_Currency")
	private String invoiceCurrency;

	
	@Column(name = "Invoice_Amount")
	private Double invoiceAmount;
	@Column(name = "GL_Date")
	private Date glDate;
	
	@Column(name = "Payment_Currency")
	private String paymentCurrency;
	@Column(name = "Match_Option")
	private String matchOption;
	
	@Column(name = "Terms_Date")
	private Date termsDate;
	@Column(name = "Terms")
	private String terms;
	
	@Column(name = "Payment_Method")
	private String paymentMethod;
	@Column(name = "Pay_Group")
	private String payGroup;
	
	@Column(name = "RemitTobank_accountName")
	private String remitToBankAccountName;
	@Column(name = "RemitTobank_accountNumber")
	private Double remitToBankAccountNumber;
	
	@Column(name = "Supplier_invoice_date")
	private Date supplierInvoiceDate;
	
	@Column(name = "Vendor_code")
	private String vendorCode;
	
	@Column(name = "Account")
	private String account;
	
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn
	private List<PoInvoiceLine> poInvoiceLine;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getOperatingUnit() {
		return operatingUnit;
	}

	public void setOperatingUnit(String operatingUnit) {
		this.operatingUnit = operatingUnit;
	}

	public String getInvoiceType() {
		return invoiceType;
	}

	public void setInvoiceType(String invoiceType) {
		this.invoiceType = invoiceType;
	}

	public String getTradingPartner() {
		return tradingPartner;
	}

	public void setTradingPartner(String tradingPartner) {
		this.tradingPartner = tradingPartner;
	}

	public String getSupplierNum() {
		return supplierNum;
	}

	public void setSupplierNum(String supplierNum) {
		this.supplierNum = supplierNum;
	}

	public String getSupplierSite() {
		return supplierSite;
	}

	public void setSupplierSite(String supplierSite) {
		this.supplierSite = supplierSite;
	}

	public Date getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(Date invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	

	public String getInvoiceNumber() {
		return invoiceNumber;
	}

	public void setInvoiceNumber(String invoiceNumber) {
		this.invoiceNumber = invoiceNumber;
	}

	public String getInvoiceCurrency() {
		return invoiceCurrency;
	}

	public void setInvoiceCurrency(String invoiceCurrency) {
		this.invoiceCurrency = invoiceCurrency;
	}

	public Double getInvoiceAmount() {
		return invoiceAmount;
	}

	public void setInvoiceAmount(Double invoiceAmount) {
		this.invoiceAmount = invoiceAmount;
	}

	public Date getGlDate() {
		return glDate;
	}

	public void setGlDate(Date glDate) {
		this.glDate = glDate;
	}

	public String getPaymentCurrency() {
		return paymentCurrency;
	}

	public void setPaymentCurrency(String paymentCurrency) {
		this.paymentCurrency = paymentCurrency;
	}

	public String getMatchOption() {
		return matchOption;
	}

	public void setMatchOption(String matchOption) {
		this.matchOption = matchOption;
	}

	public Date getTermsDate() {
		return termsDate;
	}

	public void setTermsDate(Date termsDate) {
		this.termsDate = termsDate;
	}

	public String getTerms() {
		return terms;
	}

	public void setTerms(String terms) {
		this.terms = terms;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getPayGroup() {
		return payGroup;
	}

	public void setPayGroup(String payGroup) {
		this.payGroup = payGroup;
	}

	public String getRemitToBankAccountName() {
		return remitToBankAccountName;
	}

	public void setRemitToBankAccountName(String remitToBankAccountName) {
		this.remitToBankAccountName = remitToBankAccountName;
	}

	public Double getRemitToBankAccountNumber() {
		return remitToBankAccountNumber;
	}

	public void setRemitToBankAccountNumber(Double remitToBankAccountNumber) {
		this.remitToBankAccountNumber = remitToBankAccountNumber;
	}

	public Date getSupplierInvoiceDate() {
		return supplierInvoiceDate;
	}

	public void setSupplierInvoiceDate(Date supplierInvoiceDate) {
		this.supplierInvoiceDate = supplierInvoiceDate;
	}

	public String getVendorCode() {
		return vendorCode;
	}

	public void setVendorCode(String vendorCode) {
		this.vendorCode = vendorCode;
	}

	public List<PoInvoiceLine> getPoInvoiceLine() {
		return poInvoiceLine;
	}

	public void setPoInvoiceLine(List<PoInvoiceLine> poInvoiceLine) {
		this.poInvoiceLine = poInvoiceLine;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}


	
	
	
	
	
	
}
