package com.main.commonclasses;

public class GlobalConstants {

	
	public static final String VENDOR_PID_PREFIX="Vendor-00000000";
	public static final String VENDOR_PID_SUFFIX="-CreationUAT";
	
	public static final String ERROR_MESSAGE = "error";
	public static final String SUCCESS_MESSAGE = "success";


	public static final String INACTIVE_STATUS = "0";
	public static final String ACTIVE_STATUS = "1";
	public static final String DELETED_STATUS = "2";
	public static final String CHANGE_PASSWORD_STATUS = "3";
	
	
	public static final String PENDING_REQUEST_STATUS = "Pending For Approval";
	public static final String APPROVED_REQUEST_STATUS = "Approved";
	public static final String REJECTED_REQUEST_STATUS = "Rejected";
	public static final String QUERY_REQUEST_STATUS = "Query";
	public static final String UPDATE_VENDOR = "Update";

	public static final String ROLE_FINANCE_HEAD = "Finance Head";
	public static final String ROLE_ADMIN = "Admin";
	public static final String ROLE_VENDOR = "Vendor";
	public static final String ROLE_FINANCE = "Finance";
	public static final String ROLE_NETWORK = "Network";
	public static final String ROLE_REGISTRATION_APPROVAL="Finance Registration Approval";

	public static final String RUN_IN_TRANSIT = "In-Transit";
	public static final String RUN_CLOSED = "Closed";

	public static final String VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED = "Yet To Be Approved";
	public static final String VENDOR_TRIP_STATUS_QUERY = "Query";
	public static final String VENDOR_TRIP_STATUS_APPROVED = "Approved";
	public static final String VENDOR_TRIP_STATUS_INVOICING = "Invoicing";
	public static final String VENDOR_TRIP_STATUS_DRAFT_INVOICING = "Draft-Invoicing";
	
	public static final String NETWORK_TRIP_STATUS_YET_TO_APPROVED_NETWORK="Yet To Be Approved By Network Team";	

	public static final String PAYMENT_STATUS = "";
	
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
	
}