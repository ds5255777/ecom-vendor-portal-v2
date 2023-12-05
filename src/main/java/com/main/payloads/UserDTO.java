package com.main.payloads;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDTO {

	private Integer id;
	@NotBlank
	@Email(message = "Email should be valid")
	@Pattern(regexp = ".+@.+\\.[a-z]+")
	private String emailId;
	@NotBlank
	private String contactNo;
	@NotBlank
	@Size(min = 1, max = 15)
	private String username;
	@NotBlank
	private String password;
	private Integer roleId;
	@Size(min = 3, max = 20)
	private String firstName;
	@Size(min = 3, max = 20)
	private String lastName;
	private String vendorName;
	private RoleEntityDTO rolesObj;
	private String status = "0";
	private String bpCode;
	private String passwordConfirm;
	private String commercialHead;
	

}
