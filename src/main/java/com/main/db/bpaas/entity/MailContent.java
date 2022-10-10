package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "mail_content")
@Data
public class MailContent {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@Column(name = "type")
	private String type;
	@Column(name = "subject")
	private String subject;
	@Column(name = "email_body", columnDefinition = "TEXT")
	private String emailBody;

}
