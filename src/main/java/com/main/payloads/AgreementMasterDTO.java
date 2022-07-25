package com.main.payloads;

import lombok.Data;

@Data
public class AgreementMasterDTO {

	 	private Long id;
	    private String cityName;
	    private double currentFuelRate;
	    private String type;
	    private String zone;
	    private String city;
	    private String vendorName;
	    private String vehicleType;
	    private String route;
	    private String tripDetails;
	    private double rate;
	    private double tripCost;
	    private double baseRate;
	    private double stdMileagePerKm;
	    private double maxKms;
	    private String creditPeriodInDays;
	    private String agreementMadeDate;
	    private String agreementExpiryDate;
	    private String vendorCode;
	    private String state;
	    private String fixedKm;
	    private Double fsDiff;

}
