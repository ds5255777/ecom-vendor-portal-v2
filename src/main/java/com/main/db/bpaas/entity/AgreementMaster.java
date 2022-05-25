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
    @Column(name = "fixed_km")
    private String fixedKm;
    @Column(name = "fs_diff")
    private Double fsDiff;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public double getCurrentFuelRate() {
        return currentFuelRate;
    }

    public void setCurrentFuelRate(double currentFuelRate) {
        this.currentFuelRate = currentFuelRate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getFixedKm() {
        return fixedKm;
    }

    public void setFixedKm(String fixedKm) {
        this.fixedKm = fixedKm;
    }

    public Double getFsDiff() {
        return fsDiff;
    }

    public void setFsDiff(Double fsDiff) {
        this.fsDiff = fsDiff;
    }
}
