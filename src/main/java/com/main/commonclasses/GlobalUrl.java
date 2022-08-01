package com.main.commonclasses;

public class GlobalUrl {
	
	public static final String ajaxController="ajaxController";
	
	public static final String saveRegistrationQuery=ajaxController+ "/saveRegistrationQuery";
	public static final String getVendorDetailByPid=ajaxController+"/getVendorDetailByPid";
	public static final String getBpcode=ajaxController+"/getBpcode";
	public static final String checkExistingPan=ajaxController+"/checkExistingPan";
	public static final String getRegistrationQueryData=ajaxController+"/getRegistrationQueryData";

	public static final String userController = "userController";

    public static final String saveUpdateUserDetails = userController + "/saveUpdateUserDetails";
    public static final String getUserById = userController + "/getUserById";
	public static final String getActiveUsersData = userController + "/getActiveUsersData";
    public static final String setStatusOfUserById = userController + "/setStatusOfUserById";
    public static final String checkForExistingUserName = userController + "/checkForExistingUserName";
    public static final String getUserByRole = userController + "/getUserByRole";
    public static final String changePassword = userController + "/changePassword";
    public static final String getActiveVendorData = userController + "/getActiveVendorData";
    public static final String getVendorById = userController + "/getVendorById";

    public static final String emailConfigurationController = "emailConfigurationController";

    public static final String saveUpdateEmailData = emailConfigurationController + "/saveUpdateEmailData";
    public static final String getEmailCofigurationDataById = emailConfigurationController + "/getEmailCofigurationDataById";
    public static final String getEmailCofigurationDataByStatus = emailConfigurationController + "/getEmailCofigurationDataByStatus";
    public static final String updateEmailConfigurationSatatusByid = emailConfigurationController + "/updateEmailConfigurationSatatusByid";
    public static final String sendEmailToVendor = emailConfigurationController + "/sendEmailToVendor";
    public static final String getAllSentEmail = emailConfigurationController + "/getAllSentEmail";
    

    public static final String tripControllers = "tripControllers";

    public static final String getAllTripsDetails = tripControllers + "/getAllTripsDetails";
    public static final String getCloseTripsDetails = tripControllers + "/getCloseTripsDetails";
    public static final String getCloseAndApprovedTripsDetails = tripControllers + "/getCloseAndApprovedTripsDetails";
    public static final String getInTransitTripsDetails = tripControllers + "/getInTransitTripsDetails";
    public static final String getPendingApprovelTripsDetails = tripControllers + "/getPendingApprovelTripsDetails";
    public static final String updateVendorTripStatusAndOpenCloseReadingByTripId = tripControllers + "/updateVendorTripStatusAndOpenCloseReadingByTripId";
    public static final String updateVendorTripStatusByTrips = tripControllers + "/updateVendorTripStatusByTrips";
    public static final String tripDetailByTripId = tripControllers + "/tripDetailByTripId";
    public static final String getRemarksByRefID = tripControllers + "/getRemarksByRefID";
    public static final String status = tripControllers + "/status";
    public static final String multipleTripApproved = tripControllers + "/multipleTripApproved";
    public static final String filterTripDetails = tripControllers + "/filterTripDetails";
    public static final String saveTripQuery = tripControllers + "/saveTripQuery";
    public static final String getDraftLineTripDetails = tripControllers + "/getDraftLineTripDetails";
    public static final String getTripDetailByTripId = tripControllers + "/getTripDetailByTripId";
    public static final String findByTripDetailUsingTripID = tripControllers + "/findByTripDetailUsingTripID";
    public static final String filterByColumn = tripControllers + "/filterByColumn";

    public static final String invoiceController="invoiceController";
	
	public static final String getAllInvoice=invoiceController+"/getAllInvoice";
	public static final String getAllPendingInvoice=invoiceController+"/getAllPendingInvoice";
	public static final String getAllApproveInvoice=invoiceController+"/getAllApproveInvoice";
	public static final String getAllRejectInvoice=invoiceController+"/getAllRejectInvoice";
	public static final String saveInvoice=invoiceController+"/saveInvoice";
	public static final String getAllInvoiceToBilling=invoiceController+"/getAllInvoiceToBilling";
	public static final String getLineItemDetails=invoiceController+"/getLineItemDetails";
	public static final String getSelectInvoiceDetails=invoiceController+"/getSelectInvoiceDetails";
	public static final String getAllDraftInvoice = invoiceController + "/getAllDraftInvoice";
	public static final String deleteDraftInvoice = invoiceController + "/deleteDraftInvoice";
	public static final String deleteLineItem = invoiceController + "/deleteLineItem";
	public static final String deleteTripQueryInvoice = invoiceController + "/deleteTripQueryInvoice";
	public static final String discardDraftInvoice = invoiceController + "/discardDraftInvoice";
	public static final String checkForExistingInvoiceNumber = invoiceController + "/checkForExistingInvoiceNumber";
	public static final String getAllQueryInvoiceVendor = invoiceController + "/getAllQueryInvoiceVendor";
	public static final String getQueryInvoice = invoiceController + "/getQueryInvoice";
	public static final String updateInvoice=invoiceController+"/updateInvoice";
	public static final String addNewTripInQueryInvoice=invoiceController+"/addNewTripInQueryInvoice";
	public static final String getAllQueryInvoiceVendorPo = invoiceController + "/getAllQueryInvoiceVendorPo";
	
    public static final String dashboardController = "dashboardController";

