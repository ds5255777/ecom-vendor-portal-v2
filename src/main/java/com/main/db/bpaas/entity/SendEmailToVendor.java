package com.main.db.bpaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "send_email_vendor")
public class SendEmailToVendor {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@Column(name = "vendor_email")
	private String vendorEmail;
	@Column(name = "vendor_type")
	private String vendorType;
	@Column(name = "region")
	private String region;
	@Column(name = "vendor_address")
	private String vendorAddress;
	@Column(name = "process_on")
	private Date processOn;
	@Column(name = "process_by")
	private String processBy;

}
