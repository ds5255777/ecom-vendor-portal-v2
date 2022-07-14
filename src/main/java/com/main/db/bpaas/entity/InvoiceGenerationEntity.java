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

@Entity
@Table(name = "invoice_generation")
public class InvoiceGenerationEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@Column(name = "ecom_invoice_nunmber")
	private String ecomInvoiceNumber;
// Form one
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
	/*
	 * @Column(name = "vehicle_number") private String vehicleNumber;
	 */
	@Column(name = "invoice_status")
	private String invoiceStatus;// Processed, Approved, Rejected
	@Column(name = "assign_to")
	private String assignTo;// network Team, Vendor

	@Column(name = "processed_On")
	private String processedOn;//

	@Column(name = "processed_By")
	private String processedBy;//

	@Column(name = "hsn_code")
	private String hsnCode;//

	@Column(name = "green_tax")
	private String greenTax;//

	@Column(name = "extra_km_rate")
	private String extraKmRate;//

	@Column(name = "miscellaneous")
	private String miscellaneous;//

	@Column(name = "extera_km")
	private String exteraKM;//

	@Column(name = "rate_per_km")
	private String ratePerKm;//
	// form Two

	@Column(name = "taxable_amount")
	private String taxableAmount;
	@Column(name = "tax_amount")
	private String taxAmount;

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn
	private List<InvoiceLineItem> invoiceLineItem;

	// form 3
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

	public String getEcomInvoiceNumber() {
		return ecomInvoiceNumber;
	}

	public void setEcomInvoiceNumber(String ecomInvoiceNumber) {
		this.ecomInvoiceNumber = ecomInvoiceNumber;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getVendorCode() {
		return vendorCode;
	}

	public void setVendorCode(String vendorCode) {
		this.vendorCode = vendorCode;
	}

	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}

	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
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

	public String getInvoiceReceivingDate() {
		return invoiceReceivingDate;
	}

	public void setInvoiceReceivingDate(String invoiceReceivingDate) {
		this.invoiceReceivingDate = invoiceReceivingDate;
	}

	public String getInvoiceStatus() {
		return invoiceStatus;
	}

	public void setInvoiceStatus(String invoiceStatus) {
		this.invoiceStatus = invoiceStatus;
	}

	public List<InvoiceLineItem> getInvoiceLineItem() {
		return invoiceLineItem;
	}

	public void setInvoiceLineItem(List<InvoiceLineItem> invoiceLineItem) {
		this.invoiceLineItem = invoiceLineItem;
	}

	public String getTaxableAmount() {
		return taxableAmount;
	}

	public void setTaxableAmount(String taxableAmount) {
		this.taxableAmount = taxableAmount;
	}

	public String getProcessedOn() {
		return processedOn;
	}

	public void setProcessedOn(String processedOn) {
		this.processedOn = processedOn;
	}

	public String getProcessedBy() {
		return processedBy;
	}

	public void setProcessedBy(String processedBy) {
		this.processedBy = processedBy;
	}

	public String getTaxAmount() {
		return taxAmount;
	}

	public void setTaxAmount(String taxAmount) {
		this.taxAmount = taxAmount;
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

	public String getAssignTo() {
		return assignTo;
	}

	public void setAssignTo(String assignTo) {
		this.assignTo = assignTo;
	}

	public String getHsnCode() {
		return hsnCode;
	}

	public void setHsnCode(String hsnCode) {
		this.hsnCode = hsnCode;
	}

	public String getGreenTax() {
		return greenTax;
	}

	public void setGreenTax(String greenTax) {
		this.greenTax = greenTax;
	}

	public String getExtraKmRate() {
		return extraKmRate;
	}

	public void setExtraKmRate(String extraKmRate) {
		this.extraKmRate = extraKmRate;
	}

	public String getMiscellaneous() {
		return miscellaneous;
	}

	public void setMiscellaneous(String miscellaneous) {
		this.miscellaneous = miscellaneous;
	}

	public String getExteraKM() {
		return exteraKM;
	}

	public void setExteraKM(String exteraKM) {
		this.exteraKM = exteraKM;
	}

	public String getRatePerKm() {
		return ratePerKm;
	}

	public void setRatePerKm(String ratePerKm) {
		this.ratePerKm = ratePerKm;
	}

}
