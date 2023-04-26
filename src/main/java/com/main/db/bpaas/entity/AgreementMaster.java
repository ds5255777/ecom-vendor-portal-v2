package com.main.db.bpaas.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "Agreement_Master")
@Data
public class AgreementMaster {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "city_name")
	private String cityName;
	@Column(name = "current_Fuel_Rate")
	private double currentFuelRate;

	@Column(name = "type")
	private String type;

	@Column(name = "zone")
	private String zone;

	@Column(name = "city")
	private String city;

	@Column(name = "vendor_name")
	private String vendorName;
	@Column(name = "vehicle_type")
	private String vehicleType;
	@Column(name = "route")
	private String route;

	@Column(name = "trip_details")
	private String tripDetails;

	@Column(name = "rate")
	private double rate;
	@Column(name = "trip_cost")
	private double tripCost;
	@Column(name = "base_rate")
	private double baseRate;
	@Column(name = "std_mileage_per_km")
	private double stdMileagePerKm;
	@Column(name = "max_kms")
	private double maxKms;

	@Column(name = "Credit_period_in_days")
	private String creditPeriodInDays;

	@Column(name = "agreement_made_date")
	private String agreementMadeDate;
	@Column(name = "agreement_expiry_date")
	private String agreementExpiryDate;
	@Column(name = "vendor_code")
	private String vendorCode;
	@Column(name = "state")
	private String state;

	// new Column added

	@Column(name = "mode")
	private String mode;

	@Column(name = "origin")
	private String origin;

	@Column(name = "lastFuelUpdatedDate")
	private Date lastFuelUpdatedDate;
	@Column(name = "typeOfFuel")
	private String typeOfFuel;

	@Column(name = "Contract_No")
	private String contractNo;

	@Column(name = "fs_diff")
	private Double fsDiff;

	@Column(name = "status")
	private String status;

	@Column(name = "update_by")
	private String updateBy;

}
