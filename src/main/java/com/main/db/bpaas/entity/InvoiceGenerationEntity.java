package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "invoice_generation")
public class InvoiceGenerationEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "bp_code")
	private String bpCode;
	@Column(name = "bp_name")
	private String bpName;
	@Column(name = "site_name")
	private String siteName;
	@Column(name = "invoice_number")
	private String invoiceNumber;
	@Column(name = "invoice_receiving_date")
	private String invoiceReceivingDate;
	@Column(name = "invoice_date")
	private String invoiceDate;
	@Column(name = "invoice_currency")
	private String invoiceCurrency;
	@Column(name = "invoice_amount")
	private String invoiceAmount;
	@Column(name = "gl_date")
	private String glDate;
	@Column(name = "payment_currency")
	private String paymentCurrency;
	@Column(name = "operating_unit")
	private String operatingUnit;
	@Column(name = "type")
	private String type;
	@Column(name = "term_date")
	private String termDate;
	@Column(name = "terms")
	private String terms;
	@Column(name = "payment_method")
	private String paymentMethod;
	@Column(name = "pay_groups")
	private String payGroups;
	@Column(name = "header_description")
	private String headerDescription;
	@Column(name = "line_number")
	private String lineNumber;
	@Column(name = "distribution_number")
	private String distributionNumber;
	@Column(name = "tds_account")
	private String tdsAccount;
	@Column(name = "description")
	private String description;
	@Column(name = "tds_amount")
	private String tdsAmount;
	@Column(name = "section_code")
	private String sectionCode;
	@Column(name = "tds_tax_category")
	private String tdsTaxCategory;
	@Column(name = "check_box")
	private String checkBox;
	@Column(name = "organization")
	private String organization;
	@Column(name = "document_number")
	private String documentNumber;
	@Column(name = "taxable_amount")
	private String taxableAmount;
	@Column(name = "tax_amount")
	private String taxAmount;
	@Column(name = "location")
	private String location;
	@Column(name = "supplier_tax_invoice_number")
	private String supplierTaxInvoiceNumber;
	@Column(name = "supplier_tax_invoice_date")
	private String supplierTaxInvoiceDate;
	@Column(name = "orignal_tax_invoice_number")
	private String orignalTaxInvoiceNumber;
	@Column(name = "orignal_tax_invoice_date")
	private String orignalTaxInvoiceDate;
	@Column(name = "gst_tax_category")
	private String gstTaxCategory;

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

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getBpCode() {
		return bpCode;
	}

	public void setBpCode(String bpCode) {
		this.bpCode = bpCode;
	}

	public String getBpName() {
		return bpName;
	}

	public void setBpName(String bpName) {
		this.bpName = bpName;
	}

	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public String getInvoiceNumber() {
		return invoiceNumber;
	}

	public void setInvoiceNumber(String invoiceNumber) {
		this.invoiceNumber = invoiceNumber;
	}

	public String getInvoiceReceivingDate() {
		return invoiceReceivingDate;
	}

	public void setInvoiceReceivingDate(String invoiceReceivingDate) {
		this.invoiceReceivingDate = invoiceReceivingDate;
	}

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	public String getInvoiceCurrency() {
		return invoiceCurrency;
	}

	public void setInvoiceCurrency(String invoiceCurrency) {
		this.invoiceCurrency = invoiceCurrency;
	}

	public String getInvoiceAmount() {
		return invoiceAmount;
	}

	public void setInvoiceAmount(String invoiceAmount) {
		this.invoiceAmount = invoiceAmount;
	}

	public String getGlDate() {
		return glDate;
	}

	public void setGlDate(String glDate) {
		this.glDate = glDate;
	}

	public String getPaymentCurrency() {
		return paymentCurrency;
	}

	public void setPaymentCurrency(String paymentCurrency) {
		this.paymentCurrency = paymentCurrency;
	}

	public String getOperatingUnit() {
		return operatingUnit;
	}

	public void setOperatingUnit(String operatingUnit) {
		this.operatingUnit = operatingUnit;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTermDate() {
		return termDate;
	}

	public void setTermDate(String termDate) {
		this.termDate = termDate;
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

	public String getPayGroups() {
		return payGroups;
	}

	public void setPayGroups(String payGroups) {
		this.payGroups = payGroups;
	}

	public String getHeaderDescription() {
		return headerDescription;
	}

	public void setHeaderDescription(String headerDescription) {
		this.headerDescription = headerDescription;
	}

	public String getLineNumber() {
		return lineNumber;
	}

	public void setLineNumber(String lineNumber) {
		this.lineNumber = lineNumber;
	}

	public String getDistributionNumber() {
		return distributionNumber;
	}

	public void setDistributionNumber(String distributionNumber) {
		this.distributionNumber = distributionNumber;
	}

	public String getTdsAccount() {
		return tdsAccount;
	}

	public void setTdsAccount(String tdsAccount) {
		this.tdsAccount = tdsAccount;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTdsAmount() {
		return tdsAmount;
	}

	public void setTdsAmount(String tdsAmount) {
		this.tdsAmount = tdsAmount;
	}

	public String getSectionCode() {
		return sectionCode;
	}

	public void setSectionCode(String sectionCode) {
		this.sectionCode = sectionCode;
	}

	public String getTdsTaxCategory() {
		return tdsTaxCategory;
	}

	public void setTdsTaxCategory(String tdsTaxCategory) {
		this.tdsTaxCategory = tdsTaxCategory;
	}

	public String getCheckBox() {
		return checkBox;
	}

	public void setCheckBox(String checkBox) {
		this.checkBox = checkBox;
	}

	public String getOrganization() {
		return organization;
	}

	public void setOrganization(String organization) {
		this.organization = organization;
	}

	public String getDocumentNumber() {
		return documentNumber;
	}

	public void setDocumentNumber(String documentNumber) {
		this.documentNumber = documentNumber;
	}

	public String getTaxableAmount() {
		return taxableAmount;
	}

	public void setTaxableAmount(String taxableAmount) {
		this.taxableAmount = taxableAmount;
	}

	public String getTaxAmount() {
		return taxAmount;
	}

	public void setTaxAmount(String taxAmount) {
		this.taxAmount = taxAmount;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getSupplierTaxInvoiceNumber() {
		return supplierTaxInvoiceNumber;
	}

	public void setSupplierTaxInvoiceNumber(String supplierTaxInvoiceNumber) {
		this.supplierTaxInvoiceNumber = supplierTaxInvoiceNumber;
	}

	public String getSupplierTaxInvoiceDate() {
		return supplierTaxInvoiceDate;
	}

	public void setSupplierTaxInvoiceDate(String supplierTaxInvoiceDate) {
		this.supplierTaxInvoiceDate = supplierTaxInvoiceDate;
	}

	public String getOrignalTaxInvoiceNumber() {
		return orignalTaxInvoiceNumber;
	}

	public void setOrignalTaxInvoiceNumber(String orignalTaxInvoiceNumber) {
		this.orignalTaxInvoiceNumber = orignalTaxInvoiceNumber;
	}

	public String getOrignalTaxInvoiceDate() {
		return orignalTaxInvoiceDate;
	}

	public void setOrignalTaxInvoiceDate(String orignalTaxInvoiceDate) {
		this.orignalTaxInvoiceDate = orignalTaxInvoiceDate;
	}

	public String getGstTaxCategory() {
		return gstTaxCategory;
	}

	public void setGstTaxCategory(String gstTaxCategory) {
		this.gstTaxCategory = gstTaxCategory;
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

	public String getDocumentFileTwoName() {
		return documentFileTwoName;
	}

	public void setDocumentFileTwoName(String documentFileTwoName) {
		this.documentFileTwoName = documentFileTwoName;
	}

	public String getDocumentFileTwoText() {
		return documentFileTwoText;
	}

	public void setDocumentFileTwoText(String documentFileTwoText) {
		this.documentFileTwoText = documentFileTwoText;
	}

}
