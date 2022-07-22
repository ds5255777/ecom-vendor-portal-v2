package com.main.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.CrossOrigin;
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
import com.main.payloads.UserDTO;
import com.main.service.UserServiceImpl;
import com.main.serviceManager.ServiceManager;

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
	public String SaveRegistration(@RequestBody SupDetailsDTO supDetailsDto, HttpServletRequest request) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String contents = "";
		processID = "";
		try {
			// Vendor API calling
			/*
			 * try { //String urldata =
			 * "http://65.1.184.148:8080/VendorPortal/portal/createUpdate/vendor"; String
			 * urldata=""; URL url = new URL(urldata); HttpURLConnection conn =
			 * (HttpURLConnection) url.openConnection(); JSONObject json = new JSONObject();
			 * String pid = supDetails.getPid(); if (pid != null) { json.put("processid",
			 * pid); } String vendorType = supDetails.getVendorType(); if
			 * (vendorType.equalsIgnoreCase("Network")) { json.put("supplier_type",
			 * "NETWORK CREDITORS"); } else { json.put("supplier_type",
			 * supDetails.getVendorType()); } json.put("supplier_name",
			 * supDetails.getSuppName()); json.put("pan_number", supDetails.getPanNumber());
			 * json.put("alternate_supplier_name", ""); if
			 * (!supDetails.getAccountDetails().isEmpty()) { List<AccountDetails>
			 * acntDetails = supDetails.getAccountDetails(); for (int i = 0; i <
			 * acntDetails.size(); i++) { json.put("bank_name",
			 * supDetails.getAccountDetails().get(i).getBankName());
			 * json.put("account_name", ""); json.put("account_number",
			 * supDetails.getAccountDetails().get(i).getAccoutNumber());
			 * json.put("ifsc_code", supDetails.getAccountDetails().get(i).getIfscCode()); }
			 * } if (!supDetails.getContactDetails().isEmpty()) { List<ContactDetails>
			 * contactDetails = supDetails.getContactDetails(); for (int i = 0; i <
			 * contactDetails.size(); i++) { json.put("ln_EmailAddress",
			 * contactDetails.get(i).getConEmail()); } }
			 * 
			 * json.put("sd_Website", ""); json.put("sd_Alias", "");
			 * json.put("sd_Unmatched_Inv", ""); json.put("sd_ADD_PURCHASING", "");
			 * json.put("sd_ADDRESS_PAYMENT", ""); json.put("sd_INV_PREVALIDATED", "");
			 * json.put("hd_Adhaar", supDetails.getAadharNumber());
			 * json.put("hd_Adhaar_LinkStatus", supDetails.getAdharLinkStatus());
			 * 
			 * json.put("itr_Ack_No_1", supDetails.getAcknowledgementNumber1());
			 * json.put("itr_Ack_No_2", supDetails.getAcknowledgementNumber2());
			 * json.put("itr_Ack_No_3", supDetails.getAcknowledgementNumber3());
			 * json.put("itr_year1", supDetails.getFyYear1()); json.put("itr_year2",
			 * supDetails.getFyYear2()); json.put("itr_year3", supDetails.getFyYear3());
			 * 
			 * json.put("typeofRequest", ""); json.put("business_classification",
			 * supDetails.getBusinessClassification()); json.put("certificate_no", "");
			 * json.put("certifing_agency", ""); // Adding Vendor Details JSONObject
			 * venDetals = new JSONObject(); venDetals.put("ln_SupplierSiteCode", "");
			 * String venType = supDetails.getVendorType(); if
			 * (venType.equalsIgnoreCase("Network")) { venDetals.put("ln_VendorType",
			 * "NETWORK CREDITORS"); } else { venDetals.put("ln_VendorType",
			 * supDetails.getVendorType()); } if (!supDetails.getAddressDetails().isEmpty())
			 * { List<AddressDetails> adrsDetails = supDetails.getAddressDetails(); for (int
			 * i = 0; i < adrsDetails.size(); i++) { venDetals.put("ln_Addressline1",
			 * adrsDetails.get(i).getAddDetails()); venDetals.put("ln_Addressline2", "");
			 * venDetals.put("ln_Addressline3", ""); venDetals.put("ln_Addressline4", "");
			 * venDetals.put("ln_City", adrsDetails.get(i).getCity());
			 * venDetals.put("ln_State", adrsDetails.get(i).getState());
			 * venDetals.put("ln_Country", adrsDetails.get(i).getAddCountry());
			 * venDetals.put("ln_PinCode", adrsDetails.get(i).getPinCode());
			 * venDetals.put("ln_NatureofTrans",
			 * adrsDetails.get(i).getNatureOfTransactions());
			 * venDetals.put("ln_SupplierGSTRegNo", adrsDetails.get(i).getCompGstn()); //
			 * venDetals.put("ln_EmailAddress", adrsDetails.get(i).getCompEmail()); //
			 * venDetals.put("ln_MobileNumber", adrsDetails.get(i).getPhoneNumber()); }
			 * venDetals.put("ln_operatingUnit", ""); venDetals.put("ln_PhoneAreaCode", "");
			 * venDetals.put("ln_LandlineNumber", ""); venDetals.put("ln_BeneficiaryName",
			 * ""); venDetals.put("ln_ContactPerson", ""); //
			 * venDetals.put("ln_EmailAddress", supDetails.getCompEmail()); //
			 * venDetals.put("ln_NatureofTrans", supDetails.getNatureOfTransactions()); //
			 * venDetals.put("ln_MobileNumber", supDetails.getPhoneNumber());
			 * venDetals.put("ln_PaymentMethod", supDetails.getPaymentMethod()); //
			 * venDetals.put("ln_BankName", ""); // venDetals.put("ln_AccountNumber", "");
			 * // venDetals.put("ln_IFSCcode", ""); venDetals.put("ln_Currency", "");
			 * venDetals.put("ln_PaymentTerms", ""); venDetals.put("ln_GLAccount", "");
			 * venDetals.put("ln_GSTPartyType", ""); venDetals.put("ln_InvoiceCurrency",
			 * supDetails.getInvoiceCurrency()); venDetals.put("ln_PaymentCurrency",
			 * supDetails.getPaymentCurrency()); // venDetals.put("ln_SupplierGSTRegNo",
			 * supDetails.getCompGstn()); // venDetals.put("vendorportal_regno", "sdf");
			 * venDetals.put("ln_TDSSection", supDetails.getTdsSection()); JSONArray
			 * arrayforVend = new JSONArray(); arrayforVend.put(venDetals);
			 * json.put("Documents", array); json.put("VendorSiteDetails", arrayforVend);
			 * conn.setRequestMethod("PUT"); conn.setRequestProperty("Content-Type",
			 * "application/json"); conn.setRequestProperty("Authorization",
			 * "Basic bmV3Z2VuOlZFbkQwclBANFQ4OSE=");
			 * 
			 * 
			 * try (Writer writer = new BufferedWriter(new FileWriter(file))) {
			 * writer.write(contents + "\n" + "venDetals Object start----" +
			 * venDetals.toString() + "----venDetals Object End---Doc Array start-----" +
			 * array+"---Doc Array End"); }
			 * 
			 * 
			 * conn.setDoOutput(true); OutputStream os = conn.getOutputStream();
			 * logger.info(":::::::::JSON:::::::::::" + json.toString());
			 * os.write(json.toString().getBytes()); os.flush(); if (conn.getResponseCode()
			 * != 200) { throw new RuntimeException("Failed : HTTP Error code : " +
			 * conn.getResponseCode()); } else { logger.info("conn.responsecode" +
			 * conn.getResponseCode()); } InputStreamReader in = new
			 * InputStreamReader(conn.getInputStream()); BufferedReader br = new
			 * BufferedReader(in); String finalOut = ""; String outputloop = ""; while
			 * ((outputloop = br.readLine()) != null) { finalOut = finalOut + outputloop;
			 * logger.info("finalOut :\n" + finalOut); } logger.info("Final output ::: " +
			 * finalOut); // vendor = finalOut.toString();
			 * 
			 * if ("".equalsIgnoreCase(finalOut)) {
			 * logger.info("Error!!!!!!!!!Output from authentication web service is null");
			 * } else { logger.info(" FinalOutput JSON in api ::: " + finalOut); }
			 * JSONObject jsonObject = new JSONObject(finalOut); if (null != jsonObject) {
			 * String statuscode = jsonObject.optString("Status"); if
			 * ("201".equalsIgnoreCase(statuscode)) { processID =
			 * jsonObject.optString("ProcessID"); supDetails.setPid(processID);
			 * logger.info(" ------------" + processID); } } conn.disconnect(); try (Writer
			 * writer = new BufferedWriter(new FileWriter(file))) { writer.write(contents +
			 * "\n" + "venDetals Object start----" + venDetals.toString() +
			 * "----venDetals Object End---Doc Array start-----" + array +
			 * "---Doc Array End"); } } } catch (Exception e) { logger.error("error : " +
			 * e); e.printStackTrace(); }
			 */

			// serviceManager.supDetailsRepo.

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
				SupDetails supSaved = serviceManager.detailsRepo.save(this.serviceManager.modelMapper.map(supDetailsDto, SupDetails.class));
				Long id = supSaved.getId();
				processID = GlobalConstants.VENDOR_PID_PREFIX + id + GlobalConstants.VENDOR_PID_SUFFIX;
				serviceManager.detailsRepo.updatePidInSupDetails(id, processID);
				data.setData(processID);
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
					serviceManager.detailsRepo.save(this.serviceManager.modelMapper.map(supDetailsDto, SupDetails.class));
					data.setData(processID);
					data.setMsg("success");
				} else if (supDetailsDto.getVenStatus().equals(GlobalConstants.UPDATE_VENDOR)) {
					supDetailsDto.setVenStatus(GlobalConstants.UPDATE_VENDOR);

					serviceManager.detailsRepo.save(this.serviceManager.modelMapper.map(supDetailsDto, SupDetails.class));
					data.setData(processID);
					data.setMsg("success");
				}
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
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
			String currentDateTimeString = sdf.format(new Date());
			File file = new File(logFilePath + File.separator + currentDateTimeString + ".txt");
			contents = "Current Date is-" + currentDateTimeString + "\n";
			JSONArray array = new JSONArray();
			JSONObject DocumentObj = new JSONObject();
			String[] documentExtensionArray = null;
			String filename = null;
			String documentExtension = null;
			if (null != supDetailsDto.getGstFileName()) {
				documentExtensionArray = supDetailsDto.getGstFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "GST_CERTIFICATE");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getGstFileText());
				array.put(DocumentObj);

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
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (null != supDetailsDto.getPdFileName()) {
				documentExtensionArray = supDetailsDto.getPdFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "PROPRIETORSHIP");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getPdFileText());
				array.put(DocumentObj);
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
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (null != supDetailsDto.getPANFileName()) {
				documentExtensionArray = supDetailsDto.getPANFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "PANCARD");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getPANFileText());
				array.put(DocumentObj);
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
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (null != supDetailsDto.getCcFileName()) {
				documentExtensionArray = supDetailsDto.getCcFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "CANCELL_CHQ");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getCcFileText());
				array.put(DocumentObj);
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
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (null != supDetailsDto.getAcFileName()) {
				documentExtensionArray = supDetailsDto.getAcFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "AADHAR");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getAcFileText());
				array.put(DocumentObj);
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
					System.out.println("File Saved" + fullFilePathWithName);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (null != supDetailsDto.getAplFileName()) {
				documentExtensionArray = supDetailsDto.getAplFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "AADHAR_PAN_LINK");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getAplFileText());
				array.put(DocumentObj);
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
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			// ITR filling declaration
			if (null != supDetailsDto.getItrFileName()) {
				documentExtensionArray = supDetailsDto.getItrFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "ITR");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getItrFileText());
				array.put(DocumentObj);
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
					System.out.println("File Saved ");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (null != supDetailsDto.getFuvfFileName()) {
				documentExtensionArray = supDetailsDto.getFuvfFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "VRF");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getFuvfFileText());
				array.put(DocumentObj);
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
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (null != supDetailsDto.getMsmecFileName()) {
				documentExtensionArray = supDetailsDto.getMsmecFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "MSME");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getMsmecFileText());
				array.put(DocumentObj);
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
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (null != supDetailsDto.getAmFileName()) {
				documentExtensionArray = supDetailsDto.getAmFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "APPROVER_MAIL");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getAmFileText());
				array.put(DocumentObj);
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
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			// last three year ITR file
			if (null != supDetailsDto.getItraFileName1()) {
				documentExtensionArray = supDetailsDto.getItraFileName1().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "ITR1");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getItraFileText1());
				array.put(DocumentObj);
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
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (null != supDetailsDto.getItraFileName2()) {
				documentExtensionArray = supDetailsDto.getItraFileName2().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "ITR2");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getItraFileText2());
				array.put(DocumentObj);
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
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (null != supDetailsDto.getItraFileName3()) {
				documentExtensionArray = supDetailsDto.getItraFileName3().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "ITR3");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getItraFileText3());
				array.put(DocumentObj);
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
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (null != supDetailsDto.getNmisFileName()) {
				documentExtensionArray = supDetailsDto.getNmisFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];
				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", "NAME_AFFI");
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetailsDto.getNmisFileText());
				array.put(DocumentObj);

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
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		} catch (Exception e) {
			data.setMsg("error");
			data.setData(e.toString());
			e.printStackTrace();
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/saveRegistrationQuery" })
	@CrossOrigin("*")
	public String saveRegistrationQuery(Principal principal, HttpServletRequest request,
			@RequestBody QueryEntityDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			Integer getid = entityDto.getId();

			if (getid != null) {
				entityDto.setId(null);
				entityDto.setForeignKey(getid);
				entityDto.setRaisedOn(new Date());
				entityDto.setReferenceid(entityDto.getRaisedAgainQuery());
				serviceManager.queryRepo.save(this.serviceManager.modelMapper.map(entityDto, QueryEntity.class));
			}
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : " + e);
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getVendorDetailByPid" })
	@CrossOrigin("*")
	public String getVendorDetailByPid(HttpServletRequest request, @RequestBody SupDetailsDTO objDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String pid = objDto.getPid();
		logger.info("pid my : " + objDto.getPid());
		try {
			List<SupDetails> supDetails = serviceManager.supDetailsRepo.findBypid(pid);
			
			List<SupDetailsDTO> supDetailsToDTO = supDetails.stream()
					.map((listOfUser) -> this.serviceManager.modelMapper.map(listOfUser, SupDetailsDTO.class))
					.collect(Collectors.toList());
			boolean empty = supDetails.isEmpty();
			logger.info("empty :" + empty);
			data.setData(supDetailsToDTO);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}
		return gson.toJson(data).toString();
	}

	@PostMapping({ "/getRegistrationQueryData" })
	@CrossOrigin("*")
	public String getRegistrationQueryData(HttpServletRequest request, @RequestBody QueryEntityDTO objDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {

			List<QueryEntity> list = serviceManager.queryRepo
					.findByReferenceidAndTypeOrderByIdDesc(objDto.getReferenceid(), objDto.getType());
			
			List<QueryEntityDTO> usersListDto = list.stream()
					.map((listOfUser) -> this.serviceManager.modelMapper.map(listOfUser, QueryEntityDTO.class))
					.collect(Collectors.toList());
			data.setData(usersListDto);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
			logger.error("error : " + e);
		}
		return gson.toJson(data).toString();
	}

	@GetMapping({ "/checkExistingPan" })
	@CrossOrigin("*")
	public String getBpcode( @RequestParam("panNumber")String panNumber,@RequestParam("flag")String flag) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			String checkEmail = serviceManager.supDetailsRepo.checkPanNumber(panNumber,flag);
			if (null == checkEmail) {
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

}
