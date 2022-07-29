package com.main.payloads;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDTO {

	private Integer id;
	private String emailId;
	private String contactNo;
	private String username;
	private String password;
	private Integer roleId;
	private String firstName;
	private String lastName;
	private String vendorName;
	private RoleEntityDTO rolesObj;
	private String status = "0";
	private String bpCode;
	private String passwordConfirm;

}
