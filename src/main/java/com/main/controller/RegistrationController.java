package com.main.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.SupDetails;
import com.main.payloads.SupDetailsDTO;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/registrationController")
@RestController
public class RegistrationController {

	@Autowired
	private ServiceManager serviceManager;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(RegistrationController.class);

	public synchronized String generateVendorCode() {

		String vendorCodePrefix = "Temp-";
		return vendorCodePrefix.concat(new SimpleDateFormat("yyyyHHmmssSSS").format(new Date()));
	}

	@PostMapping({ "/getPendingRequest" })
	public String getPendingRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<Object[]> users = serviceManager.supDetailsRepo
						.findByPendingVenStatus(GlobalConstants.PENDING_REQUEST_STATUS);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				data.setData(users);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getApprovedRequest" })
	public String getApprovedRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<Object[]> users = serviceManager.supDetailsRepo
						.findByPendingVenStatus(GlobalConstants.APPROVED_REQUEST_STATUS);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				data.setData(users);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getRejectedRequest" })
	public String getRejectedRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<Object[]> users = serviceManager.supDetailsRepo
						.findByPendingVenStatus(GlobalConstants.REJECTED_REQUEST_STATUS);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				data.setData(users);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getQueryRequest" })
	public String getQueryRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<Object[]> users = serviceManager.supDetailsRepo
						.findByPendingVenStatus(GlobalConstants.QUERY_REQUEST_STATUS);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				data.setData(users);
			}
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/updateVendorRegistrationStatus" })
	public String updateVendorRegistrationStatus(Principal principal, @RequestBody SupDetailsDTO objDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				SupDetails obj = serviceManager.supDetailsRepo.findByPid(objDto.getPid());
				data.setData(this.serviceManager.modelMapper.map(obj, SupDetailsDTO.class));
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getAllApprovedVendor" })

	public String getAllApprovedVendor(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)
					|| rolename.equalsIgnoreCase(GlobalConstants.ROLE_ADMIN)) {

				
				
				List<SupDetails> approvedVendor = serviceManager.supDetailsRepo
						.findByVenStatus();
				data.setData(approvedVendor);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/approveRequest" })
	public String approveRequest(Principal principal, @RequestBody SupDetailsDTO supDetailsDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String vendorCode = "";
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				vendorCode = generateVendorCode();

				serviceManager.supDetailsRepo.approveRequestByPid(vendorCode, supDetailsDto.getPid(),
						GlobalConstants.APPROVED_REQUEST_STATUS);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/rejectedRequest" })
	public String rejectedRequest(Principal principal, @RequestBody SupDetailsDTO supDetailsDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				serviceManager.supDetailsRepo.approveRequestByPid(supDetailsDto.getPid(),
						GlobalConstants.REJECTED_REQUEST_STATUS);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getAllRequest" })
	public String getAllRequest(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		try {

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_REGISTRATION_APPROVAL)) {

				List<SupDetails> findAll = serviceManager.supDetailsRepo.findAll();
				data.setData(findAll);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

}
