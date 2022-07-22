package com.main.payloads;

import java.util.Date;

import lombok.Data;

@Data
public class PoLineDetailsDTO {

	private Long id;
	private Double poLineId;
	private String lineNumber;
	private String itemType;
	private String item;
	private String category;
	private String description;
	private String uom;
	private Double quantity;
	private Date needByDate;
	private Double price;
	private Double amount;
	private String chargeAccount;
	private String remaningQuatity;
	
}
