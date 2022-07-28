package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "Trip_Details")
@Getter
@Setter
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

	@Column(name = "standard_vechicle_type")
	private String standardVechicleType;

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

	@Column(name = "actual_shipment")
	private Double actualShipment;

	@Column(name = "actual_chargeable_weight")
	private Double actualChargeableWeight;

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

	@Column(name = "lumpsome_checkbox")
	private String lumpsomecheckbox;

}
