package com.main.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.SupDetails;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/registrationController")
@RestController
public class RegistrationController {

	@Autowired
	private ServiceManager serviceManager;

	public synchronized String generateVendorCode() {

		/*
		 * long count = serviceManager.supDetailsRepo.count();
		 * System.out.println(count);
		 */
		String invoiceNumberPrefix = "Temp-";

		/* count = count + 1; */
		String invoiceNumber = invoiceNumberPrefix.concat(new SimpleDateFormat("yyyyHHmmssSSS").format(new Date()));

		return invoiceNumber;
	}

	@PostMapping({ "/getPendingRequest" })
	@CrossOrigin("*")
	public String getPendingRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<Object[]> users = serviceManager.supDetailsRepo
						.findByPendingVenStatus(GlobalConstants.PENDING_REQUEST_STATUS);
				data.setMsg("success");
				data.setData(users);
			}

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getApprovedRequest" })
	@CrossOrigin("*")
	public String getApprovedRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<Object[]> users = serviceManager.supDetailsRepo
						.findByPendingVenStatus(GlobalConstants.APPROVED_REQUEST_STATUS);
				data.setMsg("success");
				data.setData(users);
			}

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getRejectedRequest" })
	@CrossOrigin("*")
	public String getRejectedRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<Object[]> users = serviceManager.supDetailsRepo
						.findByPendingVenStatus(GlobalConstants.REJECTED_REQUEST_STATUS);
				data.setMsg("success");
				data.setData(users);
			}

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getQueryRequest" })
	@CrossOrigin("*")
	public String getQueryRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<Object[]> users = serviceManager.supDetailsRepo
						.findByPendingVenStatus(GlobalConstants.QUERY_REQUEST_STATUS);
				data.setMsg("success");
				data.setData(users);
			}
		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	// updateVendorRegistrationStatus

	@PostMapping({ "/updateVendorRegistrationStatus" })
	@CrossOrigin("*")
	public String updateVendorRegistrationStatus(Principal principal, @RequestBody SupDetails obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				obj = serviceManager.supDetailsRepo.findByPid(obj.getPid());
				data.setData(obj);
				data.setMsg("success");
			}

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getAllApprovedVendor" })
	@CrossOrigin("*")
	public String getAllApprovedVendor(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)
					|| rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {

				List<SupDetails> approvedVendor = serviceManager.supDetailsRepo
						.findByVenStatus(GlobalConstants.APPROVED_REQUEST_STATUS);
				data.setData(approvedVendor);
				data.setMsg("success");
			}

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/approveRequest" })
	@CrossOrigin("*")
	public String approveRequest(Principal principal, @RequestBody SupDetails supDetails) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String vendorCode = "";
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				vendorCode = generateVendorCode();

				serviceManager.supDetailsRepo.approveRequestByPid(vendorCode, supDetails.getPid(),
						GlobalConstants.APPROVED_REQUEST_STATUS);
				data.setMsg("success");
			}

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/rejectedRequest" })
	@CrossOrigin("*")
	public String rejectedRequest(Principal principal, @RequestBody SupDetails supDetails) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				serviceManager.supDetailsRepo.approveRequestByPid(supDetails.getPid(),
						GlobalConstants.REJECTED_REQUEST_STATUS);
				data.setMsg("success");
			}

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getAllRequest" })
	@CrossOrigin("*")
	public String getAllRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<SupDetails> findAll = serviceManager.supDetailsRepo.findAll();
				data.setData(findAll);
				data.setMsg("success");
			}

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

}
