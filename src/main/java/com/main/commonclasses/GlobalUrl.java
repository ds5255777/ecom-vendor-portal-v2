package com.main.commonclasses;

public class GlobalUrl {

	public static String userController="userController";	
	
	public static String saveUpdateUserDetails=userController+"/saveUpdateUserDetails";
	public static String getUserById=userController+"/getUserById";
	public static String getActiveUsersData=userController+"/getActiveUsersData";
	public static String setStatusOfUserById=userController+"/setStatusOfUserById";
	public static String checkForExistingUserName=userController+"/checkForExistingUserName";
	public static String getUserByRole=userController+"/getUserByRole";
	public static String changePassword=userController+"/changePassword";
	
	public static String emailConfigurationController="emailConfigurationController";
	
	public static String saveUpdateEmailData=emailConfigurationController+"/saveUpdateEmailData";
	public static String getEmailCofigurationDataById=emailConfigurationController+"/getEmailCofigurationDataById";
	public static String getEmailCofigurationDataByStatus=emailConfigurationController+"/getEmailCofigurationDataByStatus";
	public static String updateEmailConfigurationSatatusByid=emailConfigurationController+"/updateEmailConfigurationSatatusByid";
	
	public static String tripControllers="tripControllers";
	
	public static String getAllTripsDetails=tripControllers+"/getAllTripsDetails";
	public static String getCloseTripsDetails=tripControllers+"/getCloseTripsDetails";
	public static String getCloseAndApprovedTripsDetails=tripControllers+"/getCloseAndApprovedTripsDetails";
	public static String getInTransitTripsDetails=tripControllers+"/getInTransitTripsDetails";
	public static String getPendingApprovelTripsDetails=tripControllers+"/getPendingApprovelTripsDetails";
	public static String updateVendorTripStatusByTripId=tripControllers+"/updateVendorTripStatusByTripId";
	public static String tripDetailByTripId=tripControllers+"/tripDetailByTripId";
	public static String status=tripControllers+"/status";
	public static String filterTripDetails=tripControllers+"/filterTripDetails";
	public static String saveTripQuery=tripControllers+"/saveTripQuery";
	//public static String dateFilter=tripControllers+"/searchTripDetailsFromDate";
	
	
	public static String invoiceController="invoiceController";
	
	public static String getAllInvoice=invoiceController+"/getAllInvoice";
	public static String getAllPendingInvoice=invoiceController+"/getAllPendingInvoice";
	public static String getAllApproveInvoice=invoiceController+"/getAllApproveInvoice";
	public static String getAllRejectInvoice=invoiceController+"/getAllRejectInvoice";
	public static String saveInvoice=invoiceController+"/saveInvoice";
	public static String getAllInvoiceToBilling=invoiceController+"/getAllInvoiceToBilling";
	public static String getLineItemDetails=invoiceController+"/getLineItemDetails";
	
	public static String dashboardController="dashboardController";
	
	public static String getDashboardDetails=dashboardController+"/getDashboardDetails";
	
		
}
