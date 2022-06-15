package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "invoice_line_item")
public class InvoiceLineItem {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "trip_id")
	private String tripID;

	@Column(name = "run_type")
	private String runType;

	@Column(name = "standard_km")
	private String standardKM;

	@Column(name = "rate_per_km")
	private String ratePerKm;

	@Column(name = "route")
	private String route;

	@Column(name = "current_fuel_rate")
	private String currentFuelRate;

	@Column(name = "fs_base_rate")
	private String fsBaseRate;

	@Column(name = "fs_diff")
	private String fsDiff;

	@Column(name = "basic_freight")
	private String basicFreight;

	@Column(name = "fs")
	private String fs;

	@Column(name = "actual_km")
	private String actualKM;

	@Column(name = "total_freight")
	private String totalFreight;

	@Column(name = "standard_vechicle_type")
	private String standardVechicleType;

	@Column(name = "mileage")
	private Double mileage;

	@Column(name = "lumpsome_amount")
	private String lumpsomeamount;

	@Column(name = "line_level_description")
	private String lineLevelDescription;

	@Transient
	private String newAdded;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTripID() {
		return tripID;
	}

	public void setTripID(String tripID) {
		this.tripID = tripID;
	}

	public String getRunType() {
		return runType;
	}

	public void setRunType(String runType) {
		this.runType = runType;
	}

	public String getStandardKM() {
		return standardKM;
	}

	public void setStandardKM(String standardKM) {
		this.standardKM = standardKM;
	}

	public String getRatePerKm() {
		return ratePerKm;
	}

	public void setRatePerKm(String ratePerKm) {
		this.ratePerKm = ratePerKm;
	}

	public String getCurrentFuelRate() {
		return currentFuelRate;
	}

	public void setCurrentFuelRate(String currentFuelRate) {
		this.currentFuelRate = currentFuelRate;
	}

	public String getFsBaseRate() {
		return fsBaseRate;
	}

	public void setFsBaseRate(String fsBaseRate) {
		this.fsBaseRate = fsBaseRate;
	}

	public String getFsDiff() {
		return fsDiff;
	}

	public void setFsDiff(String fsDiff) {
		this.fsDiff = fsDiff;
	}

	public String getRoute() {
		return route;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	public String getBasicFreight() {
		return basicFreight;
	}

	public void setBasicFreight(String basicFreight) {
		this.basicFreight = basicFreight;
	}

	public String getFs() {
		return fs;
	}

	public void setFs(String fs) {
		this.fs = fs;
	}

	public String getActualKM() {
		return actualKM;
	}

	public void setActualKM(String actualKM) {
		this.actualKM = actualKM;
	}

	public String getTotalFreight() {
		return totalFreight;
	}

	public void setTotalFreight(String totalFreight) {
		this.totalFreight = totalFreight;
	}

	public String getLumpsomeamount() {
		return lumpsomeamount;
	}

	public void setLumpsomeamount(String lumpsomeamount) {
		this.lumpsomeamount = lumpsomeamount;
	}

	public String getLineLevelDescription() {
		return lineLevelDescription;
	}

	public void setLineLevelDescription(String lineLevelDescription) {
		this.lineLevelDescription = lineLevelDescription;
	}

	public String getStandardVechicleType() {
		return standardVechicleType;
	}

	public void setStandardVechicleType(String standardVechicleType) {
		this.standardVechicleType = standardVechicleType;
	}

	public Double getMileage() {
		return mileage;
	}

	public void setMileage(Double mileage) {
		this.mileage = mileage;
	}

	public String getNewAdded() {
		return newAdded;
	}

	public void setNewAdded(String newAdded) {
		this.newAdded = newAdded;
	}

}
