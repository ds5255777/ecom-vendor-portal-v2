package com.main.db.bpaas.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name = "email_configuration")
public class EmailConfiguration implements Serializable{

	private static final long serialVersionUID = 1L;
	 protected static final String PK = "id";
	    
	    

		@Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Integer id;
		
		@Column(name = "user_name")
		private String userName;
		
		@Column(name = "password")
		private String password;
		
		@Column(name = "server_name")
		private String serverName;
		
		
		@Column(name = "smtp_port")
		private String smtpPort;

		@Column(name = "is_active")
		private String isActive;
		

		
		public Integer getId() {
			return id;
		}

		public void setId(Integer id) {
			this.id = id;
		}

		public String getUserName() {
			return userName;
		}

		public void setUserName(String userName) {
			this.userName = userName;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}

		public String getServerName() {
			return serverName;
		}

		public void setServerName(String serverName) {
			this.serverName = serverName;
		}

		public String getSmtpPort() {
			return smtpPort;
		}

		public void setSmtpPort(String smtpPort) {
			this.smtpPort = smtpPort;
		}

		public String getIsActive() {
			return isActive;
		}

		public void setIsActive(String isActive) {
			this.isActive = isActive;
		}
		
		
		
		
		
		

}
