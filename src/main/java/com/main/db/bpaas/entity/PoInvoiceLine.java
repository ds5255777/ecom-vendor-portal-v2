package com.main.db.bpaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Poinvoice_Line")
public class PoInvoiceLine {
	


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name = "Line_type")
	private String lineType;
	
	@Column(name = "Amount")
	private Double amount;
	
	@Column(name = "PO_Number")
	private String poNumber;
	
	@Column(name = "PO_Line")
	private String poline;
	
	@Column(name = "Receipt_Number")
	private String receiptNumber;
	
	@Column(name = "Receipt_Line")
	private String receiptline;
	
	@Column(name = "Quantity_Invoiced")
	private String quantityInvoiced;
	
	@Column(name = "UOM")
	private String uom;
	
	@Column(name = "Unit_Price")
	private Double unitPrice;
	
	@Column(name = "Description")
	private String description;
	
	@Column(name = "GL_Date")
	private Date gldate;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getLineType() {
		return lineType;
	}

	public void setLineType(String lineType) {
		this.lineType = lineType;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public String getPoNumber() {
		return poNumber;
	}

	public void setPoNumber(String poNumber) {
		this.poNumber = poNumber;
	}

	public String getPoline() {
		return poline;
	}

	public void setPoline(String poline) {
		this.poline = poline;
	}

	public String getReceiptNumber() {
		return receiptNumber;
	}

	public void setReceiptNumber(String receiptNumber) {
		this.receiptNumber = receiptNumber;
	}

	public String getReceiptline() {
		return receiptline;
	}

	public void setReceiptline(String receiptline) {
		this.receiptline = receiptline;
	}

	public String getQuantityInvoiced() {
		return quantityInvoiced;
	}

	public void setQuantityInvoiced(String quantityInvoiced) {
		this.quantityInvoiced = quantityInvoiced;
	}

	public String getUom() {
		return uom;
	}

	public void setUom(String uom) {
		this.uom = uom;
	}

	public Double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getGldate() {
		return gldate;
	}

	public void setGldate(Date gldate) {
		this.gldate = gldate;
	}
	
	
	
}
