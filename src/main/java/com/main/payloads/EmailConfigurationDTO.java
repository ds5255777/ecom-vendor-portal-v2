package com.main.payloads;

import lombok.Data;

@Data
public class EmailConfigurationDTO {
	 
		private Integer id;
		private String userName;
		private String password;
		private String serverName;
		private String smtpPort;
		private String isActive;


}
