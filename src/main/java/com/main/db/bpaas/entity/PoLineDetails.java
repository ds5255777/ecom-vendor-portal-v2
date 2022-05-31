package com.main.db.bpaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "po_line_details")
public class PoLineDetails {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name = "Po_Line_Id")
	private Double poLineId;
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
	@Column(name = "Remaning_Quatity")
	private String remaningQuatity;
	
	
	public String getRemaningQuatity() {
		return remaningQuatity;
	}
	public void setRemaningQuatity(String remaningQuatity) {
		this.remaningQuatity = remaningQuatity;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getLineNumber() {
		return lineNumber;
	}
	public void setLineNumber(String lineNumber) {
		this.lineNumber = lineNumber;
	}
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getUom() {
		return uom;
	}
	public void setUom(String uom) {
		this.uom = uom;
	}
	public Double getQuantity() {
		return quantity;
	}
	public void setQuantity(Double quantity) {
		this.quantity = quantity;
	}
	public Date getNeedByDate() {
		return needByDate;
	}
	public void setNeedByDate(Date needByDate) {
		this.needByDate = needByDate;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public String getChargeAccount() {
		return chargeAccount;
	}
	public void setChargeAccount(String chargeAccount) {
		this.chargeAccount = chargeAccount;
	}
	public Double getPoLineId() {
		return poLineId;
	}
	public void setPoLineId(Double poLineId) {
		this.poLineId = poLineId;
	}
	
	

}
