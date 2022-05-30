package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Trip_Details")
public class TripDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "trip_id")
	private String tripID;

	@Column(name = "vendor_code")
	private String vendorCode;

	@Column(name = "route")
	private String route;

	@Column(name = "run_type")
	private String runType;

	@Column(name = "mode")
	private String mode;

	@Column(name = "vehicle_number")
	private String vehicleNumber;

	@Column(name = "vendor_name")
	private String vendorName;

	@Column(name = "actual_vechicle_type")
	private String actualVechicleType;

	@Column(name = "standard_shipment_capacity")
	private String standardShipmentCapacity;

	@Column(name = "standard_payload_capacity")
	private String standardPayloadCapacity;

	@Column(name = "run_status")
	private String runStatus;// Closed, In-Transit

	@Column(name = "origin_hub")
	private String originHub;

	@Column(name = "origin_region")
	private String originRegion;

	@Column(name = "dest_hub")
	private String destHub;

	@Column(name = "actual_departure")
	private String actualDeparture;

	@Column(name = "actual_arrival")
	private String actualArrival;

	@Column(name = "actual_km")
	private Double actualKM;

	@Column(name = "standard_km")
	private Double standardKM;

	@Column(name = "mileage")
	private Double mileage;

	@Column(name = "rate_per_km")
	private Double ratePerKm;

	@Column(name = "route_kms")
	private Double routeKms;

	@Column(name = "fs_base_rate")
	private Double fsBaseRate;

	@Column(name = "current_fuel_rate")
	private Double currentFuelRate;

	@Column(name = "fs_diff")
	private Double fsDiff;

	@Column(name = "basic_freight")
	private Double basicFreight;

	@Column(name = "fs")
	private Double fs;

	@Column(name = "total_freight")
	private Double totalFreight;

	@Column(name = "opening_reading")
	private String openingReading;

	@Column(name = "closing_reading")
	private String closingReading;

	@Column(name = "Actual_Shipment")
	private String ActualShipment;

	@Column(name = "Actual_Chargeable_Weight")
	private String ActualChargeableWeight;

	// Status
	@Column(name = "vendor_Trip_Status")
	private String vendorTripStatus; // Approved, Yet_To_Be_Approved, Invoicing

	@Column(name = "payment_status")
	private String paymentStatus;// Oracle(Pending Approved)

	@Column(name = "assign_to")
	private String assignTo;// network Team, Vendor

	@Column(name = "invoice_number")
	private String invoiceNumber;

	@Column(name = "processed_On")
	private String processedOn;//

	@Column(name = "processed_By")
	private String processedBy;//

//lumpsome_amount
	@Column(name = "lumpsome_amount")
	private String lumpsomeamount;

