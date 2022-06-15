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

@Entity
@Table(name = "SupDetails")

@NamedQueries({ // @NamedQuery(name = "SupDetails.findPendindSupp", query = "select t from
				// SupDetails t where t.supStatus = 'Pending'"),
//@NamedQuery(name = "SupDetails.findApprovedSupp", query = "select t from SupDetails t where t.supStatus = 'Approved'")
//    @NamedQuery(name = "TicketDetails.findByUserIdFive", query = "select t from TicketDetails t where t.raisedBy = :raisedBy ORDER BY t.raisedOn DESC")
})
public class SupDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	/* Stap-1 Entity */
	@Column(name = "pid")
	private String pid;
	@Column(name = "partner_type")
	private String partnerType;
	@Column(name = "introduced_by_name")
	private String introducedByName;
	@Column(name = "introduced_by_email_id")
	private String introducedByEmailID;
	@Column(name = "bp_code")
	private String bpCode;

	@Column(name = "vendor_type")
	private String vendorType;
	@Column(name = "supp_name")
	private String suppName;
	
	@Column(name = "aadhar_number")
	private String aadharNumber;
	@Column(name = "pan_number")
	private String panNumber;
	@Column(name = "tan_number")
	private String tanNumber;
	@Column(name = "adhar_link_status")
	private String adharLinkStatus;
	private String businessClassification;
	@Column(name = "site_dff")
	private String siteDff;
	@Column(name = "ope_unit_req_map")
	private String opeUnitReqMap;
	@Column(name = "ven_status")
	private String venStatus; // 0-approved, 1-queryRaise, 2- pending

	/* payment Terms */
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

	/* tds terms */
	@Column(name = "tds_application")
	private String tdsApplication;
	@Column(name = "tds_section")
	private String tdsSection;
	@Column(name = "tds_rate")
	private String tdsRate;

	/* itr last three year */
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
	
	@Column(name = "ADDRESS_PURCHASING_FLAG")
	private String addressPurchasingFlag;
	@Column(name = "ADDRESS_PAYMENT_FLAG")
	private String addressPaymentFlag;
	@Column(name = "INVOICE_PREVALIDATED_FLAG")
	private String invoicePrevalidatedFlag;
	
	@Column(name = "gl_code")
	private String glCode;
	
	
	@OneToMany(targetEntity = AccountDetails.class, cascade = CascadeType.ALL)
	@JoinColumn(name = "sa_fk", referencedColumnName = "id")
	private List<AccountDetails> accountDetails;

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn
	private List<AddressDetails> addressDetails;

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn
	private List<ContactDetails> contactDetails;

	/*
	 * @OneToMany(cascade = CascadeType.ALL)
	 * 
	 * @JoinColumn private List<ItrDetails> itrDetails;
	 */

	/*
	 * @OneToMany(cascade = CascadeType.ALL)
	 * 
	 * @JoinColumn private List<WIHistory> wIHistory;
	 */

	/*
	 * @OneToMany(cascade = CascadeType.ALL)
	 * 
	 * @JoinColumn private List<TripDetails> tripDetails;
	 */

