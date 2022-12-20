package com.main.db.bpaas.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Data;

@Entity
@Table(name = "SupDetails")
@Data

@NamedQueries({ // @NamedQuery(name = "SupDetails.findPendindSupp", query = "select t from
				// SupDetails t where t.supStatus = 'Pending'"),
//@NamedQuery(name = "SupDetails.findApprovedSupp", query = "select t from SupDetails t where t.supStatus = 'Approved'")
//    @NamedQuery(name = "TicketDetails.findByUserIdFive", query = "select t from TicketDetails t where t.raisedBy = :raisedBy ORDER BY t.raisedOn DESC")
})
public class SupDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "pid")
	private String pid;
	@Column(name = "vendor_type")
	private String vendorType;
	@Column(name = "introduced_by_name")
	private String introducedByName;
	@Column(name = "introduced_by_email_id")
	private String introducedByEmailID;
	@Column(name = "bp_code")
	private String bpCode;

	@Column(name = "supp_name")
	private String suppName;

	@Column(name = "referral_email_id")
	private String referralEmailId;

	@Column(name = "aadhar_number")
	private String aadharNumber;
	@Column(name = "pan_number")
	private String panNumber;
	@Column(name = "tan_number")
	private String tanNumber;
	@Column(name = "adhar_link_status")
	private String adharLinkStatus;

	@Column(name = "e_Invoice_Applicable")
	private String enInvApplicable;
	
	@Column(name = "commercial_flag")
	private Integer commercialFlag;

	private String businessClassification;
	@Column(name = "site_dff")
	private String siteDff;
	@Column(name = "ope_unit_req_map")
	private String opeUnitReqMap;
	@Column(name = "ven_status")
	private String venStatus;

	@Column(name = "invoice_currency")
	private String invoiceCurrency;
	@Column(name = "payment_currency")
	private String paymentCurrency;
	@Column(name = "credit_terms")
	private String creditTerms;
	@Column(name = "payment_method")
	private String paymentMethod;
	@Column(name = "date_basis")
	private String dateBasis;
	@Column(name = "delivery_terms")
	private String deliveryTerms;

	@Column(name = "tds_application")
	private String tdsApplication;
	@Column(name = "tds_section")
	private String tdsSection;
	@Column(name = "tds_rate")
	private String tdsRate;

	@Column(name = "fy_year1")
	private String fyYear1;
	@Column(name = "acknowledgement_number1")
	private String acknowledgementNumber1;

	@Column(name = "fy_year2")
	private String fyYear2;
	@Column(name = "acknowledgement_number2")
	private String acknowledgementNumber2;

	@Column(name = "fy_year3")
	private String fyYear3;
	@Column(name = "acknowledgement_number3")
	private String acknowledgementNumber3;

	@Column(name = "mesme_Number")
	private String mesmeNumber;

	@Column(name = "section_Type")
	private String sectionType;
	
	@Column(name = "processed_on")
	private String processedOn;

	@Column(name = "processed_by")
	private String processedBy;

	@Column(name = "ERO")
	private String ero;
	@Column(name = "WRO")
	private String wro;
	@Column(name = "NRO")
	private String nro;
	@Column(name = "SRO")
	private String sro;
	@Column(name = "IHQ")
	private String ihq;

	@Column(name = "create_date")
	private String createDate;

	@Column(name = "flag")
	private String flag;

	@Column(name = "ADDRESS_PURCHASING_FLAG")
	private String addressPurchasingFlag;
	@Column(name = "ADDRESS_PAYMENT_FLAG")
	private String addressPaymentFlag;
	@Column(name = "INVOICE_PREVALIDATED_FLAG")
	private String invoicePrevalidatedFlag;

	@OneToMany(targetEntity = AccountDetails.class, cascade = CascadeType.ALL)
	@JoinColumn(name = "sa_fk", referencedColumnName = "id")
	private List<AccountDetails> accountDetails;

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn
	private List<AddressDetails> addressDetails;

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn
	private List<ContactDetails> contactDetails;

	@Transient
	String gstFileText;
	@Transient
	String gstFileName;

	@Transient
	String panFileText;
	@Transient
	String panFileName;

	@Transient
	String pdFileText;
	@Transient
	String pdFileName;

	@Transient
	String ccFileText;
	@Transient
	String ccFileName;

	@Transient
	String acFileText;
	@Transient
	String acFileName;

	@Transient
	String aplFileText;
	@Transient
	String aplFileName;

	@Transient
	String fuvfFileText;
	@Transient
	String fuvfFileName;

	@Transient
	String msmecFileText;
	@Transient
	String msmecFileName;

	@Transient
	String amFileText;
	@Transient
	String amFileName;

	@Transient
	String itrFileText;
	@Transient
	String itrFileName;

	@Transient
	String nmisFileText;
	@Transient
	String nmisFileName;

	@Transient
	String itraFileText1;
	@Transient
	String itraFileName1;

	@Transient
	String itraFileText2;
	@Transient
	String itraFileName2;

	@Transient
	String itraFileText3;
	@Transient
	String itraFileName3;

}
