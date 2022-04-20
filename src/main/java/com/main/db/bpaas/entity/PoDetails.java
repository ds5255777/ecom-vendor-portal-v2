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


@Entity
@Table(name = "Po_Details")
public class PoDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	/* Stap-1 Entity */
	@Column(name = "PO_Number")
	private String poNo;
	@Column(name = "Type")
	private String type;

	@Column(name = "Buyer")
	private String buyer;
	@Column(name = "Currency")
	private String currency;
	
	@Column(name = "Status")
	private String status;
	
	@Column(name = "Operating_Unit")
	private String operatingUnit;
	@Column(name = "Supplier")
	private String supplier;
	@Column(name = "Ship_To")
	private String shipTo;
	@Column(name = "Bill_To")
	private String billTo;
	
	@Column(name = "need_By_Date")
	private String needByDate;
	
	//line
	
	
	//end line
	
	
	@Column(name = "Invoice_Match_option")
	private String invoiceMatchoption;
	
	@Column(name = "Org")
	private String org;
	@Column(name = "Match_Approval_Level")
	private String matchApprovalLevel;
	
	
	@Column(name = "Accrue_at_Receipt_flag")
	private String accrueatReceiptflag;
	@Column(name = "Deliver_To")
	private String deliverTo;
	

	@Column(name = "Process_By")
	private String processBy;
	@Column(name = "Process_On")
	private String processOn;
	
	@Column(name = "vendor_code")
	private String vendorCode;
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn
	private List<PoLineDetails> poLineDetails;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getPoNo() {
		return poNo;
	}
	public void setPoNo(String poNo) {
		this.poNo = poNo;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getBuyer() {
		return buyer;
	}
	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOperatingUnit() {
		return operatingUnit;
	}
	public void setOperatingUnit(String operatingUnit) {
		this.operatingUnit = operatingUnit;
	}
	public String getSupplier() {
		return supplier;
	}
	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	public String getShipTo() {
		return shipTo;
	}
	public void setShipTo(String shipTo) {
		this.shipTo = shipTo;
	}
	public String getBillTo() {
		return billTo;
	}
	public void setBillTo(String billTo) {
		this.billTo = billTo;
	}
	
	public String getInvoiceMatchoption() {
		return invoiceMatchoption;
	}
	public void setInvoiceMatchoption(String invoiceMatchoption) {
		this.invoiceMatchoption = invoiceMatchoption;
	}
	
	public String getOrg() {
		return org;
	}
	public void setOrg(String org) {
		this.org = org;
	}
	public String getMatchApprovalLevel() {
		return matchApprovalLevel;
	}
	public void setMatchApprovalLevel(String matchApprovalLevel) {
		this.matchApprovalLevel = matchApprovalLevel;
	}
	
	
	public String getAccrueatReceiptflag() {
		return accrueatReceiptflag;
	}
	public void setAccrueatReceiptflag(String accrueatReceiptflag) {
		this.accrueatReceiptflag = accrueatReceiptflag;
	}
	public String getDeliverTo() {
		return deliverTo;
	}
	public void setDeliverTo(String deliverTo) {
		this.deliverTo = deliverTo;
	}
	
	public String getProcessBy() {
		return processBy;
	}
	public void setProcessBy(String processBy) {
		this.processBy = processBy;
	}
	public String getProcessOn() {
		return processOn;
	}
	public void setProcessOn(String processOn) {
		this.processOn = processOn;
	}
	public String getVendorCode() {
		return vendorCode;
	}
	public void setVendorCode(String vendorCode) {
		this.vendorCode = vendorCode;
	}
	public List<PoLineDetails> getPoLineDetails() {
		return poLineDetails;
	}
	public void setPoLineDetails(List<PoLineDetails> poLineDetails) {
		this.poLineDetails = poLineDetails;
	}
	public String getNeedByDate() {
		return needByDate;
	}
	public void setNeedByDate(String needByDate) {
		this.needByDate = needByDate;
	}
	
	
	
	

	

}
