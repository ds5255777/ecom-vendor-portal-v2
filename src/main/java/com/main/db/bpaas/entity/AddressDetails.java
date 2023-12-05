package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "AddressDetails")
@Data
public class AddressDetails {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "add_country")
	private String addCountry;
	@Column(name = "state")
	private String state;
	@Column(name = "city")
	private String city;
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getAddCountry() {
		return addCountry;
	}

	public void setAddCountry(String addCountry) {
		this.addCountry = addCountry;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getPinCode() {
		return pinCode;
	}

	public void setPinCode(String pinCode) {
		this.pinCode = pinCode;
	}

	public String getVendorType() {
		return vendorType;
	}

	public void setVendorType(String vendorType) {
		this.vendorType = vendorType;
	}

	public String getPartnerType() {
		return partnerType;
	}

	public void setPartnerType(String partnerType) {
		this.partnerType = partnerType;
	}

	public String getCompGstn() {
		return compGstn;
	}

	public void setCompGstn(String compGstn) {
		this.compGstn = compGstn;
	}

	public String getAddDetails() {
		return addDetails;
	}

	public void setAddDetails(String addDetails) {
		this.addDetails = addDetails;
	}

	public String getGlCode() {
		return glCode;
	}

	public void setGlCode(String glCode) {
		this.glCode = glCode;
	}

	public String getSupplierSiteCode() {
		return supplierSiteCode;
	}

	public void setSupplierSiteCode(String supplierSiteCode) {
		this.supplierSiteCode = supplierSiteCode;
	}

	@Column(name = "pin_code")
	private String pinCode;
	@Column(name = "vendor_type")
	private String vendorType;
	@Column(name = "partner_type")
	private String partnerType;
	@Column(name = "comp_gstn")
	private String compGstn;
	@Column(name = "add_details")
	private String addDetails;

	@Column(name = "gl_code")
	private String glCode;

	@Column(name = "supplier_site_code")
	private String supplierSiteCode;

}
