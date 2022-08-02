package com.main.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.Document;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.entity.User;
import com.main.payloads.QueryEntityDTO;
import com.main.payloads.SupDetailsDTO;
import com.main.service.UserServiceImpl;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/ajaxController")
@RestController
public class AjaxController {

	@Value("${logFilePath}")
	private String logFilePath;

	@Autowired
	private ServiceManager serviceManager;

	@Value("${filepaths}")
	public String filepaths;

	String processID = "";

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(AjaxController.class);

	@PostMapping("/SaveRegistration")
	@Transactional
	public String saveRegistration(@RequestBody SupDetailsDTO supDetailsDto, HttpServletRequest request) {

		logger.info("Log Some Information {} ");

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		processID = "";
		try {

			for (int i = 0; i < supDetailsDto.getAddressDetails().size(); i++) {
				String state = supDetailsDto.getAddressDetails().get(i).getState();
				String stCode = serviceManager.stateRepo.findByStateCode(state);

				String partnerType = supDetailsDto.getAddressDetails().get(i).getVendorType();
				String glCode = serviceManager.businessPartnerTypeRepo.getGlCodeByPartnerType(partnerType);
				if (!partnerType.isEmpty()) {
					String typeCode = serviceManager.businessPartnerTypeRepo.findByTypeCode(partnerType);
					supDetailsDto.getAddressDetails().get(i).setSupplierSiteCode(stCode.concat("_" + typeCode));
					supDetailsDto.getAddressDetails().get(i).setGlCode(glCode);
				}
			}
			if (supDetailsDto.getId() == null) {
				supDetailsDto.setVenStatus(GlobalConstants.PENDING_REQUEST_STATUS);
				SupDetails supSaved = serviceManager.detailsRepo
						.save(this.serviceManager.modelMapper.map(supDetailsDto, SupDetails.class));
				Long id = supSaved.getId();
				processID = GlobalConstants.VENDOR_PID_PREFIX + id + GlobalConstants.VENDOR_PID_SUFFIX;
				serviceManager.detailsRepo.updatePidInSupDetails(id, processID);
				data.setData(processID);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {

				if (supDetailsDto.getVenStatus().equals(GlobalConstants.APPROVED_REQUEST_STATUS)) {
					User us = new User();
					us.setBpCode(supDetailsDto.getBpCode());
					us.setUsername(supDetailsDto.getBpCode());
					us.setStatus(GlobalConstants.CHANGE_PASSWORD_STATUS);
					us.setRoleId(2);
					us.setVendorName(supDetailsDto.getSuppName());
					us.setContactNo(supDetailsDto.getContactDetails().get(0).getConPhone());
					us.setEmailId(supDetailsDto.getContactDetails().get(0).getConEmail());

					us.setFirstName(supDetailsDto.getContactDetails().get(0).getConFname());
					us.setLastName(supDetailsDto.getContactDetails().get(0).getConLname());
					us.setPassword(UserServiceImpl.generateRandomPassword());
					supDetailsDto.setVenStatus(GlobalConstants.UPDATE_VENDOR);
					serviceManager.userService.save(us);

					supDetailsDto.setFlag(GlobalConstants.SET_FLAG_TYPE_ACTIVE);
					serviceManager.detailsRepo
							.save(this.serviceManager.modelMapper.map(supDetailsDto, SupDetails.class));
					data.setData(processID);
					data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				} else if (supDetailsDto.getVenStatus().equals(GlobalConstants.UPDATE_VENDOR)) {
					supDetailsDto.setVenStatus(GlobalConstants.UPDATE_VENDOR);

					serviceManager.detailsRepo
							.save(this.serviceManager.modelMapper.map(supDetailsDto, SupDetails.class));
					data.setData(processID);
					data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				}
			}
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		String filePath = "C:/1.BPAAS/VendorPortal/" + processID;
		String fullFilePathWithName = "";
		File file1 = new File(filePath);

		if (!file1.exists()) {
			file1.mkdirs();
		}
		File logFilePathFolder = new File(logFilePath);
		if (!logFilePathFolder.exists()) {
			logFilePathFolder.mkdir();
		}
		if (null != supDetailsDto.getGstFileName()) {

			fullFilePathWithName = filePath + File.separator + supDetailsDto.getGstFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getGstFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getGstFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getPdFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getPdFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getPdFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getPdFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getPANFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getPANFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getPANFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getPANFileName();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getCcFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getCcFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getCcFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getCcFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getAcFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getAcFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getAcFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getAcFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getAplFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getAplFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getAplFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getAplFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getItrFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getItrFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getItrFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getItrFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);
				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getFuvfFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getFuvfFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getFuvfFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getFuvfFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getMsmecFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getMsmecFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getMsmecFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getMsmecFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getAmFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getAmFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getAmFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getAmFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getItraFileName1()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getItraFileName1();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getItraFileName1());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getItraFileText1();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getItraFileName2()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getItraFileName2();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getItraFileName2());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getItraFileText2();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getItraFileName3()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getItraFileName3();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getItraFileName3());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getItraFileText3();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}
		if (null != supDetailsDto.getNmisFileName()) {
			fullFilePathWithName = filePath + File.separator + supDetailsDto.getNmisFileName();

			Document doc = new Document();
			doc.setDocName(supDetailsDto.getNmisFileName());
			doc.setDocPath(fullFilePathWithName);
			doc.setStatus("1");
			doc.setType(GlobalConstants.SET_TYPE_REGISTRATION);
			doc.setForeignKey(processID);
			serviceManager.documentRepo.save(doc);

			try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
				String b64 = supDetailsDto.getNmisFileText();
				byte[] decoder = Base64.getDecoder().decode(b64);

				fos.write(decoder);
			} catch (Exception e) {
				logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
			}
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/saveRegistrationQuery" })
	public String saveRegistrationQuery(Principal principal, HttpServletRequest request,
			@RequestBody QueryEntityDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			Integer getid = entityDto.getId();

			if (getid != null) {
				entityDto.setId(null);
				entityDto.setForeignKey(getid);
				entityDto.setRaisedOn(new Date());
				entityDto.setReferenceid(entityDto.getRaisedAgainQuery());
				serviceManager.queryRepo.save(this.serviceManager.modelMapper.map(entityDto, QueryEntity.class));
			}
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getVendorDetailByPid" })
	public String getVendorDetailByPid(HttpServletRequest request, @RequestBody SupDetailsDTO objDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String pid = objDto.getPid();
		try {
			List<SupDetails> supDetails = serviceManager.supDetailsRepo.findBypid(pid);

			List<SupDetailsDTO> supDetailsToDTO = supDetails.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, SupDetailsDTO.class))
					.collect(Collectors.toList());
			data.setData(supDetailsToDTO);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/getRegistrationQueryData" })
	public String getRegistrationQueryData(HttpServletRequest request, @RequestBody QueryEntityDTO objDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {

			List<QueryEntity> list = serviceManager.queryRepo
					.findByReferenceidAndTypeOrderByIdDesc(objDto.getReferenceid(), objDto.getType());

			List<QueryEntityDTO> usersListDto = list.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, QueryEntityDTO.class))
					.collect(Collectors.toList());
			data.setData(usersListDto);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@GetMapping({ "/checkExistingPan" })
	public String getBpcode(@RequestParam("panNumber") String panNumber, @RequestParam("flag") String flag) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			String checkEmail = serviceManager.supDetailsRepo.checkPanNumber(panNumber, flag);
			if (null == checkEmail) {
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setMsg("exist");
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

}
