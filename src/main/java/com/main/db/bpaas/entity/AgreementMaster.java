package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "AgreementMaster")
public class AgreementMaster {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "Type")
    private String Type;
    @Column(name = "Sr_No")
    private String SrNo;
    @Column(name = "Zone")
    private String Zone;
    @Column(name = "City")
    private String City;
    @Column(name = "Vendor_Name")
    private String VendorName;
    @Column(name = "Vehicle_Type")
    private String VehicleType;
    @Column(name = "Route")
    private String Route;
    @Column(name = "Trip_Details")
    private String TripDetails;
    @Column(name = "Rate")
    private double Rate;
    @Column(name = "Trip_Cost")
    private double TripCost;
    @Column(name = "Base_Rate")
    private double BaseRate;
    @Column(name = "Std_Mileage_Per_Km")
    private double StdMileagePerKm;
    @Column(name = "Max_Kms")
    private double MaxKms;
    @Column(name = "Credit_Period_In_Days")
    private String CreditPeriodInDays;
    @Column(name = "Agreement_Made_Date")
    private String AgreementMadeDate;
    @Column(name = "Agreement_Expiry_Date")
    private String AgreementExpiryDate;
    @Column(name = "Vendor_Code")
    private String VendorCode;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getType() {
        return Type;
    }

    public void setType(String Type) {
        this.Type = Type;
    }

    public String getSrNo() {
        return SrNo;
    }

    public void setSrNo(String SrNo) {
        this.SrNo = SrNo;
    }

    public String getZone() {
        return Zone;
    }

    public void setZone(String Zone) {
        this.Zone = Zone;
    }

    public String getCity() {
        return City;
    }

    public void setCity(String City) {
        this.City = City;
    }

    public String getVendorName() {
        return VendorName;
    }

    public void setVendorName(String VendorName) {
        this.VendorName = VendorName;
    }

    public String getVehicleType() {
        return VehicleType;
    }

    public void setVehicleType(String VehicleType) {
        this.VehicleType = VehicleType;
    }

    public String getRoute() {
        return Route;
    }

    public void setRoute(String Route) {
        this.Route = Route;
    }

    public String getTripDetails() {
        return TripDetails;
    }

    public void setTripDetails(String TripDetails) {
        this.TripDetails = TripDetails;
    }

    public double getRate() {
        return Rate;
    }

    public void setRate(double Rate) {
        this.Rate = Rate;
    }

    public double getTripCost() {
        return TripCost;
    }

    public void setTripCost(double TripCost) {
        this.TripCost = TripCost;
    }

    public double getBaseRate() {
        return BaseRate;
    }

    public void setBaseRate(double BaseRate) {
        this.BaseRate = BaseRate;
    }

    public double getStdMileagePerKm() {
        return StdMileagePerKm;
    }

    public void setStdMileagePerKm(double StdMileagePerKm) {
        this.StdMileagePerKm = StdMileagePerKm;
    }

    public double getMaxKms() {
        return MaxKms;
    }

    public void setMaxKms(double MaxKms) {
        this.MaxKms = MaxKms;
    }

    public String getCreditPeriodInDays() {
        return CreditPeriodInDays;
    }

    public void setCreditPeriodInDays(String CreditPeriodInDays) {
        this.CreditPeriodInDays = CreditPeriodInDays;
    }

    public String getAgreementMadeDate() {
        return AgreementMadeDate;
    }

    public void setAgreementMadeDate(String AgreementMadeDate) {
        this.AgreementMadeDate = AgreementMadeDate;
    }

    public String getAgreementExpiryDate() {
        return AgreementExpiryDate;
    }

    public void setAgreementExpiryDate(String AgreementExpiryDate) {
        this.AgreementExpiryDate = AgreementExpiryDate;
    }

    public String getVendorCode() {
        return VendorCode;
    }

    public void setVendorCode(String VendorCode) {
        this.VendorCode = VendorCode;
    }



}
