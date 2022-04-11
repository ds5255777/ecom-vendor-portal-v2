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
	@Column(name = "UOM")
	private String uom;
	@Column(name = "Quantity")
	private Double quantity;
	@Column(name = "Need_By_Date")
	private Date needByDate;
	
	
	@Column(name = "Buyer")
	private String buyer;
	@Column(name = "Currency")
	private String currency;
	@Column(name = "Line_Number")
	private String lineNumber;
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
	

	@Column(name = "Item_Type")
	private String itemType;
	@Column(name = "Item")
	private String item;
	@Column(name = "Category")
	private String category;
	@Column(name = "description")
	private String description;
	
	@Column(name = "Invoice_Match_option")
	private String invoiceMatchoption;
	@Column(name = "Charge_Account")
	private String chargeAccount;
	@Column(name = "Org")
	private String org;
	@Column(name = "Match_Approval_Level")
	private String matchApprovalLevel;
	
	@Column(name = "Price")
	private Double price;
	@Column(name = "Accrue_at_Receipt_flag")
	private String accrueatReceiptflag;
	@Column(name = "Deliver_To")
	private String deliverTo;
	
	@Column(name = "Amount")
	private Double amount;
	@Column(name = "Process_By")
	private String processBy;
	@Column(name = "Process_On")
	private String processOn;
	
	@Column(name = "vendor_code")
	private String vendorCode;
	
	
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
	public String getUom() {
		return uom;
	}
	public void setUom(String uom) {
		this.uom = uom;
	}
	
	public Date getNeedByDate() {
		return needByDate;
	}
	public void setNeedByDate(Date needByDate) {
		this.needByDate = needByDate;
	}
	public Double getQuantity() {
		return quantity;
	}
	public void setQuantity(Double quantity) {
		this.quantity = quantity;
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
	public String getLineNumber() {
		return lineNumber;
	}
	public void setLineNumber(String lineNumber) {
		this.lineNumber = lineNumber;
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
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getInvoiceMatchoption() {
		return invoiceMatchoption;
	}
	public void setInvoiceMatchoption(String invoiceMatchoption) {
		this.invoiceMatchoption = invoiceMatchoption;
	}
	public String getChargeAccount() {
		return chargeAccount;
	}
	public void setChargeAccount(String chargeAccount) {
		this.chargeAccount = chargeAccount;
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
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
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
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
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
	
	
	
	

	

}
