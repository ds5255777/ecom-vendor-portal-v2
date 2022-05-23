package com.main.commonclasses;

public class GlobalUrl {
	
	public static String ajaxController="ajaxController";
	public static String saveRegistrationQuery=ajaxController+ "/saveRegistrationQuery";
	public static String getVendorDetailByPid=ajaxController+"/getVendorDetailByPid";
	public static String getRegistrationQueryData=ajaxController+"/getRegistrationQueryData";

    public static String userController = "userController";

    public static String saveUpdateUserDetails = userController + "/saveUpdateUserDetails";
    public static String getUserById = userController + "/getUserById";
	public static String getActiveUsersData = userController + "/getActiveUsersData";
    public static String setStatusOfUserById = userController + "/setStatusOfUserById";
    public static String checkForExistingUserName = userController + "/checkForExistingUserName";
    public static String getUserByRole = userController + "/getUserByRole";
    public static String changePassword = userController + "/changePassword";
    public static String getActiveVendorData = userController + "/getActiveVendorData";
    public static String getVendorById = userController + "/getVendorById";

    public static String emailConfigurationController = "emailConfigurationController";

    public static String saveUpdateEmailData = emailConfigurationController + "/saveUpdateEmailData";
    public static String getEmailCofigurationDataById = emailConfigurationController + "/getEmailCofigurationDataById";
    public static String getEmailCofigurationDataByStatus = emailConfigurationController + "/getEmailCofigurationDataByStatus";
    public static String updateEmailConfigurationSatatusByid = emailConfigurationController + "/updateEmailConfigurationSatatusByid";

    public static String tripControllers = "tripControllers";

    public static String getAllTripsDetails = tripControllers + "/getAllTripsDetails";
    public static String getCloseTripsDetails = tripControllers + "/getCloseTripsDetails";
    public static String getCloseAndApprovedTripsDetails = tripControllers + "/getCloseAndApprovedTripsDetails";
    public static String getInTransitTripsDetails = tripControllers + "/getInTransitTripsDetails";
    public static String getPendingApprovelTripsDetails = tripControllers + "/getPendingApprovelTripsDetails";
    public static String updateVendorTripStatusByTripId = tripControllers + "/updateVendorTripStatusByTripId";
    public static String updateVendorTripStatusAndOpenCloseReadingByTripId = tripControllers + "/updateVendorTripStatusAndOpenCloseReadingByTripId";
    public static String updateVendorTripStatusByTrips = tripControllers + "/updateVendorTripStatusByTrips";
    public static String tripDetailByTripId = tripControllers + "/tripDetailByTripId";
    public static String getRemarksByRefID = tripControllers + "/getRemarksByRefID";
    public static String status = tripControllers + "/status";
    public static String statusNetwork = tripControllers + "/statusNetwork";
    public static String filterTripDetails = tripControllers + "/filterTripDetails";
    public static String filterTripDetailsByNetwork = tripControllers + "/filterTripDetailsByNetwork";
    public static String saveTripQuery = tripControllers + "/saveTripQuery";
    public static String getDraftLineTripDetails = tripControllers + "/getDraftLineTripDetails";
    public static String getTripDetailByTripId = tripControllers + "/getTripDetailByTripId";
    public static String findByTripDetailUsingTripID = tripControllers + "/findByTripDetailUsingTripID";

    public static String invoiceController="invoiceController";
	
	public static String getAllInvoice=invoiceController+"/getAllInvoice";
	public static String getAllPendingInvoice=invoiceController+"/getAllPendingInvoice";
	public static String getAllApproveInvoice=invoiceController+"/getAllApproveInvoice";
	public static String getAllRejectInvoice=invoiceController+"/getAllRejectInvoice";
	public static String saveInvoice=invoiceController+"/saveInvoice";
	public static String getAllInvoiceToBilling=invoiceController+"/getAllInvoiceToBilling";
	public static String getLineItemDetails=invoiceController+"/getLineItemDetails";
	public static String getSelectInvoiceDetails=invoiceController+"/getSelectInvoiceDetails";
	public static String getAllDraftInvoice = invoiceController + "/getAllDraftInvoice";
	public static String deleteDraftInvoice = invoiceController + "/deleteDraftInvoice";
	public static String deleteLineItem = invoiceController + "/deleteLineItem";
	public static String deleteTripQueryInvoice = invoiceController + "/deleteTripQueryInvoice";
	public static String discardDraftInvoice = invoiceController + "/discardDraftInvoice";
	public static String checkForExistingInvoiceNumber = invoiceController + "/checkForExistingInvoiceNumber";
	public static String getAllQueryInvoiceVendor = invoiceController + "/getAllQueryInvoiceVendor";
	public static String getQueryInvoice = invoiceController + "/getQueryInvoice";
	public static String updateInvoice=invoiceController+"/updateInvoice";
	public static String addNewTripInQueryInvoice=invoiceController+"/addNewTripInQueryInvoice";
	public static String getAllQueryInvoiceVendorPo = invoiceController + "/getAllQueryInvoiceVendorPo";
	