//Saurabh End

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTripID() {
		return tripID;
	}

	public void setTripID(String tripID) {
		this.tripID = tripID;
	}

	public String getVendorCode() {
		return vendorCode;
	}

	public void setVendorCode(String vendorCode) {
		this.vendorCode = vendorCode;
	}

	public String getRoute() {
		return route;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	public String getRunType() {
		return runType;
	}

	public void setRunType(String runType) {
		this.runType = runType;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getVehicleNumber() {
		return vehicleNumber;
	}

	public void setVehicleNumber(String vehicleNumber) {
		this.vehicleNumber = vehicleNumber;
	}

	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}

	public String getActualVechicleType() {
		return actualVechicleType;
	}

	public void setActualVechicleType(String actualVechicleType) {
		this.actualVechicleType = actualVechicleType;
	}

	public String getStandardShipmentCapacity() {
		return standardShipmentCapacity;
	}

	public void setStandardShipmentCapacity(String standardShipmentCapacity) {
		this.standardShipmentCapacity = standardShipmentCapacity;
	}

	public String getStandardPayloadCapacity() {
		return standardPayloadCapacity;
	}

	public void setStandardPayloadCapacity(String standardPayloadCapacity) {
		this.standardPayloadCapacity = standardPayloadCapacity;
	}

	public String getRunStatus() {
		return runStatus;
	}

	public void setRunStatus(String runStatus) {
		this.runStatus = runStatus;
	}

	public String getOriginHub() {
		return originHub;
	}

	public void setOriginHub(String originHub) {
		this.originHub = originHub;
	}

	public String getOriginRegion() {
		return originRegion;
	}

	public void setOriginRegion(String originRegion) {
		this.originRegion = originRegion;
	}

	public String getDestHub() {
		return destHub;
	}

	public void setDestHub(String destHub) {
		this.destHub = destHub;
	}

	public String getActualDeparture() {
		return actualDeparture;
	}

	public void setActualDeparture(String actualDeparture) {
		this.actualDeparture = actualDeparture;
	}

	public String getActualArrival() {
		return actualArrival;
	}

	public void setActualArrival(String actualArrival) {
		this.actualArrival = actualArrival;
	}

	public Double getActualKM() {
		return actualKM;
	}

	public void setActualKM(Double actualKM) {
		this.actualKM = actualKM;
	}

	public Double getStandardKM() {
		return standardKM;
	}

	public void setStandardKM(Double standardKM) {
		this.standardKM = standardKM;
	}

	public Double getMileage() {
		return mileage;
	}

	public void setMileage(Double mileage) {
		this.mileage = mileage;
	}

	public Double getRatePerKm() {
		return ratePerKm;
	}

	public void setRatePerKm(Double ratePerKm) {
		this.ratePerKm = ratePerKm;
	}

	public Double getRouteKms() {
		return routeKms;
	}

	public void setRouteKms(Double routeKms) {
		this.routeKms = routeKms;
	}

	public Double getFsBaseRate() {
		return fsBaseRate;
	}

	public void setFsBaseRate(Double fsBaseRate) {
		this.fsBaseRate = fsBaseRate;
	}

	public Double getCurrentFuelRate() {
		return currentFuelRate;
	}

	public void setCurrentFuelRate(Double currentFuelRate) {
		this.currentFuelRate = currentFuelRate;
	}

	public Double getFsDiff() {
		return fsDiff;
	}

	public void setFsDiff(Double fsDiff) {
		this.fsDiff = fsDiff;
	}

	public Double getBasicFreight() {
		return basicFreight;
	}

	public void setBasicFreight(Double basicFreight) {
		this.basicFreight = basicFreight;
	}

	public Double getFs() {
		return fs;
	}

	public void setFs(Double fs) {
		this.fs = fs;
	}

	public Double getTotalFreight() {
		return totalFreight;
	}

	public void setTotalFreight(Double totalFreight) {
		this.totalFreight = totalFreight;
	}

	public String getOpeningReading() {
		return openingReading;
	}

	public void setOpeningReading(String openingReading) {
		this.openingReading = openingReading;
	}

	public String getClosingReading() {
		return closingReading;
	}

	public void setClosingReading(String closingReading) {
		this.closingReading = closingReading;
	}

	public String getActualShipment() {
		return ActualShipment;
	}

	public void setActualShipment(String actualShipment) {
		ActualShipment = actualShipment;
	}

	public String getActualChargeableWeight() {
		return ActualChargeableWeight;
	}

	public void setActualChargeableWeight(String actualChargeableWeight) {
		ActualChargeableWeight = actualChargeableWeight;
	}

	public String getVendorTripStatus() {
		return vendorTripStatus;
	}

	public void setVendorTripStatus(String vendorTripStatus) {
		this.vendorTripStatus = vendorTripStatus;
	}

	public String getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public String getAssignTo() {
		return assignTo;
	}

	public void setAssignTo(String assignTo) {
		this.assignTo = assignTo;
	}

	public String getInvoiceNumber() {
		return invoiceNumber;
	}

	public void setInvoiceNumber(String invoiceNumber) {
		this.invoiceNumber = invoiceNumber;
	}

	public String getProcessedOn() {
		return processedOn;
	}

	public void setProcessedOn(String processedOn) {
		this.processedOn = processedOn;
	}

	public String getProcessedBy() {
		return processedBy;
	}

	public void setProcessedBy(String processedBy) {
		this.processedBy = processedBy;
	}

	public String getLumpsomeamount() {
		return lumpsomeamount;
	}

	public void setLumpsomeamount(String lumpsomeamount) {
		this.lumpsomeamount = lumpsomeamount;
	}

}
