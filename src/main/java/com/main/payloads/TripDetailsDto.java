package com.main.payloads;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class TripDetailsDto {

	private Integer id;
	private String tripID;
	private String vendorCode;
	private String route;
	private String runType;
	private String mode;
	private String vehicleNumber;
	private String vendorName;
	private String actualVechicleType;
	private String standardVechicleType;
	private String standardShipmentCapacity;
	private String standardPayloadCapacity;
	private String runStatus;
	private String originHub;
	private String originRegion;
	private String destHub;
	private String actualDeparture;
	private String actualArrival;
	private Double actualKM;
	private Double standardKM;
	private Double mileage;
	private Double ratePerKm;
	private Double routeKms;
	private Double fsBaseRate;
	private Double currentFuelRate;
	private Double fsDiff;
	private Double basicFreight;
	private Double fs;
	private Double totalFreight;
	/*
	 * @NotNull
	 * 
	 * @NotBlank
	 * 
	 * @Pattern(regexp = "^[0-9]{1,6}$")
	 */
	private String openingReading;
	private String closingReading;
	private String vendorTripStatus;
	private String paymentStatus;
	private String assignTo;
	private String invoiceNumber;
	private String processedOn;
	private String processedBy;
	private String lumpsomeamount;
	private String lumpsomecheckbox;
}
