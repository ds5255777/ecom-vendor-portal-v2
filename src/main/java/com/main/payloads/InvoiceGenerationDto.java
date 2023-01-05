package com.main.payloads;

import java.util.List;

import lombok.Data;

@Data
public class InvoiceGenerationDto {

	private Long id;
	private String ecomInvoiceNumber;
	private String vendorCode;
	private String vendorName;
	private String siteName;
	private String invoiceDate;
	private String invoiceNumber;
	private String invoiceCurrency;
	private String irnNumber;
	private String enInvoiceApplibale;
	private String invoiceAmount;
	private String invoiceReceivingDate;
	private String invoiceStatus;
	private String assignTo;
	private String processedOn;
	private String processedBy;
	private String hsnCode;
	private String greenTax;
	private String extraKmRate;
	private String miscellaneous;
	private String processFlow;
	private String operatingUnit;
	private String headerDes;
	private String exteraKM;
	private String ratePerKm;
	private String taxableAmount;
	private String taxAmount;
	private String pid;
	private List<InvoiceLineItemDto> invoiceLineItem;
	private String invoiceFileName;
	private String invoiceFileText;
	private String documentFileOneName;
	private String documentFileOneText;
	private String documentFileTwoName;
	String documentFileTwoText;

}