    public static String dashboardController = "dashboardController";

    public static String getDashboardDetails = dashboardController + "/getDashboardDetails";
    public static String getDashboardDetailsForNetwork = dashboardController + "/getDashboardDetailsForNetwork";
    public static String getTripsById = tripControllers + "/getTripsById";
    public static String updateDetailsforNetwork = dashboardController + "/updateDetailsforNetwork";
    public static String getFinanceDashBoardDetails = dashboardController + "/getFinanceDashBoardDetails";
    public static String refreshValues = dashboardController + "/refreshValues";

    public static String masterController="masterController";	
    
	public static String saveTripMaster=masterController+"/saveTripMaster";
	public static String getActiveMasterData=masterController+"/getActiveMasterData";
	public static String getMasterById=masterController+"/getMasterById";
	public static String saveUpdateMasterDetails=masterController+"/saveUpdateMasterDetails";
	public static String deleteMaster=masterController+"/deleteMaster";
	
	 public static String poController="poController";
	 public static String getAllPODetails=poController+"/getAllPODetails";
	 public static String poDetailsByPoNo=poController+"/poDetailsByPoNo";
	 public static String getAllProcessPo=poController+"/getAllProcessPo";
	 public static String getAllUnProcessPo=poController+"/getAllUnProcessPo";
	 public static String getSelectPoDetails=poController+"/getSelectPoDetails";
	 public static String getAllPODetailsByPoNo=poController+"/getAllPODetailsByPoNo";
	 public static String filterPoDetails=poController+"/filterPoDetails";
	 public static String updateRemaningQuantity=poController+"/updateRemaningQuantity";
	 public static String getCurrentRemaningQty = poController + "/getCurrentRemaningQty";
	 
	 
	 
	 
	 public static String getAllInvoiceDetails=poController+"/getAllInvoiceDetails";
	 public static String getSelectInvoiceDetailsPo=poController+"/getSelectInvoiceDetailsPo";
	 public static String savePoInvoiceQuery=poController+"/savePoInvoiceQuery";
	 public static String getPoQueryData=poController+"/getPoQueryData";
	 public static String getAllPODetailsByLineNumber=poController+"/getAllPODetailsByLineNumber";
	 
	 public static String PoInvoiceContoller="PoInvoiceContoller";
	 
	 public static String getAllDraftInvoicePO=PoInvoiceContoller+"/getAllDraftInvoicePO";
	 public static String deleteDraftPoInvoice=PoInvoiceContoller+"/deleteDraftPoInvoice";
	 public static String savePoInvoice=PoInvoiceContoller+"/savePoInvoice";
	 public static String saveDraftInvoice=PoInvoiceContoller+"/saveDraftInvoice";
	 public static String updateRemaningQuantitydraft=poController+"/updateRemaningQuantitydraft";
	 
	 
	 
	 
	 
	 public static String getAllDraftPODetailsByInvoiceNo=PoInvoiceContoller+"/getAllDraftPODetailsByInvoiceNo"; 
	
	public static String financeController="financeController";
	
	public static String viewAllInvoiceForFinanceTeam=financeController+"/viewAllInvoiceForFinanceTeam";
	public static String getDocumentByInvoiceNumber=financeController+"/getDocumentByInvoiceNumber";
	public static String viewAllProcessInvoiceForFinanceTeam=financeController+"/viewAllProcessInvoiceForFinanceTeam";
	public static String viewAllUnProcessInvoiceForFinanceTeam=financeController+"/viewAllUnProcessInvoiceForFinanceTeam";
	public static String viewAllQueryInvoiceForFinanceTeam=financeController+"/viewAllQueryInvoiceForFinanceTeam";
	public static String saveQuery=financeController+"/saveQuery";
	public static String getDocumentByTypeAndForeignKey=financeController+"/getDocumentByTypeAndForeignKey";
	public static String getQueryByTypeAndForeignKey=financeController+"/getQueryByTypeAndForeignKey";
	public static String getAllInReviewInvoice=financeController+"/getAllInReviewInvoice";
	public static String getPaymentReleaseInvoice=financeController+"/getPaymentReleaseInvoice";
	public static String approveInvoiceFinanceSide=financeController+"/approveInvoiceFinanceSide";
	public static String filterInvoiceDetails=financeController+"/filterInvoiceDetails";
	public static String getFilterInvoiceByVendorCode=financeController+"/getFilterInvoiceByVendorCode";
	public static String viewInvoiceForFinanceTeam=financeController+"/viewInvoiceForFinanceTeam";
}
