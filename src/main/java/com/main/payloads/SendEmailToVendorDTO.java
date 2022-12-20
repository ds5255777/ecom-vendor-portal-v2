package com.main.payloads;

import java.util.Date;

import lombok.Data;

@Data
public class SendEmailToVendorDTO {

	private String vendorEmail;
	private String vendorType;
	private String region;
	private String creditTerms;
	private Date processOn;
	private String processBy;
	private Integer flag;
	private String vendorPid;
}
