package com.main.payloads;

import java.util.List;

import com.main.db.bpaas.entity.InvoiceLineItem;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InvoiceGenerationDto {

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
	private String invoiceStatus;// Processed, Approved, Rejected
	private String assignTo;// network Team, Vendor
	private String processedOn;//
	private String processedBy;//
	private String hsnCode;//
	private String greenTax;//
	private String extraKmRate;//
	private String miscellaneous;//
	private String exteraKM;//
	private String ratePerKm;//
	private String taxableAmount;
	private String taxAmount;
	private List<InvoiceLineItem> invoiceLineItem;
	private String invoiceFileName;
	private String invoiceFileText;
	private String documentFileOneName;
	private String documentFileOneText;
	private String documentFileTwoName;
	String documentFileTwoText;

}