//	@OneToMany(cascade = CascadeType.ALL)
//	@JoinColumn
//	private List<OnboardQuery> onboardQuery;

	@Transient
	String gstFileText;
	@Transient
	String gstFileName;

	@Transient
	String pANFileText;
	@Transient
	String pANFileName;

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

	// last three year ITR report

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

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getPartnerType() {
		return partnerType;
	}

	public void setPartnerType(String partnerType) {
		this.partnerType = partnerType;
	}

	public String getBpCode() {
		return bpCode;
	}

	public void setBpCode(String bpCode) {
		this.bpCode = bpCode;
	}

	public String getIntroducedByName() {
		return introducedByName;
	}

	public void setIntroducedByName(String introducedByName) {
		this.introducedByName = introducedByName;
	}

	public String getIntroducedByEmailID() {
		return introducedByEmailID;
	}

	public String getVenStatus() {
		return venStatus;
	}

	public void setVenStatus(String venStatus) {
		this.venStatus = venStatus;
	}

	public void setIntroducedByEmailID(String introducedByEmailID) {
		this.introducedByEmailID = introducedByEmailID;
	}

	public String getVendorType() {
		return vendorType;
	}

	public void setVendorType(String vendorType) {
		this.vendorType = vendorType;
	}

	public String getSuppName() {
		return suppName;
	}

	public void setSuppName(String suppName) {
		this.suppName = suppName;
	}


	public String getAadharNumber() {
		return aadharNumber;
	}

	public void setAadharNumber(String aadharNumber) {
		this.aadharNumber = aadharNumber;
	}

	public String getPanNumber() {
		return panNumber;
	}

	public void setPanNumber(String panNumber) {
		this.panNumber = panNumber;
	}

	public String getTanNumber() {
		return tanNumber;
	}

	public void setTanNumber(String tanNumber) {
		this.tanNumber = tanNumber;
	}

	public String getAdharLinkStatus() {
		return adharLinkStatus;
	}

	public void setAdharLinkStatus(String adharLinkStatus) {
		this.adharLinkStatus = adharLinkStatus;
	}

	
	public String getBusinessClassification() {
		return businessClassification;
	}

	public void setBusinessClassification(String businessClassification) {
		this.businessClassification = businessClassification;
	}

	public String getSiteDff() {
		return siteDff;
	}

	public void setSiteDff(String siteDff) {
		this.siteDff = siteDff;
	}

	public String getOpeUnitReqMap() {
		return opeUnitReqMap;
	}

	public void setOpeUnitReqMap(String opeUnitReqMap) {
		this.opeUnitReqMap = opeUnitReqMap;
	}

	public String getInvoiceCurrency() {
		return invoiceCurrency;
	}

	public void setInvoiceCurrency(String invoiceCurrency) {
		this.invoiceCurrency = invoiceCurrency;
	}

	public String getPaymentCurrency() {
		return paymentCurrency;
	}

	public void setPaymentCurrency(String paymentCurrency) {
		this.paymentCurrency = paymentCurrency;
	}

	public String getCreditTerms() {
		return creditTerms;
	}

	public void setCreditTerms(String creditTerms) {
		this.creditTerms = creditTerms;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getDateBasis() {
		return dateBasis;
	}

	public void setDateBasis(String dateBasis) {
		this.dateBasis = dateBasis;
	}

	public String getDeliveryTerms() {
		return deliveryTerms;
	}

	public void setDeliveryTerms(String deliveryTerms) {
		this.deliveryTerms = deliveryTerms;
	}

	public String getTdsApplication() {
		return tdsApplication;
	}

	public void setTdsApplication(String tdsApplication) {
		this.tdsApplication = tdsApplication;
	}

	public String getTdsSection() {
		return tdsSection;
	}

	public void setTdsSection(String tdsSection) {
		this.tdsSection = tdsSection;
	}

	public String getTdsRate() {
		return tdsRate;
	}

	public void setTdsRate(String tdsRate) {
		this.tdsRate = tdsRate;
	}

	public List<AccountDetails> getAccountDetails() {
		return accountDetails;
	}

	public void setAccountDetails(List<AccountDetails> accountDetails) {
		this.accountDetails = accountDetails;
	}

	public List<AddressDetails> getAddressDetails() {
		return addressDetails;
	}

	public void setAddressDetails(List<AddressDetails> addressDetails) {
		this.addressDetails = addressDetails;
	}

	public List<ContactDetails> getContactDetails() {
		return contactDetails;
	}

	public void setContactDetails(List<ContactDetails> contactDetails) {
		this.contactDetails = contactDetails;
	}

	public String getGstFileText() {
		return gstFileText;
	}

	public void setGstFileText(String gstFileText) {
		this.gstFileText = gstFileText;
	}

	public String getGstFileName() {
		return gstFileName;
	}

	public void setGstFileName(String gstFileName) {
		this.gstFileName = gstFileName;
	}

	public String getpANFileText() {
		return pANFileText;
	}

	public void setpANFileText(String pANFileText) {
		this.pANFileText = pANFileText;
	}

	public String getpANFileName() {
		return pANFileName;
	}

	public void setpANFileName(String pANFileName) {
		this.pANFileName = pANFileName;
	}

	public String getPdFileText() {
		return pdFileText;
	}

	public void setPdFileText(String pdFileText) {
		this.pdFileText = pdFileText;
	}

	public String getPdFileName() {
		return pdFileName;
	}

	public void setPdFileName(String pdFileName) {
		this.pdFileName = pdFileName;
	}

	public String getCcFileText() {
		return ccFileText;
	}

	public void setCcFileText(String ccFileText) {
		this.ccFileText = ccFileText;
	}

	public String getCcFileName() {
		return ccFileName;
	}

	public void setCcFileName(String ccFileName) {
		this.ccFileName = ccFileName;
	}

	public String getAcFileText() {
		return acFileText;
	}

	public void setAcFileText(String acFileText) {
		this.acFileText = acFileText;
	}

	public String getAcFileName() {
		return acFileName;
	}

	public void setAcFileName(String acFileName) {
		this.acFileName = acFileName;
	}

	public String getAplFileText() {
		return aplFileText;
	}

	public void setAplFileText(String aplFileText) {
		this.aplFileText = aplFileText;
	}

	public String getAplFileName() {
		return aplFileName;
	}

	public void setAplFileName(String aplFileName) {
		this.aplFileName = aplFileName;
	}

	public String getItrFileText() {
		return itrFileText;
	}

	public void setItrFileText(String itrFileText) {
		this.itrFileText = itrFileText;
	}

	public String getItrFileName() {
		return itrFileName;
	}

	public void setItrFileName(String itrFileName) {
		this.itrFileName = itrFileName;
	}

	public String getFuvfFileText() {
		return fuvfFileText;
	}

	public void setFuvfFileText(String fuvfFileText) {
		this.fuvfFileText = fuvfFileText;
	}

	public String getFuvfFileName() {
		return fuvfFileName;
	}

	public void setFuvfFileName(String fuvfFileName) {
		this.fuvfFileName = fuvfFileName;
	}

	public String getMsmecFileText() {
		return msmecFileText;
	}

	public void setMsmecFileText(String msmecFileText) {
		this.msmecFileText = msmecFileText;
	}

	public String getMsmecFileName() {
		return msmecFileName;
	}

	public void setMsmecFileName(String msmecFileName) {
		this.msmecFileName = msmecFileName;
	}

	public String getAmFileText() {
		return amFileText;
	}

	public void setAmFileText(String amFileText) {
		this.amFileText = amFileText;
	}

	public String getAmFileName() {
		return amFileName;
	}

	public void setAmFileName(String amFileName) {
		this.amFileName = amFileName;
	}

	public String getNmisFileText() {
		return nmisFileText;
	}

	public void setNmisFileText(String nmisFileText) {
		this.nmisFileText = nmisFileText;
	}

	public String getNmisFileName() {
		return nmisFileName;
	}

	public void setNmisFileName(String nmisFileName) {
		this.nmisFileName = nmisFileName;
	}

	public String getItraFileText1() {
		return itraFileText1;
	}

	public void setItraFileText1(String itraFileText1) {
		this.itraFileText1 = itraFileText1;
	}

	public String getItraFileName1() {
		return itraFileName1;
	}

	public void setItraFileName1(String itraFileName1) {
		this.itraFileName1 = itraFileName1;
	}

	public String getItraFileText2() {
		return itraFileText2;
	}

	public void setItraFileText2(String itraFileText2) {
		this.itraFileText2 = itraFileText2;
	}

	public String getItraFileName2() {
		return itraFileName2;
	}

	public void setItraFileName2(String itraFileName2) {
		this.itraFileName2 = itraFileName2;
	}

	public String getItraFileText3() {
		return itraFileText3;
	}

	public void setItraFileText3(String itraFileText3) {
		this.itraFileText3 = itraFileText3;
	}

	public String getItraFileName3() {
		return itraFileName3;
	}

	public void setItraFileName3(String itraFileName3) {
		this.itraFileName3 = itraFileName3;
	}

	public String getFyYear1() {
		return fyYear1;
	}

	public void setFyYear1(String fyYear1) {
		this.fyYear1 = fyYear1;
	}

	public String getAcknowledgementNumber1() {
		return acknowledgementNumber1;
	}

	public void setAcknowledgementNumber1(String acknowledgementNumber1) {
		this.acknowledgementNumber1 = acknowledgementNumber1;
	}

	public String getFyYear2() {
		return fyYear2;
	}

	public void setFyYear2(String fyYear2) {
		this.fyYear2 = fyYear2;
	}

	public String getAcknowledgementNumber2() {
		return acknowledgementNumber2;
	}

	public void setAcknowledgementNumber2(String acknowledgementNumber2) {
		this.acknowledgementNumber2 = acknowledgementNumber2;
	}

	public String getFyYear3() {
		return fyYear3;
	}

	public void setFyYear3(String fyYear3) {
		this.fyYear3 = fyYear3;
	}

	public String getAcknowledgementNumber3() {
		return acknowledgementNumber3;
	}

	public void setAcknowledgementNumber3(String acknowledgementNumber3) {
		this.acknowledgementNumber3 = acknowledgementNumber3;
	}

	public String getMesmeNumber() {
		return mesmeNumber;
	}

	public void setMesmeNumber(String mesmeNumber) {
		this.mesmeNumber = mesmeNumber;
	}

	public String getSectionType() {
		return sectionType;
	}

	public void setSectionType(String sectionType) {
		this.sectionType = sectionType;
	}

	public String getEro() {
		return ero;
	}

	public void setEro(String ero) {
		this.ero = ero;
	}

	public String getWro() {
		return wro;
	}

	public void setWro(String wro) {
		this.wro = wro;
	}

	public String getNro() {
		return nro;
	}

	public void setNro(String nro) {
		this.nro = nro;
	}

	public String getSro() {
		return sro;
	}

	public void setSro(String sro) {
		this.sro = sro;
	}

	public String getIhq() {
		return ihq;
	}

	public void setIhq(String ihq) {
		this.ihq = ihq;
	}

	public String getGlCode() {
		return glCode;
	}

	public void setGlCode(String glCode) {
		this.glCode = glCode;
	}

	public String getAddressPurchasingFlag() {
		return addressPurchasingFlag;
	}

	public void setAddressPurchasingFlag(String addressPurchasingFlag) {
		this.addressPurchasingFlag = addressPurchasingFlag;
	}

	public String getAddressPaymentFlag() {
		return addressPaymentFlag;
	}

	public void setAddressPaymentFlag(String addressPaymentFlag) {
		this.addressPaymentFlag = addressPaymentFlag;
	}

	public String getInvoicePrevalidatedFlag() {
		return invoicePrevalidatedFlag;
	}

	public void setInvoicePrevalidatedFlag(String invoicePrevalidatedFlag) {
		this.invoicePrevalidatedFlag = invoicePrevalidatedFlag;
	}

	
	
}
