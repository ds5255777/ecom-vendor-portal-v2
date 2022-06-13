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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "AddressDetails")

public class AddressDetails {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "add_country")
	private String addCountry;
	@Column(name = "state")
	private String state;
	@Column(name = "city")
	private String city;
	@Column(name = "pin_code")
	private String pinCode;
	@Column(name = "comp_gstn")
	private String compGstn;
	@Column(name = "nature_of_transactions")
	private String natureOfTransactions;
	@Column(name = "add_details")
	private String addDetails;

	@JsonIgnore
	@ManyToOne
	@JoinColumn
	private SupDetails supDetails;

	public SupDetails getSupDetails() {
		return supDetails;
	}

	public void setSupDetails(SupDetails supDetails) {
		this.supDetails = supDetails;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getAddCountry() {
		return addCountry;
	}

	public void setAddCountry(String addCountry) {
		this.addCountry = addCountry;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getPinCode() {
		return pinCode;
	}

	public void setPinCode(String pinCode) {
		this.pinCode = pinCode;
	}

	public String getAddDetails() {
		return addDetails;
	}

	public void setAddDetails(String addDetails) {
		this.addDetails = addDetails;
	}

	public String getCompGstn() {
		return compGstn;
	}

	public void setCompGstn(String compGstn) {
		this.compGstn = compGstn;
	}

	public String getNatureOfTransactions() {
		return natureOfTransactions;
	}

	public void setNatureOfTransactions(String natureOfTransactions) {
		this.natureOfTransactions = natureOfTransactions;
	}

}
