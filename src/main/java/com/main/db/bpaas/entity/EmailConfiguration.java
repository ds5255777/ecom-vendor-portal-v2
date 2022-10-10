package com.main.db.bpaas.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "email_configuration")
@Data
public class EmailConfiguration implements Serializable {

	private static final long serialVersionUID = 1L;
	protected static final String PK = "id";

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "user_name")
	private String userName;

	@Column(name = "password")
	private String password;

	@Column(name = "server_name")
	private String serverName;

	@Column(name = "smtp_port")
	private String smtpPort;

	@Column(name = "is_active")
	private String isActive;

}
