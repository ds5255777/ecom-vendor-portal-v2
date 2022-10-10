package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "send_email")
@Data
public class SendEmail {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@Column(name = "mail_from")
	private String mailfrom;
	@Column(name = "send_to")
	private String sendTo;
	@Column(name = "send_cc")
	private String sendCc;
	@Column(name = "bcc")
	private String bcc;
	@Column(name = "subject")
	private String subject;
	@Column(name = "email_body", columnDefinition = "TEXT")
	private String emailBody;
	@Column(name = "status")
	private String status;

}
