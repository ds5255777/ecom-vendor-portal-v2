package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Agreement_Master")
public class AgreementMaster {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "current_Fuel_Rate")
    private double currentFuelRate;
    
    @Column(name = "Type")
    private String type;
    
    @Column(name = "Sr_No")
    private String srNo;
    
    @Column(name = "Zone")
    private String zone;
    
    @Column(name = "City")
    private String city;
    
    @Column(name = "Vendor_Name")
    private String vendorName;
    @Column(name = "Vehicle_Type")
    private String vehicleType;
    @Column(name = "Route")
    private String route;
    @Column(name = "Trip_Details")
    private String tripDetails;
    @Column(name = "Rate")
    private double rate;
    @Column(name = "Trip_Cost")
    private double tripCost;
    @Column(name = "Base_Rate")
    private double baseRate;
    @Column(name = "Std_Mileage_Per_Km")
    private double stdMileagePerKm;
    @Column(name = "Max_Kms")
    private double maxKms;
    @Column(name = "Credit_Period_In_Days")
    private String creditPeriodInDays;
    @Column(name = "Agreement_Made_Date")
    private String agreementMadeDate;
    @Column(name = "Agreement_Expiry_Date")
    private String agreementExpiryDate;
    @Column(name = "Vendor_Code")
    private String vendorCode;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSrNo() {
		return srNo;
	}

	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}

	public String getZone() {
		return zone;
	}

	public void setZone(String zone) {
		this.zone = zone;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}

	public String getVehicleType() {
		return vehicleType;
	}

	public void setVehicleType(String vehicleType) {
		this.vehicleType = vehicleType;
	}

	public String getRoute() {
		return route;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	public String getTripDetails() {
		return tripDetails;
	}

	public void setTripDetails(String tripDetails) {
		this.tripDetails = tripDetails;
	}

	public double getRate() {
		return rate;
	}

	public void setRate(double rate) {
		this.rate = rate;
	}

	public double getTripCost() {
		return tripCost;
	}

	public void setTripCost(double tripCost) {
		this.tripCost = tripCost;
	}

	public double getBaseRate() {
		return baseRate;
	}

	public void setBaseRate(double baseRate) {
		this.baseRate = baseRate;
	}

	public double getStdMileagePerKm() {
		return stdMileagePerKm;
	}

	public void setStdMileagePerKm(double stdMileagePerKm) {
		this.stdMileagePerKm = stdMileagePerKm;
	}

	public double getMaxKms() {
		return maxKms;
	}

	public void setMaxKms(double maxKms) {
		this.maxKms = maxKms;
	}

	public String getCreditPeriodInDays() {
		return creditPeriodInDays;
	}

	public void setCreditPeriodInDays(String creditPeriodInDays) {
		this.creditPeriodInDays = creditPeriodInDays;
	}

	public String getAgreementMadeDate() {
		return agreementMadeDate;
	}

	public void setAgreementMadeDate(String agreementMadeDate) {
		this.agreementMadeDate = agreementMadeDate;
	}

	public String getAgreementExpiryDate() {
		return agreementExpiryDate;
	}

	public void setAgreementExpiryDate(String agreementExpiryDate) {
		this.agreementExpiryDate = agreementExpiryDate;
	}

	public String getVendorCode() {
		return vendorCode;
	}

	public void setVendorCode(String vendorCode) {
		this.vendorCode = vendorCode;
	}

	public double getCurrentFuelRate() {
		return currentFuelRate;
	}

	public void setCurrentFuelRate(double currentFuelRate) {
		this.currentFuelRate = currentFuelRate;
	}

}
