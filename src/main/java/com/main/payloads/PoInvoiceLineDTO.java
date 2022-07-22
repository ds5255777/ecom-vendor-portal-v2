package com.main.payloads;

import java.util.Date;

import lombok.Data;

@Data
public class PoInvoiceLineDTO {
	
	private Long id;
	private String lineType;
	private Double amount;
	private String poNumber;
	private String poline;
	private String receiptNumber;
	private String receiptline;
	private String quantityInvoiced;
	private String uom;
	private Double unitPrice;
	private String description;
	private Date gldate;
	private String remaningQuatity;
	private String baseAmount;
	private String quantity;
	private String taxAmount;
	private String taxper;
	private String totalAmount;
	private String lineNumber;
	private Double poLineId;


}
