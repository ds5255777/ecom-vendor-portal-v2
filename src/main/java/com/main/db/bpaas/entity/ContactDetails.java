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
@Table(name = "ContactDetails")
@Getter
@Setter
public class ContactDetails {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "con_fname")
	private String conFname;
	@Column(name = "con_lname")
	private String conLname;
	@Column(name = "con_phone")
	private String conPhone;
	@Column(name = "con_email")
	private String conEmail;

}
