package com.main.controller;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

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
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.entity.User;
import com.main.payloads.SupDetailsDTO;
import com.main.payloads.UserDTO;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/userController")
@RestController
public class UserController {

	@Autowired
	private ServiceManager serviceManager;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(UserController.class);

	@PostMapping({ "/saveUpdateUserDetails" })

	public String saveUpdateUserDetails(HttpServletRequest request, @RequestBody UserDTO userDto) {

		logger.info("Log Some Information : " + dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			userDto.getId();

			if (null == userDto.getId()) {
				userDto.setPassword(serviceManager.bCryptPasswordEncoder.encode(userDto.getPassword()));
				serviceManager.userRepository.save(this.serviceManager.modelMapper.map(userDto, User.class));

			} else {

				String password = serviceManager.userRepository.getUserPasswordById(userDto.getId());

				if (userDto.getPassword() != null) {

					if (!userDto.getPassword().equalsIgnoreCase("")) {

						password = serviceManager.bCryptPasswordEncoder.encode(userDto.getPassword());

					}

				}
				userDto.setPassword(password);

				serviceManager.userRepository.save(this.serviceManager.modelMapper.map(userDto, User.class));

			}

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getActiveUsersData" })

	public String getActiveUsersData(HttpServletRequest request) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<String> userStatusList = new ArrayList<>();
			userStatusList.add(GlobalConstants.ACTIVE_STATUS);
			userStatusList.add(GlobalConstants.CHANGE_PASSWORD_STATUS);
			userStatusList.add(GlobalConstants.INACTIVE_STATUS);
			List<User> userList = serviceManager.userRepository.findByStatusIn(userStatusList);
			List<UserDTO> usersList = userList.stream()
					.map((listOfUser) -> this.serviceManager.modelMapper.map(listOfUser, UserDTO.class))
					.collect(Collectors.toList());

			data.setData(usersList);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getUserById" })

	public String getUserById(@RequestBody UserDTO userDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			User userDtoToEntity = this.serviceManager.modelMapper.map(userDto, User.class);

			User userObj = serviceManager.userRepository.findById(userDtoToEntity.getId()).orElseThrow(null);

			data.setData(this.serviceManager.modelMapper.map(userObj, UserDTO.class));
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/setStatusOfUserById" })

	public String setStatusOfUserById(@RequestBody UserDTO userDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			serviceManager.userRepository.updateStatusByUserid(userDto.getStatus(), userDto.getId());
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/checkForExistingUserName" })
	public String checkForExistingUserName(Principal principal, @RequestBody UserDTO userDto) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String userName = principal.getName();
		String userRole = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		try {
			if (userRole.equals(GlobalConstants.ROLE_ADMIN)) {
				List<String> userStatusList = new ArrayList<>();
				userStatusList.add(GlobalConstants.ACTIVE_STATUS);
				userStatusList.add(GlobalConstants.CHANGE_PASSWORD_STATUS);

				String username = serviceManager.userRepository.checkForExistingUserName(userDto.getUsername());

				if (null == username) {
					data.setMsg("success");
				} else {
					data.setMsg("exist");
				}
			}

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getUserByRole" })

	public String getUserByRole(@RequestBody UserDTO userDto) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<User> users = serviceManager.userRepository.findByRoleIdAndStatus(userDto.getRoleId(),
					GlobalConstants.ACTIVE_STATUS);

			logger.info("" + users.size());
			data.setMsg("success");
			data.setData(this.serviceManager.modelMapper.map(users, UserDTO.class));
		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/changePassword" })
	public String changePassword(Principal principal, @RequestParam(name = "password") String password) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		logger.info("Password is : " + password);
		try {
			User us = serviceManager.userService.findByUsername(principal.getName());
			us.setPassword(password);
			us.setStatus("1");
			serviceManager.userService.save(us);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getActiveVendorData" })

	public String getActiveVendorData(HttpServletRequest request) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
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
			data.setMsg("success");
			logger.info("end  to getActiveVendorData ");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getVendorById" })

	public String getVendorById(HttpServletRequest request, @RequestBody SupDetailsDTO details) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			SupDetails supDetails = serviceManager.supDetailsRepo.findBybpCode(details.getBpCode());
			data.setData(this.serviceManager.modelMapper.map(supDetails, SupDetailsDTO.class));
			data.setMsg("success");
			logger.info(" end to vendor details method");
		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/setStatusOfVendorByBpCode" })

	public String setStatusOfVendorByBpCode(HttpServletRequest request, @RequestBody UserDTO user) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			serviceManager.userRepository.updateStatusOfVendorByBpCode(user.getStatus(), user.getBpCode());
			serviceManager.userRepository.updateFlagOfVendorByBpCode(GlobalConstants.SET_FLAG_IN_ACTIVE,
					user.getBpCode());

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getAllVendorStatus" })

	public String getAllVendorStatus(HttpServletRequest request, @RequestBody UserDTO userDto) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			User userDtoToEntity = this.serviceManager.modelMapper.map(userDto, User.class);
			String bpCode = userDtoToEntity.getBpCode();
			List<User> vendorListStatus = serviceManager.userRepository.getAllVendorStatus(bpCode);

			List<UserDTO> usersList = vendorListStatus.stream()
					.map((listOfUser) -> this.serviceManager.modelMapper.map(listOfUser, UserDTO.class))
					.collect(Collectors.toList());

			data.setData(usersList);
			data.setMsg("success");
			logger.info("end  to getActiveVendorData ");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/activeVendor" })

	public String activeVendor(HttpServletRequest request, @RequestBody UserDTO details) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String bpCode = details.getBpCode();
			String status = details.getStatus();
			serviceManager.userRepository.updateStatusOfVendorByBpCode(status, bpCode);

			data.setMsg("success");
			logger.info(" activeVendor status  : " + status);

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

}
