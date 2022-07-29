package com.main.payloads;

import lombok.Data;

@Data
public class AddressDetailsDTO {
	
	private Long id;
	private String addCountry;
	private String state;
	private String city;
	private String pinCode;
	private String vendorType;
	private String partnerType;
	private String compGstn;
	private String addDetails;
	private String glCode;
	private String supplierSiteCode;


}
