package com.main.payloads;

import java.util.List;

import lombok.Data;

@Data
public class SupDetailsTransactionDTO {

	private Long id;
	private String pid;
	private String vendorType;
	private String bpCode;
	private String suppName;
	private String aadharNumber;
	private String panNumber;
	private String tanNumber;
	private String adharLinkStatus;
	private String businessClassification;

	private String processedOn;

	private String processedBy;

	private String enInvApplicable;
	private String venStatus;
	private String invoiceCurrency;
	private String paymentCurrency;
	private String creditTerms;
	private String paymentMethod;
	private String dateBasis;
	private String deliveryTerms;
	private String tdsApplication;
	private String tdsSection;
	private String tdsRate;
	private String fyYear1;
	private String acknowledgementNumber1;
	private String fyYear2;
	private String acknowledgementNumber2;
	private String fyYear3;
	private String acknowledgementNumber3;
	private String mesmeNumber;
	private String sectionType;
	private String ero;
	private String wro;
	private String nro;
	private String sro;
	private String ihq;
	private String createDate;
	private List<AccountDetailsTransactionDTO> accountDetails;
	private List<AddressDetailsTransactionDTO> addressDetails;
	private List<ContactDetailsTransactionDTO> contactDetails;
	String gstFileText;
	String gstFileName;
	String panFileText;
	String panFileName;
	String pdFileText;
	String pdFileName;
	String ccFileText;
	String ccFileName;
	String acFileText;
	String acFileName;
	String aplFileText;
	String aplFileName;
	String fuvfFileText;
	String fuvfFileName;
	String msmecFileText;
	String msmecFileName;
	String amFileText;
	String amFileName;
	String itrFileText;
	String itrFileName;
	String nmisFileText;
	String nmisFileName;
	String itraFileText1;
	String itraFileName1;
	String itraFileText2;
	String itraFileName2;

	String itraFileText3;
	String itraFileName3;

}
