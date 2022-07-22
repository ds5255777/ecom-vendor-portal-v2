package com.main.payloads;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InvoiceLineItemDto {

	private Long id;
	private String tripID;
	private String runType;
	private String standardKM;
	private String ratePerKm;
	private String route;
	private String currentFuelRate;
	private String fsBaseRate;
	private String fsDiff;
	private String basicFreight;
	private String fs;
	private String actualKM;
	private String totalFreight;
	private String standardVechicleType;
	private Double mileage;
	private String lumpsomeamount;
	private String lineLevelDescription;
	private String newAdded;

}
