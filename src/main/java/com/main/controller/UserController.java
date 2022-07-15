package com.main.controller;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.bean.SupplierDTO;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.entity.User;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/userController")
@RestController
public class UserController {

	@Autowired
	private ServiceManager serviceManager;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(UserController.class);

	@PostMapping({ "/saveUpdateUserDetails" })
	@CrossOrigin("*")
	public String saveUpdateUserDetails(HttpServletRequest request, @RequestBody User user) {

		logger.info("Log Some Information : " + dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

//					String  userName = (String) request.getSession().getAttribute("userName");
//					Integer  userId = (Integer) request.getSession().getAttribute("userId");

			if (null == user.getId()) {
				user.setPassword(serviceManager.bCryptPasswordEncoder.encode(user.getPassword()));
				User userAfterSave = serviceManager.userRepository.save(user);

			} else {

				String password = serviceManager.userRepository.getUserPasswordById(user.getId());

				if (user.getPassword() != null) {

					if (!user.getPassword().equalsIgnoreCase("")) {

						password = serviceManager.bCryptPasswordEncoder.encode(user.getPassword());

//									user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
					}

				}
				user.setPassword(password);

				User userAfterSave = serviceManager.userRepository.save(user);

			}

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getActiveUsersData" })
	@CrossOrigin("*")
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

			data.setData(userList);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getUserById" })
	@CrossOrigin("*")
	public String getUserById(HttpServletRequest request, @RequestBody User user) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

//					String  userName = (String) request.getSession().getAttribute("userName");
//					Integer  userId = (Integer) request.getSession().getAttribute("userId");

			User userop = serviceManager.userRepository.findById(user.getId()).get();

			data.setData(userop);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/setStatusOfUserById" })
	@CrossOrigin("*")
	public String setStatusOfUserById(HttpServletRequest request, @RequestBody User user) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String userName = (String) request.getSession().getAttribute("userName");
			Integer userId = (Integer) request.getSession().getAttribute("userId");

			serviceManager.userRepository.updateStatusByUserid(user.getStatus(), user.getId());

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/checkForExistingUserName" })
	@CrossOrigin("*")
	public String checkForExistingUserName(HttpServletRequest request, @RequestBody User user) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

//					String  userName = (String) request.getSession().getAttribute("userName");
//					Integer  userId = (Integer) request.getSession().getAttribute("userId");

			List<String> userStatusList = new ArrayList<>();
			userStatusList.add(GlobalConstants.ACTIVE_STATUS);
			userStatusList.add(GlobalConstants.CHANGE_PASSWORD_STATUS);

			String username = serviceManager.userRepository.checkForExistingUserName(user.getUsername(),
					userStatusList);

//			    	User userObj=serviceManager.userRepository.findByUsernameIgnoreCaseAndStatusIn(user.getUsername(), userStatusList);

			if (null == username) {
				data.setMsg("success");
			} else {
				data.setMsg("exist");
			}

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getUserByRole" })
	@CrossOrigin("*")
	public String getUserByRole(HttpServletRequest request, @RequestBody User user) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<User> users = serviceManager.userRepository.findByRoleIdAndStatus(user.getRoleId(),
					GlobalConstants.ACTIVE_STATUS);

			logger.info("" + users.size());
			data.setMsg("success");
			data.setData(users);
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
	@CrossOrigin("*")
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
			e.printStackTrace();
			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getVendorById" })
	@CrossOrigin("*")
	public String getVendorById(HttpServletRequest request, @RequestBody SupDetails details) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			SupDetails supDetails = serviceManager.supDetailsRepo.findBybpCode(details.getBpCode());

			data.setData(supDetails);
			data.setMsg("success");

			logger.info(" end to vendor details method");
		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/setStatusOfVendorByBpCode" })
	@CrossOrigin("*")
	public String setStatusOfVendorByBpCode(HttpServletRequest request, @RequestBody User user) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			serviceManager.userRepository.updateStatusOfVendorByBpCode(user.getStatus(), user.getBpCode());

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getAllVendorStatus" })
	@CrossOrigin("*")
	public String getAllVendorStatus(HttpServletRequest request, @RequestBody User details) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String bpCode = details.getBpCode();
			List<User> vendorListStatus = serviceManager.userRepository.getAllVendorStatus(bpCode);

			data.setData(vendorListStatus);
			data.setMsg("success");
			logger.info("end  to getActiveVendorData ");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : " + e);

		}

		return gson.toJson(data).toString();
	}

	@PostMapping({ "/activeVendor" })
	@CrossOrigin("*")
	public String activeVendor(HttpServletRequest request, @RequestBody User details) {

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
