package com.main.db.bpaas.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "Po_Details")
@Data
public class PoDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "PO_Number")
	private String poNo;
	@Column(name = "Type")
	private String type;

	@Column(name = "Buyer")
	private String buyer;
	@Column(name = "Currency")
	private String currency;

	@Column(name = "Status")
	private String status;

	@Column(name = "Operating_Unit")
	private String operatingUnit;
	@Column(name = "Supplier")
	private String supplier;
	@Column(name = "Ship_To")
	private String shipTo;
	@Column(name = "Bill_To")
	private String billTo;

	@Column(name = "need_By_Date")
	private Date needByDate;

	@Column(name = "Supplier_Site")
	private String supplierSite;

	@Column(name = "Invoice_Match_option")
	private String invoiceMatchoption;

	@Column(name = "Match_Approval_Level")
	private String matchApprovalLevel;

	@Column(name = "Accrue_at_Receipt_flag")
	private String accrueatReceiptflag;
	@Column(name = "Deliver_To")
	private String deliverTo;

	@Column(name = "Process_By")
	private String processBy;
	@Column(name = "Process_On")
	private String processOn;

	@Column(name = "vendor_code")
	private String vendorCode;

	@Column(name = "Item_Type")
	private String itemType;

	@Column(name = "Charge_Account")
	private String chargeAccount;

	@Column(name = "UOM")
	private String uom;
	@Column(name = "Quantity")
	private Double quantity;
	@Column(name = "Amount")
	private Double amount;

	@Column(name = "invoice_number")
	private String invoiceNumber;

	@Column(name = "name")
	private String name;
	@Column(name = "short_code")
	private String shortCode;
	@Column(name = "organization_id")
	private String organizationId;
	@Column(name = "type_lookup_code")
	private String typeLookupCode;

	@Column(name = "processed_On")
	private Date processedOn;

	@Column(name = "proc essed_By")
	private String processedBy;

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn
	private List<PoLineDetails> poline;

}
