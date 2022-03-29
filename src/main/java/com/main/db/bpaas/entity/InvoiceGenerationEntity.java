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
	@Column(name = "vehicle_number")
	private String vehicleNumber;
	@Column(name = "invoice_status")
	private String invoiceStatus;// Processed, Approved, Rejected

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

	public String getVehicleNumber() {
		return vehicleNumber;
	}

	public void setVehicleNumber(String vehicleNumber) {
		this.vehicleNumber = vehicleNumber;
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

}
