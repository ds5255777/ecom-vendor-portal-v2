package com.main.db.bpaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "send_email_vendor")
public class SendEmailToVendor {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@Column(name = "vendor_email")
	private String vendorEmail;
	
	@Column(name = "verifier_name")
	private String verifierName;
	
	@Column(name = "vendor_type")
	private String vendorType;
	@Column(name = "region")
	private String region;
	
	@Column(name = "creditTerms")
	private String creditTerms;
	@Column(name = "process_on")
	private Date processOn;
	@Column(name = "process_by")
	private String processBy;
	@Column(name = "third_party_verification")
	private String thirdPartyVerification;

	@Column(name = "ehs_verification")
	private String ehsVerification;

	@Column(name = "comments")
	private String comments;
	@Column(name = "flag")
	private Integer flag;
	
	@Column(name = "status")
	private String status;
	
	@Column(name = "vendor_pid")
	private String vendorPid;
	
	@Column(name = "comm_his_id")
	private String comm_his_id;
	
	
	@Column(name = "comments_of_commercial_head")
	private String commentsHead;
	
	@Column(name = "link_expiration_date")
	private Date linkExpirationDate;
	
	@Column(name = "commercial_head")
	private String commercialHead;
	
	@Column(name = "assign_at")
	private String assignAt;
	
	/*
	 * @OneToOne(cascade = {CascadeType.ALL})
	 * 
	 * @JoinColumn(name = "comm_his_id") private CommentHistory commentHistory;
	 */
}
