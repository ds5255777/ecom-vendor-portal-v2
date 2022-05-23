package com.main.bean;

import javax.persistence.Column;

public class SupplierDTO {
	
	@Column(name = "introduced_by_name")
	private String introducedByName;
	@Column(name = "supp_name")
	private String suppName;
	@Column(name = "comp_email")
	private String compEmail;
	@Column(name = "introduced_by_email_id")
	private String introducedByEmailID;
	@Column(name = "comp_gstn")
	private String compGstn;
	@Column(name = "nature_of_transactions")
	private String natureOfTransactions;
	@Column(name = "partner_type")
	private String partnerType;
	@Column(name = "vendor_type")
	private String vendorType;
	@Column(name = "phone_number")
	private String phoneNumber;
	@Column(name = "status")
	private String status;
	@Column(name = "bp_code")
	private String bpCode;
	public String getIntroducedByName() {
		return introducedByName;
	}
	public void setIntroducedByName(String introducedByName) {
		this.introducedByName = introducedByName;
	}
	public String getSuppName() {
		return suppName;
	}
	public void setSuppName(String suppName) {
		this.suppName = suppName;
	}
	public String getCompEmail() {
		return compEmail;
	}
	public void setCompEmail(String compEmail) {
		this.compEmail = compEmail;
	}
	public String getIntroducedByEmailID() {
		return introducedByEmailID;
	}
	public void setIntroducedByEmailID(String introducedByEmailID) {
		this.introducedByEmailID = introducedByEmailID;
	}
	public String getCompGstn() {
		return compGstn;
	}
	public void setCompGstn(String compGstn) {
		this.compGstn = compGstn;
	}
	public String getNatureOfTransactions() {
		return natureOfTransactions;
	}
	public void setNatureOfTransactions(String natureOfTransactions) {
		this.natureOfTransactions = natureOfTransactions;
	}
	public String getPartnerType() {
		return partnerType;
	}
	public void setPartnerType(String partnerType) {
		this.partnerType = partnerType;
	}
	public String getVendorType() {
		return vendorType;
	}
	public void setVendorType(String vendorType) {
		this.vendorType = vendorType;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getBpCode() {
		return bpCode;
	}
	public void setBpCode(String bpCode) {
		this.bpCode = bpCode;
	} 


}
