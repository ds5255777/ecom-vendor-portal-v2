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
	private String tradingPartner;// supplier
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
	private String raisedBy;// Vendor Code

	
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

	

	public String getTermsDate() {
		return termsDate;
	}

	public void setTermsDate(String termsDate) {
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

	public String getPoNumber() {
		return poNumber;
	}

	public void setPoNumber(String poNumber) {
		this.poNumber = poNumber;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public String getInvoiceAmount() {
		return invoiceAmount;
	}

	public void setInvoiceAmount(String invoiceAmount) {
		this.invoiceAmount = invoiceAmount;
	}

	public String getRemitToBankAccountNumber() {
		return remitToBankAccountNumber;
	}

	public void setRemitToBankAccountNumber(String remitToBankAccountNumber) {
		this.remitToBankAccountNumber = remitToBankAccountNumber;
	}

	public String getLineType() {
		return lineType;
	}

	public void setLineType(String lineType) {
		this.lineType = lineType;
	}

	public String getSupplierInvoiceNumber() {
		return supplierInvoiceNumber;
	}

	public void setSupplierInvoiceNumber(String supplierInvoiceNumber) {
		this.supplierInvoiceNumber = supplierInvoiceNumber;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getGrossTotalAmt() {
		return grossTotalAmt;
	}

	public void setGrossTotalAmt(String grossTotalAmt) {
		this.grossTotalAmt = grossTotalAmt;
	}

	public String getPoInvoiceNumber() {
		return poInvoiceNumber;
	}

	public void setPoInvoiceNumber(String poInvoiceNumber) {
		this.poInvoiceNumber = poInvoiceNumber;
	}

	public String getAssignTo() {
		return assignTo;
	}

	public void setAssignTo(String assignTo) {
		this.assignTo = assignTo;
	}

	public String getVendorInvoiceNumber() {
		return vendorInvoiceNumber;
	}

	public void setVendorInvoiceNumber(String vendorInvoiceNumber) {
		this.vendorInvoiceNumber = vendorInvoiceNumber;
	}

	public Date getGlDateDistributionDate() {
		return glDateDistributionDate;
	}

	public void setGlDateDistributionDate(Date glDateDistributionDate) {
		this.glDateDistributionDate = glDateDistributionDate;
	}

	public String getInvoiceFileName() {
		return invoiceFileName;
	}

	public void setInvoiceFileName(String invoiceFileName) {
		this.invoiceFileName = invoiceFileName;
	}

	public String getInvoiceFileText() {
		return invoiceFileText;
	}

	public void setInvoiceFileText(String invoiceFileText) {
		this.invoiceFileText = invoiceFileText;
	}

	public String getDocumentFileOneName() {
		return documentFileOneName;
	}

	public void setDocumentFileOneName(String documentFileOneName) {
		this.documentFileOneName = documentFileOneName;
	}

	public String getDocumentFileOneText() {
		return documentFileOneText;
	}

	public void setDocumentFileOneText(String documentFileOneText) {
		this.documentFileOneText = documentFileOneText;
	}

	public Date getRaisedOn() {
		return raisedOn;
	}

	public void setRaisedOn(Date raisedOn) {
		this.raisedOn = raisedOn;
	}

	public String getRaisedBy() {
		return raisedBy;
	}

	public void setRaisedBy(String raisedBy) {
		this.raisedBy = raisedBy;
	}

}
