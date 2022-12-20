package com.main.controller;

import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.bean.SupplierDTO;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.EmailAuditLogs;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.MailContent;
import com.main.db.bpaas.entity.SendEmail;
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.entity.User;
import com.main.payloads.SupDetailsDTO;
import com.main.payloads.UserDTO;
import com.main.service.UserServiceImpl;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/userController")
@RestController
public class UserController {

	@Autowired
	private ServiceManager serviceManager;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(UserController.class);

	@PostMapping({ "/saveUpdateUserDetails" })
	public String saveUpdateUserDetails(Principal principal, @Valid @RequestBody UserDTO userDto) {

		logger.info("Log Some Information :  ");

		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {
			try {
				userDto.getId();
				if (null == userDto.getId()) {
					userDto.setPassword(serviceManager.bCryptPasswordEncoder.encode(userDto.getPassword()));
					serviceManager.userRepository.save(this.serviceManager.modelMapper.map(userDto, User.class));
				} else {
					String password = serviceManager.userRepository.getUserPasswordById(userDto.getId());
					if ((null != userDto.getPassword()) && !userDto.getPassword().equalsIgnoreCase("")) {
						password = serviceManager.bCryptPasswordEncoder.encode(userDto.getPassword());
					}
					userDto.setPassword(password);
					serviceManager.userRepository.updateUserDetails(password, userDto.getEmailId(),
							userDto.getContactNo(), userDto.getStatus(), userDto.getId(), userDto.getUsername());
				}
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getActiveUsersData" })
	public String getActiveUsersData(HttpServletRequest request) {

		logger.info("Log Some Information getActiveUsersData  ");

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			List<String> userStatusList = new ArrayList<>();
			userStatusList.add(GlobalConstants.ACTIVE_STATUS);
			userStatusList.add(GlobalConstants.CHANGE_PASSWORD_STATUS);
			userStatusList.add(GlobalConstants.INACTIVE_STATUS);
			List<User> userList = serviceManager.userRepository.findByStatusIn(userStatusList);
			List<UserDTO> usersList = userList.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, UserDTO.class))
					.collect(Collectors.toList());
			data.setData(usersList);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getUserById" })
	public String getUserById(@RequestBody UserDTO userDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			User userDtoToEntity = this.serviceManager.modelMapper.map(userDto, User.class);
			User userObj = serviceManager.userRepository.findById(userDtoToEntity.getId()).orElseThrow(null);
			data.setData(this.serviceManager.modelMapper.map(userObj, UserDTO.class));
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/setStatusOfUserById" })

	public String setStatusOfUserById(@RequestBody UserDTO userDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			serviceManager.userRepository.updateStatusByUserid(userDto.getStatus(), userDto.getId());
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/checkForExistingUserName" })
	public String checkForExistingUserName(Principal principal, @RequestBody UserDTO userDto) {

		logger.info("Log Some Information checkForExistingUserName  ");

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String userRole = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		try {
			if (userRole.equals(GlobalConstants.ROLE_ADMIN)) {
				List<String> userStatusList = new ArrayList<>();
				userStatusList.add(GlobalConstants.ACTIVE_STATUS);
				userStatusList.add(GlobalConstants.CHANGE_PASSWORD_STATUS);

				String username = serviceManager.userRepository.checkForExistingUserName(userDto.getUsername());

				if (null == username) {
					data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				} else {
					data.setMsg("exist");
				}
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getUserByRole" })

	public String getUserByRole(@RequestBody UserDTO userDto) {

		logger.info("Log Some Information getUserByRole  ");

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			List<User> users = serviceManager.userRepository.findByRoleIdAndStatus(userDto.getRoleId(),
					GlobalConstants.ACTIVE_STATUS);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			data.setData(this.serviceManager.modelMapper.map(users, UserDTO.class));
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/changePassword" })
	public String changePassword(Principal principal, @RequestParam(name = "password") String password) {
		logger.info("Log Some Information changePassword  ");
//		String userName = principal.getName();
//		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			User us = serviceManager.userService.findByUsername(principal.getName());
			us.setPassword(password);
			us.setStatus(GlobalConstants.ACTIVE_STATUS);
			serviceManager.userService.save(us);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/changeVendorPassword" })
	public String changeVendorPassword(Principal principal, @RequestParam(name = "password") String password,
			@RequestParam(name = "username") String username) {
		logger.info("Log Some Information changePassword  ");
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {
			try {
				User us = serviceManager.userService.findByUsername(username);
				us.setPassword(password);
				us.setStatus(GlobalConstants.ACTIVE_STATUS);
				serviceManager.userService.save(us);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} catch (Exception e) {
				data.setMsg(GlobalConstants.ERROR_MESSAGE);
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getActiveVendorData" })
	public String getActiveVendor(HttpServletRequest request) {

		logger.info("Log Some Information getActiveVendorData  ");
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			List<Object[]> vendorList = serviceManager.supDetailsRepo.getAllInActiveVendor();
			List<SupplierDTO> sdtList = new ArrayList<>();
			for (Object[] objects : vendorList) {
				SupplierDTO sdt = new SupplierDTO();
				if (null != objects[0]) {
					sdt.setSuppName(objects[0].toString());
				}
				if (null != objects[1]) {
					sdt.setBpCode(objects[1].toString());
				}
				if (null != objects[2]) {
					sdt.setBusinessClassification(objects[2].toString());
				}
				if (null != objects[3]) {
					sdt.setVendorType(objects[3].toString());
				}
				if (null != objects[4]) {
					sdt.setVenStatus(objects[4].toString());
				}
				if (null != objects[5]) {
					sdt.setIntroducedByName(objects[5].toString());
				}
				if (null != objects[6]) {
					sdt.setIntroducedByEmailID(objects[6].toString());
				}
				if (null != objects[7]) {
					sdt.setFlag(objects[7].toString());
				}
				sdtList.add(sdt);
			}
			data.setData(sdtList);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			logger.info("end  to getActiveVendorData ");
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getVendorById" })

	public String getVendorById(HttpServletRequest request, @RequestBody SupDetailsDTO details) {

		logger.info("Log Some Information getVendorById ");

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			SupDetails supDetails = serviceManager.supDetailsRepo.findBybpCode(details.getBpCode());
			data.setData(this.serviceManager.modelMapper.map(supDetails, SupDetailsDTO.class));
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			logger.info(" end to vendor details method");
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/setStatusOfVendorByBpCode" })

	public String setStatusOfVendorByBpCode(HttpServletRequest request, @RequestBody UserDTO user) {

		logger.info("Log Some Information setStatusOfVendorByBpCode  ");

		String status = "";
		DataContainer data = new DataContainer();
		if (user.getStatus().equalsIgnoreCase("0")) {
			status = GlobalConstants.SET_FLAG_IN_ACTIVE;
		} else if (user.getStatus().equalsIgnoreCase("1")) {
			status = GlobalConstants.SET_FLAG_TYPE_ACTIVE;
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			serviceManager.userRepository.updateStatusOfVendorByBpCode(user.getStatus(), user.getBpCode());
			serviceManager.userRepository.updateFlagOfVendorByBpCode(status, user.getBpCode());

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllVendorStatus" })

	public String getAllVendorStatus(HttpServletRequest request, @RequestBody UserDTO userDto) {

		logger.info("Log Some Information getAllVendorStatus  ");

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			User userDtoToEntity = this.serviceManager.modelMapper.map(userDto, User.class);
			String bpCode = userDtoToEntity.getBpCode();
			List<User> vendorListStatus = serviceManager.userRepository.getAllVendorStatus(bpCode);

			List<UserDTO> usersList = vendorListStatus.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, UserDTO.class))
					.collect(Collectors.toList());

			data.setData(usersList);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			logger.info("end  to getActiveVendorData ");

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/activeVendor" })

	public String activeVendor(HttpServletRequest request, @RequestBody UserDTO details) {

		logger.info("Log Some Information activeVendor  ");

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			String bpCode = details.getBpCode();
			String status = details.getStatus();
			serviceManager.userRepository.updateStatusOfVendorByBpCode(status, bpCode);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/changeVenPass" })
	public String changeVendorPassword(Principal principal, @RequestBody SupDetailsDTO supDetailsDto) {

		logger.info("Log Some Information changeVendorPassword  ");

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equals(GlobalConstants.ROLE_ADMIN)) {

				String bpCode = supDetailsDto.getBpCode();
				String passwordUser = UserServiceImpl.generateRandomPassword();
				System.out.println(passwordUser);
				User user=serviceManager.userRepository.findByBpCode(bpCode);
				//serviceManager.userRepository.updateVendorPassword(bpCode, passwordUser);
				//serviceManager.userService.Update(null)
				
				/* send onBoard email */

				List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository
						.findByIsActive(GlobalConstants.ACTIVE_STATUS);
				EmailConfiguration emailConfiguration = emailList.get(0);

				String vendorEmail = supDetailsDto.getContactDetails().get(0).getConEmail();

				List<MailContent> mailType = serviceManager.mailContentRepo
						.findByType("Send username And Password");

				SendEmail sendEmail = new SendEmail();
				MailContent mailContent = mailType.get(0);
				String emailBody = mailContent.getEmailBody();

				emailBody = emailBody.replace("#username#", bpCode);
				emailBody = emailBody.replace("#password#", passwordUser);

				sendEmail.setMailfrom(emailConfiguration.getUserName());
				sendEmail.setSendTo(vendorEmail);
				sendEmail.setSubject(mailContent.getSubject());
				sendEmail.setEmailBody(emailBody);
				sendEmail.setStatus(GlobalConstants.EMAIL_STATUS_SENDING);

				serviceManager.sendEmailRepo.save(sendEmail);

				EmailAuditLogs auditLogs = new EmailAuditLogs();
				auditLogs.setMailFrom(emailConfiguration.getUserName());
				auditLogs.setMailTo(vendorEmail);
				auditLogs.setMailSubject(mailContent.getSubject());
				auditLogs.setMailMessage(emailBody);

				serviceManager.emailAuditLogsRepo.save(auditLogs);
			}
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

}
