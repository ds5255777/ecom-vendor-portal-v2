package com.main.db.bpaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "PoLine_Details")
public class PoLineDetails {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name = "Line_Number")
	private String lineNumber;
	@Column(name = "Item_Type")
	private String itemType;
	@Column(name = "Item")
	private String item;
	@Column(name = "Category")
	private String category;
	@Column(name = "description")
	private String description;
	@Column(name = "UOM")
	private String uom;
	@Column(name = "Quantity")
	private Double quantity;
	@Column(name = "Need_By_Date")
	private Date needByDate;
	@Column(name = "Price")
	private Double price;
	@Column(name = "Amount")
	private Double amount;
	@Column(name = "Charge_Account")
	private String chargeAccount;

}
