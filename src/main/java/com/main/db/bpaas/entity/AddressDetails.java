package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "AddressDetails")
@Getter
@Setter
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
