package com.main.db.bpaas.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

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
	private String runStatus;

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
	private String actualKM;

	@Column(name = "standard_km")
	private String standardKM;

	@Column(name = "mileage")
	private String mileage;

	@Column(name = "rate_per_km")
	private String ratePerKm;

	@Column(name = "route_kms")
	private String routeKms;

	@Column(name = "fs_base_rate")
	private String fsBaseRate;

	@Column(name = "current_fuel_rate")
	private String currentFuelRate;

	@Column(name = "fs_diff")
	private String fsDiff;

	@Column(name = "basic_freight")
	private String basicFreight;

	@Column(name = "fs")
	private String fs;

	@Column(name = "total_freight")
	private String totalFreight;

	@Column(name = "vendor_Trip_Status")
	private String vendorTripStatus;

	@Column(name = "trip_starting_date")
	private String tripStartingDate;

	@Column(name = "payment_status")
	private String paymentStatus;

	@Column(name = "assign_to")
	private String assignTo;

	@Column(name = "status")
	private String status;

	@Column(name = "opening_reading")
	private String openingReading;

	@Column(name = "closing_reading")
	private String closingReading;

	@Column(name = "Actual_Shipment")
	private String ActualShipment;

	@Column(name = "Actual_Chargeable_Weight")
	private String ActualChargeableWeight;

	// targetEntity = QueryEntity.class,
	/*
	 * @OneToMany(cascade = CascadeType.ALL)
	 * 
	 * @JoinColumn(name ="cp_fk",referencedColumnName = "id")
	 */
	// private List<QueryEntity> vendorQuerys;

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

	public String getRunStatus() {
		return runStatus;
	}

	public void setRunStatus(String runStatus) {
		this.runStatus = runStatus;
	}

	public String getActualKM() {
		return actualKM;
	}

	public void setActualKM(String actualKM) {
		this.actualKM = actualKM;
	}

	public String getTripStartingDate() {
		return tripStartingDate;
	}

	public void setTripStartingDate(String tripStartingDate) {
		this.tripStartingDate = tripStartingDate;
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

	public String getStandardKM() {
		return standardKM;
	}

	public void setStandardKM(String standardKM) {
		this.standardKM = standardKM;
	}

	public String getMileage() {
		return mileage;
	}

	public void setMileage(String mileage) {
		this.mileage = mileage;
	}

	public String getRatePerKm() {
		return ratePerKm;
	}

	public void setRatePerKm(String ratePerKm) {
		this.ratePerKm = ratePerKm;
	}

	public String getRouteKms() {
		return routeKms;
	}

	public void setRouteKms(String routeKms) {
		this.routeKms = routeKms;
	}

	public String getFsBaseRate() {
		return fsBaseRate;
	}

	public void setFsBaseRate(String fsBaseRate) {
		this.fsBaseRate = fsBaseRate;
	}

	public String getCurrentFuelRate() {
		return currentFuelRate;
	}

	public void setCurrentFuelRate(String currentFuelRate) {
		this.currentFuelRate = currentFuelRate;
	}

	public String getFsDiff() {
		return fsDiff;
	}

	public void setFsDiff(String fsDiff) {
		this.fsDiff = fsDiff;
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

	public String getTotalFreight() {
		return totalFreight;
	}

	public void setTotalFreight(String totalFreight) {
		this.totalFreight = totalFreight;
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

	public String getVendorTripStatus() {
		return vendorTripStatus;
	}

	public void setVendorTripStatus(String vendorTripStatus) {
		this.vendorTripStatus = vendorTripStatus;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	/*
	 * public List<QueryEntity> getVendorQuerys() { return vendorQuerys; }
	 * 
	 * public void setVendorQuerys(List<QueryEntity> vendorQuerys) {
	 * this.vendorQuerys = vendorQuerys; }
	 */

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

}
