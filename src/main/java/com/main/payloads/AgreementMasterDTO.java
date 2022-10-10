package com.main.payloads;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import lombok.Data;

@Data
public class AgreementMasterDTO {

	private Long id;
	@NotNull
	@Pattern(regexp = "^[a-zA-Z]$")
	private String cityName;
	@NotNull
	@Pattern(regexp = "/^  [+-]? ( (\\d+ (\\.\\d*)?)  |  (\\.\\d+) ) $/x")
	private double currentFuelRate;
	@NotNull
	private String type;
	private String zone;
	@NotNull
	private String city;
	@NotNull
	private String vendorName;
	@NotNull
	private String vehicleType;
	@NotNull
	private String route;
	private String tripDetails;
	@NotNull
	@Pattern(regexp = "/^  [+-]? ( (\\d+ (\\.\\d*)?)  |  (\\.\\d+) ) $/x")
	private double rate;
	@NotNull
	@Pattern(regexp = "/^  [+-]? ( (\\d+ (\\.\\d*)?)  |  (\\.\\d+) ) $/x")
	private double tripCost;
	@NotNull
	@Pattern(regexp = "/^  [+-]? ( (\\d+ (\\.\\d*)?)  |  (\\.\\d+) ) $/x")
	private double baseRate;
	@NotNull
	@Pattern(regexp = "/^  [+-]? ( (\\d+ (\\.\\d*)?)  |  (\\.\\d+) ) $/x")
	private double stdMileagePerKm;
	@NotNull
	@Pattern(regexp = "/^  [+-]? ( (\\d+ (\\.\\d*)?)  |  (\\.\\d+) ) $/x")
	private double maxKms;
	private String creditPeriodInDays;
	@NotNull
	private String agreementMadeDate;
	@NotNull
	private String agreementExpiryDate;
	@NotNull
	private String vendorCode;
	@NotNull
	private String state;
	@NotNull
	@Pattern(regexp = "/^  [+-]? ( (\\d+ (\\.\\d*)?)  |  (\\.\\d+) ) $/x")
	private String fixedKm;
	@NotNull
	@Pattern(regexp = "/^  [+-]? ( (\\d+ (\\.\\d*)?)  |  (\\.\\d+) ) $/x")
	private Double fsDiff;

}
