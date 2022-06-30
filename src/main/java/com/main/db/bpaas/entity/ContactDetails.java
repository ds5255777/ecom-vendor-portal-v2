/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ContactDetails")
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

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getConFname() {
		return conFname;
	}

	public void setConFname(String conFname) {
		this.conFname = conFname;
	}

	public String getConLname() {
		return conLname;
	}

	public void setConLname(String conLname) {
		this.conLname = conLname;
	}

	public String getConPhone() {
		return conPhone;
	}

	public void setConPhone(String conPhone) {
		this.conPhone = conPhone;
	}

	public String getConEmail() {
		return conEmail;
	}

	public void setConEmail(String conEmail) {
		this.conEmail = conEmail;
	}

}
