package com.main.bean;

import java.util.List;

import com.main.db.bpaas.entity.InvoiceLineItem;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InvoiceQueryDto {

	private Long id;
	private String ecomInvoiceNumber;
	private String vendorCode;
	private String vendorName;
	private String siteName;
	private String invoiceDate;
	private String invoiceNumber;
	private String invoiceCurrency;
	private String invoiceAmount;
	private String invoiceReceivingDate;
	private String vehicleNumber;
	private String invoiceStatus;
	private String assignTo;
	private String taxableAmount;
	private String taxAmount;
	private String invoiceFileName;
	private String invoiceFileText;
	private String documentFileOneName;
	private String documentFileOneText;
	private String documentFileTwoName;
	private String documentFileTwoText;
	private String remarks;
	private List<InvoiceLineItem> invoiceLineItems;
}
