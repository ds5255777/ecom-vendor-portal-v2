package com.main.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.SupDetails;										   
import com.main.db.bpaas.entity.User;
import com.main.db.bpaas.repo.SupDetailsRepo;
import com.main.db.bpaas.repo.UserRepository;											 
import com.main.service.UserService;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/userController")
@RestController
public class UserController {

	@Autowired
	ServiceManager serviceManager;

	@Autowired
	UserService userService;
	@Autowired
	SupDetailsRepo supDetailsRepo;
		   

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@RequestMapping({ "/saveUpdateUserDetails" })
	@CrossOrigin("*")
	public String saveUpdateUserDetails(HttpServletRequest request, @RequestBody User user) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

//					String  userName = (String) request.getSession().getAttribute("userName");
//					Integer  userId = (Integer) request.getSession().getAttribute("userId");

			if (null == user.getId()) {
				user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
				User userAfterSave = serviceManager.userRepository.save(user);

			} else {

				String password = serviceManager.userRepository.getUserPasswordById(user.getId());

				if (user.getPassword() != null) {

					if (!user.getPassword().equalsIgnoreCase("")) {

						password = bCryptPasswordEncoder.encode(user.getPassword());

//									user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
					}

				}
				user.setPassword(password);

				User userAfterSave = serviceManager.userRepository.save(user);

			}

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getActiveUsersData" })
	@CrossOrigin("*")
	public String getActiveUsersData(HttpServletRequest request) {

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

			e.printStackTrace();

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

			e.printStackTrace();

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

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/checkForExistingUserName" })
	@CrossOrigin("*")
	public String checkForExistingUserName(HttpServletRequest request, @RequestBody User user) {

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

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getUserByRole" })
	@CrossOrigin("*")
	public String getUserByRole(HttpServletRequest request, @RequestBody User user) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			List<User> users = serviceManager.userRepository.findByRoleIdAndStatus(user.getRoleId(),
					GlobalConstants.ACTIVE_STATUS);

			System.out.println(users.size());
			data.setMsg("success");
			data.setData(users);
		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public String changePassword(Principal principal,@RequestParam(name  = "password") String password) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println("Password is : "+password);
		try {
			User us = userService.findByUsername(principal.getName());
			us.setPassword(password);
			us.setStatus("1");
			userService.save(us);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}
	
	@RequestMapping({ "/getActiveVendorData" })
	@CrossOrigin("*")
	public String getActiveVendorData(HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
		
			List<SupDetails> vendorList = supDetailsRepo.getAllInActiveVendor();
			data.setData(vendorList);
			data.setMsg("success");
			System.out.println("end  to getActiveVendorData ");

		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}


	@RequestMapping({ "/getVendorById" })
	@CrossOrigin("*")
	public String getVendorById(HttpServletRequest request ,@RequestBody SupDetails details) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
		
			List<SupDetails> supDetails = supDetailsRepo.findByVendorCode(details.getBpCode());

			data.setData(supDetails);
			data.setMsg("success");

			System.out.println(" end to vendor details method");
		} catch (Exception e) {
			data.setMsg("error");

			e.printStackTrace();

		}

		return gson.toJson(data).toString();
	}

}
