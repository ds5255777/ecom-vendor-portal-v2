package com.main.payloads;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class PoInvoiceDetailsDTO {
	
	private Long id;
	private String operatingUnit;
	private String invoiceType;
	private String tradingPartner;
	private String supplierNum;
	private String supplierSite;
	private String invoiceDate;
	private String poInvoiceNumber;
	private String invoiceNumber;
	private String vendorInvoiceNumber;
	private String invoiceCurrency;
	private String invoiceAmount;
	private Date glDate;
	private String paymentCurrency;
	private String matchOption;
	private String termsDate;
	private String terms;
	private String paymentMethod;
	private String payGroup;
	private String remitToBankAccountName;
	private String remitToBankAccountNumber;
	private Date supplierInvoiceDate;
	private String supplierInvoiceNumber;
	private String vendorCode;
	private String account;
	private String poNumber;
	private String status;
	private String lineType;
	private String amount;
	private String grossTotalAmt;
	private String assignTo;
	private Date raisedOn;
	private String raisedBy;
	private Date glDateDistributionDate;
	private List<PoInvoiceLineDTO> poInvoiceLine;
	private String invoiceFileName;
	private String invoiceFileText;
	private String documentFileOneName;
	private String documentFileOneText;


}
