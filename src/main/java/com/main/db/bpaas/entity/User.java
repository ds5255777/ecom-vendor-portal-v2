package com.main.db.bpaas.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "users")
@Getter
@Setter
public class User implements Serializable {

	private static final long serialVersionUID = 1L;
	protected static final String PK = "id";

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "email_id")
	private String emailId;

	@Column(name = "contact_no")
	private String contactNo;

	@Column(name = "username")
	private String username;

	@Column(name = "password")
	private String password;

	@Column(name = "role_id")
	private Integer roleId;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	@Column(name = "vendor_name")
	private String vendorName;

	@ManyToOne
	@JoinColumn(name = "role_id", referencedColumnName = "id", insertable = false, updatable = false)
	private RolesEntity rolesObj;

	@Column(name = "status")
	private String status = "0"; 
	
	@Column(name = "bp_code")
	private String bpCode;
	
	@Column(name = "failed_attempt")
    private int failedAttempt=0;

	@Transient
	private String passwordConfirm;

}
