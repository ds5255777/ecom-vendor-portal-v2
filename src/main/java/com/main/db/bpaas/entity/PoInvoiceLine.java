package com.main.db.bpaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "Poinvoice_Line")
@Data
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

	@Column(name = "remaning_quatity")
	private String remaningQuatity;

	@Column(name = "base_Amount")
	private String baseAmount;
	@Column(name = "Quantity")
	private String quantity;
	@Column(name = "tax_Amount")
	private String taxAmount;
	@Column(name = "taxper")
	private String taxper;
	@Column(name = "total_Amount")
	private String totalAmount;
	@Column(name = "Line_Number")
	private String lineNumber;
	@Column(name = "Po_Line_Id")
	private Double poLineId;

}
