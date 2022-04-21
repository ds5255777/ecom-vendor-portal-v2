package com.main.commonclasses;

import org.springframework.beans.factory.annotation.Value;

public class GlobalConstants {

	@Value("${ipPath}")
	public static String ipPath;

	public static final String APPLICATION_IP = ipPath;

	public static final String ACTIVE_STATUS = "1";
	public static final String INACTIVE_STATUS = "0";
	public static final String DELETED_STATUS = "2";
	public static final String CHANGE_PASSWORD_STATUS = "3";

	public static final String ROLE_FINANCE_HEAD = "Finance Head";
	public static final String ROLE_ADMIN = "Admin";
	public static final String ROLE_VENDOR = "Vendor";
	public static final String ROLE_FINANCE = "Finance";
	public static final String ROLE_NETWORK = "Network";

	public static final String RUN_IN_TRANSIT = "In-Transit";
	public static final String RUN_CLOSED = "Closed";

	public static final String VENDOR_TRIP_STATUS_YET_TO_BE_APPROVED = "Yet To Be Approved";
	public static final String VENDOR_TRIP_STATUS_QUERY = "Query";
	public static final String VENDOR_TRIP_STATUS_APPROVED = "Approved";
	public static final String VENDOR_TRIP_STATUS_INVOICING = "Invoicing";
	public static final String VENDOR_TRIP_STATUS_DRAFT_INVOICING = "Draft-Invoicing";

	public static final String PAYMENT_STATUS = "";

}
