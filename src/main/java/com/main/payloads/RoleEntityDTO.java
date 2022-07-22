package com.main.payloads;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class RoleEntityDTO {

    private Integer id;
	private String roleName;
	private String isActive;

}
