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

	@RequestMapping({ "/saveUpdateUserDetails" })
	@CrossOrigin("*")
	public String saveUpdateUserDetails(HttpServletRequest request, @RequestBody User user) {
		
		logger.info("Log Some Information : "+dateTimeFormatter.format(LocalDateTime.now()));

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

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getActiveUsersData" })
	@CrossOrigin("*")
	public String getActiveUsersData(HttpServletRequest request) {
		
		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

//					String  userName = (String) request.getSession().getAttribute("userName");
//					Integer  userId = (Integer) request.getSession().getAttribute("userId");

			List<String> userStatusList = new ArrayList<>();
			userStatusList.add(GlobalConstants.ACTIVE_STATUS);
			userStatusList.add(GlobalConstants.CHANGE_PASSWORD_STATUS);
			userStatusList.add(GlobalConstants.INACTIVE_STATUS);

			List<User> userList = serviceManager.userRepository.findByStatusIn(userStatusList);

			data.setData(userList);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getUserById" })
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

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/setStatusOfUserById" })
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

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/checkForExistingUserName" })
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

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getUserByRole" })
	@CrossOrigin("*")
	public String getUserByRole(HttpServletRequest request, @RequestBody User user) {
		
		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<User> users = serviceManager.userRepository.findByRoleIdAndStatus(user.getRoleId(),
					GlobalConstants.ACTIVE_STATUS);

			logger.info(""+users.size());
			data.setMsg("success");
			data.setData(users);
		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
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

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getActiveVendorData" })
	@CrossOrigin("*")
	public String getActiveVendorData(HttpServletRequest request ) {
		
		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<Object[]> vendorList = serviceManager.supDetailsRepo.getAllInActiveVendor();
			
			List<SupplierDTO> sdtList=new ArrayList<>();
			for (Object[] objects : vendorList) {
				SupplierDTO sdt =new SupplierDTO();
				if(null!=objects[0]) {
					sdt.setIntroducedByName(objects[0].toString());
				}if(null!=objects[1]) {
					sdt.setSuppName(objects[1].toString());
				}if(null!=objects[2]) {
					sdt.setIntroducedByEmailID(objects[2].toString());
				}if(null!=objects[3]) {
					sdt.setPartnerType(objects[3].toString());
				}if(null!=objects[4]) {
					sdt.setVendorType(objects[4].toString());
				}if(null!=objects[5]) {
					sdt.setPid(objects[5].toString());
				} /*
					 * if(null!=objects[7]) { sdt.setVendorType(objects[7].toString()); }
					 */ /*
					 * if(null!=objects[8]) { sdt.setPhoneNumber(objects[8].toString());
					 * }if(null!=objects[9]) { sdt.setStatus(objects[9].toString());
					 * }if(null!=objects[10]) { sdt.setBpCode(objects[10].toString()); }
					 */
				sdtList.add(sdt);
			}
			
			data.setData(sdtList);
			data.setMsg("success");
			logger.info("end  to getActiveVendorData ");

		} catch (Exception e) {
			data.setMsg("error");
e.printStackTrace();
			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}

	
	@RequestMapping({ "/getVendorById" })
	@CrossOrigin("*")
	public String getVendorById(HttpServletRequest request, @RequestBody SupDetails details) {
		
		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<SupDetails> supDetails = serviceManager.supDetailsRepo.findBypid(details.getPid());

			data.setData(supDetails);
			data.setMsg("success");

			logger.info(" end to vendor details method");
		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}
	
	@RequestMapping({ "/setStatusOfVendorByBpCode" })
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

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}
	@RequestMapping({ "/getAllVendorStatus" })
	@CrossOrigin("*")
	public String getAllVendorStatus(HttpServletRequest request , @RequestBody User details) {
		
		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String bpCode=details.getBpCode();
			List<User> vendorListStatus = serviceManager.userRepository.getAllVendorStatus(bpCode);
			
			data.setData(vendorListStatus);
			data.setMsg("success");
			logger.info("end  to getActiveVendorData ");

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}
	@RequestMapping({ "/activeVendor" })
	@CrossOrigin("*")
	public String activeVendor(HttpServletRequest request , @RequestBody User details) {
		
		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String bpCode=details.getBpCode();
			String status=details.getStatus();
			  serviceManager.userRepository.updateStatusOfVendorByBpCode(status,bpCode);
			
			
			data.setMsg("success");
			logger.info(" activeVendor status  : "+status);

		} catch (Exception e) {
			data.setMsg("error");

			logger.error("error : "+e);

		}

		return gson.toJson(data).toString();
	}

	

}
