package com.main.db.bpaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;

@Entity(name = "email_audit_logs")
@Getter
@Setter
public class EmailAuditLogs {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@Column(name = "mail_from")
	private String mailFrom;
	@Column(name = "mail_to")
	private String mailTo;
	@Column(name = "mail_cc")
	private String mailCC;
	@Column(name = "mail_bcc")
	private String mailBCC;
	@Column(name = "mail_subject")
	private String mailSubject;
	@Column(name = "email_body", columnDefinition = "TEXT")
	private String mailMessage;
	@Column(name = "mail_status")
	private String mailStatus;
	@Column(name = "create_on")
	private Date createdOn = new Date();

}
