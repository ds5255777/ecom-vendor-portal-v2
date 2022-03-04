package com.main.commonclasses;

import org.springframework.beans.factory.annotation.Value;

public class GlobalConstants {

//	Status for entry

	@Value("${ipPath}")
	public static String ipPath;

	public static final String APPLICATION_IP = ipPath;

	public static final String ACTIVE_STATUS = "1";
	public static final String INACTIVE_STATUS = "0";
	public static final String DELETED_STATUS = "2";
	public static final String CHANGE_PASSWORD_STATUS = "3";

//	Status for USER

	public static final String AUDITOR_AVAILABLE = "available";
	public static final String AUDITOR_NOT_AVAILABLE = "notAvailable";
	public static final String AUDIT_REQUIRED = "Yes";
	public static final String AUDIT_NOT_REQUIRED = "No";

	// Roles Of user
	public static final String ROLE_TPIA = "TPIA";
	public static final String ROLE_TPIA_EMPLOYEE = "TPIA_Employee";
	public static final String ROLE_ADMIN = "Admin";
	public static final String ROLE_HO = "HO";
	public static final String ROLE_HR = "HR";
	public static final String ROLE_ERP = "ERP";
	public static final String ROLE_NAVISION = "Navision";
	public static final String ROLE_PURCHASE = "Purchase";
	public static final String ROLE_SUPPLIER = "Supplier";
	// public static final String ROLE_SITE_QUALITY = "Quality Inspector";
	public static final String ROLE_SITE_QUALITY = "Internal Inspector"; // change as per requirement (Quality Inspector
																			// same as Internal Inspector )
	public static final String ROLE_PROJECT_MANAGER = "Project Manager";
	public static final String ROLE_SITE_USER = "Site User";
	public static final String ROLE_STORE_INCHARGE = "Storage Incharge";
	public static final String ROLE_INTERNAL_INSPECTOR = "Internal Inspector";
	public static final String ROLE_O_AND_M = "O&M";

}