    public static final String getDashboardDetails = dashboardController + "/getDashboardDetails";
    public static final String getDashboardDetailsForNetwork = dashboardController + "/getDashboardDetailsForNetwork";
    public static final String getTripsById = tripControllers + "/getTripsById";
    public static final String updateDetailsforNetwork = dashboardController + "/updateDetailsforNetwork";
    public static final String getFinanceDashBoardDetails = dashboardController + "/getFinanceDashBoardDetails";
    public static final String refreshValues = dashboardController + "/refreshValues";

    public static final String masterController="masterController";	
    
	public static final String saveTripMaster=masterController+"/saveTripMaster";
	public static final String getActiveMasterData=masterController+"/getActiveMasterData";
	public static final String getMasterById=masterController+"/getMasterById";
	public static final String saveUpdateMasterDetails=masterController+"/saveUpdateMasterDetails";
	public static final String deleteMaster=masterController+"/deleteMaster";
	
	 public static final String poController="poController";
	 public static final String getAllPODetails=poController+"/getAllPODetails";
	 public static final String poDetailsByPoNo=poController+"/poDetailsByPoNo";
	 public static final String getAllProcessPo=poController+"/getAllProcessPo";
	 public static final String getAllUnProcessPo=poController+"/getAllUnProcessPo";
	 public static final String getSelectPoDetails=poController+"/getSelectPoDetails";
	 public static final String getAllPODetailsByPoNo=poController+"/getAllPODetailsByPoNo";
	 public static final String filterPoDetails=poController+"/filterPoDetails";
	 public static final String updateRemaningQuantity=poController+"/updateRemaningQuantity";
	 public static final String getCurrentRemaningQty = poController + "/getCurrentRemaningQty";
	 public static final String getAllInvoiceDetails=poController+"/getAllInvoiceDetails";
	 public static final String getSelectInvoiceDetailsPo=poController+"/getSelectInvoiceDetailsPo";
	 public static final String savePoInvoiceQuery=poController+"/savePoInvoiceQuery";
	 public static final String getPoQueryData=poController+"/getPoQueryData";
	 public static final String getAllPODetailsByLineNumber=poController+"/getAllPODetailsByLineNumber";
	 
	 public static final String PoInvoiceContoller="PoInvoiceContoller";
	 
	 public static final String getAllDraftInvoicePO=PoInvoiceContoller+"/getAllDraftInvoicePO";
	 public static final String deleteDraftPoInvoice=PoInvoiceContoller+"/deleteDraftPoInvoice";
	 public static final String savePoInvoice=PoInvoiceContoller+"/savePoInvoice";
	 public static final String saveDraftInvoice=PoInvoiceContoller+"/saveDraftInvoice";
	 public static final String updateRemaningQuantitydraft=poController+"/updateRemaningQuantitydraft";
	 public static final String getAllDraftPODetailsByInvoiceNo=PoInvoiceContoller+"/getAllDraftPODetailsByInvoiceNo"; 
	
	public static final String financeController="financeController";
	
	public static final String viewAllInvoiceForFinanceTeam=financeController+"/viewAllInvoiceForFinanceTeam";
	public static final String getDocumentByInvoiceNumber=financeController+"/getDocumentByInvoiceNumber";
	public static final String viewAllProcessInvoiceForFinanceTeam=financeController+"/viewAllProcessInvoiceForFinanceTeam";
	public static final String viewAllUnProcessInvoiceForFinanceTeam=financeController+"/viewAllUnProcessInvoiceForFinanceTeam";
	public static final String viewAllQueryInvoiceForFinanceTeam=financeController+"/viewAllQueryInvoiceForFinanceTeam";
	public static final String saveQuery=financeController+"/saveQuery";
	public static final String getDocumentByTypeAndForeignKey=financeController+"/getDocumentByTypeAndForeignKey";
	public static final String getQueryByTypeAndForeignKey=financeController+"/getQueryByTypeAndForeignKey";
	public static final String getAllInReviewInvoice=financeController+"/getAllInReviewInvoice";
	public static final String getPaymentReleaseInvoice=financeController+"/getPaymentReleaseInvoice";
	public static final String approveInvoiceFinanceSide=financeController+"/approveInvoiceFinanceSide";
	public static final String filterInvoiceDetails=financeController+"/filterInvoiceDetails";
	public static final String getFilterInvoiceByVendorCode=financeController+"/getFilterInvoiceByVendorCode";
	public static final String viewInvoiceForFinanceTeam=financeController+"/viewInvoiceForFinanceTeam";
	
	 public static final String setStatusOfVendorByBpCode = userController + "/setStatusOfVendorByBpCode";
	 public static final String getAllVendorStatus = userController + "/getAllVendorStatus";
	 public static final String activeVendor = userController + "/activeVendor";
	 
	 public static final String getBpCodeForNetwork = dashboardController + "/getBpCodeForNetwork";
	 public static final String getAllVendors = dashboardController + "/getAllVendors";
	 
	 public static final String registrationController="registrationController";
	 public static final String getPendingRequest = registrationController + "/getPendingRequest";
	 public static final String getApprovedRequest = registrationController + "/getApprovedRequest";
	 public static final String getRejectedRequest = registrationController + "/getRejectedRequest";
	 public static final String getQueryRequest = registrationController + "/getQueryRequest";
	 
	 
	 public static final String approveRequest = registrationController + "/approveRequest";
	 public static final String rejectedRequest = registrationController + "/rejectedRequest";
	 
	 public static final String getAllRequest = registrationController + "/getAllRequest";
	 
	 public static final String updateVendorRegistrationStatus = registrationController + "/updateVendorRegistrationStatus";
		public static final String getAllApprovedVendor = registrationController + "/getAllApprovedVendor";
	 
}
