package com.main.db.bpaas.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Data;

@Data
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

}
