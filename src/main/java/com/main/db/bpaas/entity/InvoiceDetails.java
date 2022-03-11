package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "invoice_details")
public class InvoiceDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "supplier_name")
	private String supplierName;
	@Column(name = "supplier_number")
	private String supplierNumber;
	@Column(name = "supplier_site_name")
	private String supplierSiteName;
	@Column(name = "invoice_date")
	private String invoiceDate;
	@Column(name = "invoice_number")
	private String invoiceNumber;
	@Column(name = "invoice_currency")
	private String invoiceCurrency;
	@Column(name = "invoice_amount")
	private String invoiceAmount;
	@Column(name = "gl_date")
	private String glDate;
	@Column(name = "payment_currency")
	private String paymentCurrency;
	@Column(name = "header_description")
	private String headerDescription;
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
	@Column(name = "invoice_receiving_date")
	private String invoiceReceivingDate;
	@Column(name = "route_name")
	private String routeName;
	@Column(name = "vehicle_number")
	private String vehicleNumber;

	@Column(name = "line_number")
	private String lineNumber;
	@Column(name = "distribution_number")
	private String distributionNumber;
	/*
	 * @Column (name = "account") private String account;
	 */
	@Column(name = "description")
	private String description;
	/*
	 * @Column (name = "amount") private String amount;
	 */
	@Column(name = "section_code")
	private String sectionCode;
	@Column(name = "tax_category")
	private String taxCategory;
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
	/*
	 * @Column (name = "tax_category") private String taxCategory;
	 */
	@Column(name = "invoice_status")
	private String invoiceStatus;
	@Column(name = "intended_use")
	private String intendedUse;

	/*@Transient
	String documentFileText;
	@Transient
	String documentFileName;

	@Transient
	String invoiceFileText;
	@Transient
	String invoiceFileName;*/

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getSupplierNumber() {
		return supplierNumber;
	}

	public void setSupplierNumber(String supplierNumber) {
		this.supplierNumber = supplierNumber;
	}

	public String getSupplierSiteName() {
		return supplierSiteName;
	}

	public void setSupplierSiteName(String supplierSiteName) {
		this.supplierSiteName = supplierSiteName;
	}

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
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

	public String getHeaderDescription() {
		return headerDescription;
	}

	public void setHeaderDescription(String headerDescription) {
		this.headerDescription = headerDescription;
	}

	public String getOperatingUnit() {
		return operatingUnit;
	}

	public void setOperatingUnit(String operatingUnit) {
		this.operatingUnit = operatingUnit;
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

	public String getInvoiceReceivingDate() {
		return invoiceReceivingDate;
	}

	public void setInvoiceReceivingDate(String invoiceReceivingDate) {
		this.invoiceReceivingDate = invoiceReceivingDate;
	}

	public String getRouteName() {
		return routeName;
	}

	public void setRouteName(String routeName) {
		this.routeName = routeName;
	}

	public String getVehicleNumber() {
		return vehicleNumber;
	}

	public void setVehicleNumber(String vehicleNumber) {
		this.vehicleNumber = vehicleNumber;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSectionCode() {
		return sectionCode;
	}

	public void setSectionCode(String sectionCode) {
		this.sectionCode = sectionCode;
	}

	public String getTaxCategory() {
		return taxCategory;
	}

	public void setTaxCategory(String taxCategory) {
		this.taxCategory = taxCategory;
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

	public String getIntendedUse() {
		return intendedUse;
	}

	public void setIntendedUse(String intendedUse) {
		this.intendedUse = intendedUse;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	

	public String getInvoiceStatus() {
		return invoiceStatus;
	}

	public void setInvoiceStatus(String invoiceStatus) {
		this.invoiceStatus = invoiceStatus;
	}

}
