package com.main.commonclasses;

public class GlobalConstants {

	 public static final int MAX_FAILED_ATTEMPTS = 5;
	
	public static final String VENDOR_PID_PREFIX="Vendor-00000000";
	public static final String VENDOR_PID_SUFFIX="-ECOM";
	
	public static final String ERROR_MESSAGE = "error";
	public static final String SUCCESS_MESSAGE = "success";
    public static final Integer FLAG=1;
    public static final Integer APPROVE=2;
    public static final String REJECT="Rejected by Commercial Head";
    
    
	public static final String INACTIVE_STATUS = "0";
	public static final String STATUS = "pending at commercial head";
	public static final String ACTIVE_STATUS = "1";
	public static final String DELETED_STATUS = "2";
	public static final String CHANGE_PASSWORD_STATUS = "3";
	public static final String RAISE_QUERY = "pending at vendor upon raise query";
	
	
	public static final String PENDING_REQUEST_STATUS = "Pending For Approval";
	public static final String APPROVED_REQUEST_STATUS = "Approved";
	public static final String REJECTED_REQUEST_STATUS = "Rejected";
	public static final String QUERY_REQUEST_STATUS = "Query";
	public static final String UPDATE_VENDOR = "Update";
	
	public static final String UPDATING_REQUEST_STATUS = "Profile Update";

	public static final String ROLE_FINANCE_HEAD = "Finance Head";
	public static final String ROLE_ADMIN = "Admin";
	public static final String ROLE_VENDOR = "Vendor";
	public static final String ROLE_FINANCE = "Finance";
	public static final String ROLE_NETWORK = "Network";
	public static final String ROLE_REGISTRATION_APPROVAL="Finance Registration Approval";
	public static final String ROLE_CCOMMERCIAL_TEAM="Commercial Team";

	public static final String RUN_IN_TRANSIT = "In-Transit";
	public static final String RUN_CLOSED = "Closed";

	public static final String VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED = "Yet To Be Approved";
	public static final String VENDOR_TRIP_STATUS_QUERY = "Query";
	public static final String VENDOR_TRIP_STATUS_APPROVED = "Approved";
	public static final String VENDOR_TRIP_STATUS_INVOICING = "Invoicing";
	public static final String VENDOR_TRIP_STATUS_DRAFT_INVOICING = "Draft-Invoicing";
	
	public static final String NETWORK_TRIP_STATUS_YET_TO_APPROVED_NETWORK="Yet To Be Approved By Network Team";	

	public static final String ADHOC_TYPE_TRIPS = "Adhoc";
	public static final String SCHEDULED_TYPE_TRIPS = "Scheduled";
	
	public static final String INVOICE_STATUS_IN_REVIEW="In-Review";
	public static final String INVOICE_STATUS_PENDING_APPROVAL="Pending For Approval";
	public static final String INVOICE_STATUS_APPROVED="Approved";
	public static final String INVOICE_STATUS_PAYMENT_RELASE="Payment Relase";
	public static final String INVOICE_STATUS_QUERY="Query";
	
	public static final String EMAIL_STATUS_SEND="N";
	public static final String EMAIL_STATUS_SENDING="Y";
	
	public static final String EMAIL_TYPE_VEN_TRIP_QUERY="Vendor Trip Query";
	public static final String EMAIL_TYPE_VEN_TRIP_APPROVE ="Vendor Trip Approve";
	public static final String EMAIL_TYPE_VEN_INVOICE_PROCESS="Vendor Invoice Process";
	public static final String EMAIL_TYPE_VEN_INVOICE_UPDATE="Vendor Invoice Update";
	
	public static final String EMAIL_TYPE_FIN_TEM_INVOICE_QUERY="Finance Invoice Query";
	public static final String EMAIL_TYPE_FIN_HED_INVOICE_QUERY="Finance Head Invoice Query";
	
	public static final String EMAIL_TYPE_NET_TEM_INVOICE_QUERY="Network Invoice Query";
	
	public static final String SET_TYPE_TRIP="Trip";
	public static final String SET_TYPE_INVOICE="Invoice";
	public static final String SET_TYPE_REGISTRATION="Registration";
	
	public static final String SET_FLAG_TYPE_ACTIVE="Active";
	public static final String SET_FLAG_IN_ACTIVE="In-Active";
	
	public static final String VENDOR_TYPE_NETWORK="Network";
	public static final String VENDOR_TYPE_FIXED_ASSETS="FIXED ASSETS";
	
	public static final String DATE_FORMATTER="yyyy-MM-dd HH:mm:ss";
	public static final String DATE_FORMATTER_DD_MM_YYYY="dd-MM-yyyy";
	public static final String DATE_FORMATTER_DD_MM_YYYY_HH_MM="dd-MM-yyyy HH:mm:ss";
	
	public static final String DATE_FORMATTER_YYYY_MM_DD="yyyy-MM-dd";
	
	
	public static final String VENDOR_NETWORK="Network";
	public static final String VENDOR_COURIER="COURIER";
	public static final String VENDOR_EMPLOYEE_NOMINEE="EMPLOYEE NOMINEE";
	public static final String VENDOR_RENT="RENT";
	public static final String VENDOR_FIXED_ASSETS="FIXED ASSETS";
	public static final String VENDOR_OTHER_EXPENSES="OTHER EXPENSES";
	
	public static final String VENDOR_NEW_FILE="update_";


	public static final String STATUS_ACTIVE="Active";

	public static final String DATA_NOT_FOUND = "Data Not Found";

	public static final String ROLEID_COMMERCIAL_HEAD = "Commercial Head";
	
	public static final String PENDING_FOR_COMMERCIAL_TEAM_STATUS = "Pending For Commercial Team";

	public static final String PENDING_AT_VERIFIER = "Pending at Verifier";

	public static final String ROLEID_PARTY_VERIFIER = "Verifier";

	public static final String APPROVE_BY_COMMERCIAL_HEAD = "pending at vendor";

	public static final String REJECTED_BY_VERIFIER = "Rejected by Verifier";
	
	public static final String REJECTED_BY_EHS_VERIFIER = "Rejected by Ehs Verifier";

	public static final String APPROVE_BY_VERIFIER = "Approve by Verifier";

	public static final String PENDING_AT_EHS_VERIFICATION_AT_AM_DM = "Pending For Ehs Verification at AM/DM";

	public static final String PENDING_AT_DOC_CHECKER = "Pending at Document Checker";
	
//	public static final String ROLEID_EHS_VERIFICATION = "Ehs Verification";
	
	public static final String ROLEID_EHS_AM_DM = "AM/DM";
	
	public static final String ROLEID_EHS_SENIOR_MANAGER = "Sr. Manager";
	
	public static final String ROLEID_DOC_CHECKER = "Doc Checker";
	
	public static final String PENDING_AT_SERNIOR_MANAGER = "Pending at Senior Manager For Ehs Verification";
	
	public static final String REJECTED_BY_AM_DM = "Rejected By AM/DM";
	
	public static final String REJECTED_BY_SENIOR_MANAGER = "Rejected By Senior Manager";
	
	public static final String YES = "Yes";
	
	public static final String NO = "No";
	
	public static final Integer ROLE_ID = 9;
	
	

	
	

}