package com.main.payloads;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class PoDetailsDTO {

	private Long id;
	private String poNo;
	private String type;
	private String buyer;
	private String currency;
	private String status;
	private String operatingUnit;
	private String supplier;
	private String shipTo;
	private String billTo;
	private Date needByDate;
	private String supplierSite;
	private String invoiceMatchoption;
	private String matchApprovalLevel;
	private String accrueatReceiptflag;
	private String deliverTo;
	private String processBy;
	private String processOn;
	private String vendorCode;
	private String itemType;
	private String chargeAccount;
	private String uom;
	private Double quantity;
	private Double amount;
    private String invoiceNumber;
    private String name;
    private String shortCode;
    private String organizationId;
    private String typeLookupCode;
	private Date processedOn;
	private String processedBy;
	private List<PoLineDetailsDTO> poline;

	
}
