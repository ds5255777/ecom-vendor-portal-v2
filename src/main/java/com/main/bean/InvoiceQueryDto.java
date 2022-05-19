package com.main.bean;

import java.util.List;

import com.main.db.bpaas.entity.InvoiceLineItem;

public class InvoiceQueryDto {

	private Long id;
	private String ecomInvoiceNumber;
	private String vendorCode;
	private String vendorName;
	private String siteName;
	private String invoiceDate;
	private String invoiceNumber;
	private String invoiceCurrency;
	private String invoiceAmount;
	private String invoiceReceivingDate;
	private String vehicleNumber;
	private String invoiceStatus;// Processed, Approved, Rejected
	private String assignTo;// network Team, Vendor
	private String taxableAmount;
	private String taxAmount;

	private String invoiceFileName;
	private String invoiceFileText;
	private String documentFileOneName;
	private String documentFileOneText;
	private String documentFileTwoName;
	private String documentFileTwoText;

	private String remarks;

	private List<InvoiceLineItem> invoiceLineItems;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getEcomInvoiceNumber() {
		return ecomInvoiceNumber;
	}

	public void setEcomInvoiceNumber(String ecomInvoiceNumber) {
		this.ecomInvoiceNumber = ecomInvoiceNumber;
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

	public String getAssignTo() {
		return assignTo;
	}

	public void setAssignTo(String assignTo) {
		this.assignTo = assignTo;
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

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public List<InvoiceLineItem> getInvoiceLineItems() {
		return invoiceLineItems;
	}

	public void setInvoiceLineItems(List<InvoiceLineItem> invoiceLineItems) {
		this.invoiceLineItems = invoiceLineItems;
	}

}
