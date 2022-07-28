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
@Table(name = "supplier_Type")
@Getter
@Setter
public class SupplierType {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "supplier_type")
	private String supplierType;

	@Column(name = "type")
	private String type;

	@Column(name = "code")
	private Integer code;

}
