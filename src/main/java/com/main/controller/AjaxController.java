package com.main.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.AccountDetails;
import com.main.db.bpaas.entity.AddressDetails;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.SupDetails;
import com.main.email.CommEmailFunction;
import com.main.email.WelcomeEmail;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/ajaxController")
@RestController
public class AjaxController {

	@Autowired
	private ServiceManager serviceManager;

	@Value("${smtpPort}")
	public String smtpPort;

	@Value("${emailUserName}")
	public String username;

	@Value("${password}")
	public String password;

	@Value("${host}")
	public String host;
	
	@Value("${filepaths}")
	public String filepaths;
	
	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(AjaxController.class);

	@PostMapping("/SaveRegistration")
	public String SaveRegistration(@RequestBody SupDetails supDetails) {

		logger.info("Log Some Information", dateTimeFormatter.format(LocalDateTime.now()));

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String processID = "";

		try {

			String filePath = filepaths + supDetails.getCompEmail();
			String fullFilePathWithName = "";

//			
			JSONArray array = new JSONArray();
			JSONObject DocumentObj = new JSONObject();
			String[] documentExtensionArray = null;
			String filename = null;
			String documentExtension = null;
			if (null != supDetails.getGstFileName()) {

				documentExtensionArray = supDetails.getGstFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];

				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", filename);
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetails.getGstFileText());
				array.put(DocumentObj);

				File file1 = new File(filePath);

				if (!file1.exists()) {
					file1.mkdirs();
				}
				fullFilePathWithName = filePath + "/" + "GST Certificate-" + supDetails.getGstFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = supDetails.getGstFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			System.out.println("PD File Name : " + supDetails.getPdFileName());

			if (null != supDetails.getPdFileName()) {

				documentExtensionArray = supDetails.getPdFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];

				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", filename);
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetails.getPdFileText());
				array.put(DocumentObj);

				fullFilePathWithName = filePath + "/" + "Proprietorship Declaration-" + supDetails.getPdFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = supDetails.getPdFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			System.out.println("PAN File name : " + supDetails.getpANFileName());
			if (null != supDetails.getpANFileName()) {

				documentExtensionArray = supDetails.getpANFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];

				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", filename);
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetails.getpANFileText());
				array.put(DocumentObj);

				fullFilePathWithName = filePath + "/" + "PAN Certificate-" + supDetails.getpANFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = supDetails.getpANFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			System.out.println("CC File name : " + supDetails.getCcFileName());

			if (null != supDetails.getCcFileName()) {

				documentExtensionArray = supDetails.getCcFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];

				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", filename);
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetails.getCcFileText());
				array.put(DocumentObj);

				fullFilePathWithName = filePath + "/" + "Cancelled Cheque-" + supDetails.getCcFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = supDetails.getCcFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			System.out.println("AC File name : " + supDetails.getAcFileName());
			if (null != supDetails.getAcFileName()) {

				documentExtensionArray = supDetails.getAcFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];

				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", filename);
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetails.getAcFileText());
				array.put(DocumentObj);

				fullFilePathWithName = filePath + "/" + "Aadhar Card-" + supDetails.getAcFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = supDetails.getAcFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved" + fullFilePathWithName);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			System.out.println("APL File name : " + supDetails.getAplFileName());
			if (null != supDetails.getAplFileName()) {

				documentExtensionArray = supDetails.getAplFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];

				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", filename);
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetails.getAplFileText());
				array.put(DocumentObj);

				fullFilePathWithName = filePath + "/" + "Aadhar and PAN Card linking declaration-"
						+ supDetails.getAplFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = supDetails.getAplFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			System.out.println("ITR File name 1 : " + supDetails.getItrFileName());
			if (null != supDetails.getItrFileName()) {

				documentExtensionArray = supDetails.getItrFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];

				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", filename);
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetails.getItrFileText());
				array.put(DocumentObj);

				fullFilePathWithName = filePath + "/" + "ITR Filling Declaration-" + supDetails.getItrFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = supDetails.getItrFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);
					fos.write(decoder);
					System.out.println("File Saved ");
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			System.out.println("FUVF File name : " + supDetails.getFuvfFileName());
			if (null != supDetails.getFuvfFileName()) {

				documentExtensionArray = supDetails.getFuvfFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];

				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", filename);
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetails.getFuvfFileText());
				array.put(DocumentObj);

				fullFilePathWithName = filePath + "/" + "Filled Updated VRF Form-" + supDetails.getFuvfFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = supDetails.getFuvfFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			System.out.println("MSME File name : " + supDetails.getMsmecFileName());
			if (null != supDetails.getMsmecFileName()) {

				documentExtensionArray = supDetails.getMsmecFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];

				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", filename);
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetails.getMsmecFileText());
				array.put(DocumentObj);

				fullFilePathWithName = filePath + "/" + "MSME Certificate-" + supDetails.getMsmecFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = supDetails.getMsmecFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			System.out.println("AM File name : " + supDetails.getAmFileName());
			if (null != supDetails.getAmFileName()) {

				documentExtensionArray = supDetails.getAmFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];

				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", filename);
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetails.getAmFileText());
				array.put(DocumentObj);

				fullFilePathWithName = filePath + "/" + "Approval Mail-" + supDetails.getAmFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = supDetails.getAmFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			System.out.println("ITRA File name : " + supDetails.getItraFileName());
			if (null != supDetails.getItraFileName()) {

				documentExtensionArray = supDetails.getItraFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];

				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", filename);
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetails.getItraFileText());
				array.put(DocumentObj);

				fullFilePathWithName = filePath + "/" + "ITR Acknowledgment of 3 years-" + supDetails.getItraFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = supDetails.getItraFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			System.out.println("NMIS File name : " + supDetails.getNmisFileName());
			if (null != supDetails.getNmisFileName()) {

				documentExtensionArray = supDetails.getNmisFileName().split("\\.(?=[^\\.]+$)");
				filename = documentExtensionArray[0];
				documentExtension = documentExtensionArray[1];

				DocumentObj = new JSONObject();
				DocumentObj.put("DocName", filename);
				DocumentObj.put("Extension", documentExtension);
				DocumentObj.put("Encoded", supDetails.getNmisFileText());
				array.put(DocumentObj);

				fullFilePathWithName = filePath + "/" + "Name mismatch affidavit-" + supDetails.getNmisFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = supDetails.getNmisFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

			// Vendor API calling
			String vendor = "";
			try {
				String urldata = "http://65.1.184.148:8080/VendorPortal/portal/createUpdate/vendor";
				URL url = new URL(urldata);
				System.out.println("In here*************");
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				// body
				JSONObject json = new JSONObject();
				json.put("processid", "");
				json.put("supplier_name", supDetails.getSuppName());
				json.put("pan_number", supDetails.getPanNumber());
				json.put("alternate_supplier_name", "");
				json.put("supplier_type", supDetails.getVendorType());

				if (!supDetails.getAccountDetails().isEmpty()) {
					List<AccountDetails> acntDetails = supDetails.getAccountDetails();
					for (int i = 0; i < acntDetails.size(); i++) {
						json.put("bank_name", supDetails.getAccountDetails().get(i).getBankName());

						json.put("account_name", "");
						json.put("account_number", supDetails.getAccountDetails().get(i).getAccoutNumber());
						json.put("ifsc_code", supDetails.getAccountDetails().get(i).getIfscCode());
					}
				}
				json.put("sd_Website", "");
				json.put("sd_Alias", "");
				json.put("sd_Unmatched_Inv", "");
				json.put("sd_ADD_PURCHASING", "");
				json.put("sd_ADDRESS_PAYMENT", "");
				json.put("sd_INV_PREVALIDATED", "");
				json.put("hd_Adhaar", supDetails.getAadharNumber());
				json.put("hd_Adhaar_LinkStatus", supDetails.getAdharLinkStatus());

				if (supDetails.getItrDetails().size() < 3) {
					System.out.println("please enter three itr details");

				} else {

					json.put("itr_Ack_No_1", supDetails.getItrDetails().get(0).getAcknowledgementNumber());
					json.put("itr_Ack_No_2", supDetails.getItrDetails().get(1).getAcknowledgementNumber());
					json.put("itr_Ack_No_3", supDetails.getItrDetails().get(2).getAcknowledgementNumber());

					json.put("itr_year1", supDetails.getItrDetails().get(0).getFyYear());
					json.put("itr_year2", supDetails.getItrDetails().get(1).getFyYear());
					json.put("itr_year3", supDetails.getItrDetails().get(2).getFyYear());
				}

				json.put("typeofRequest", "");
				json.put("business_classification", supDetails.getBusinessClassification());
				json.put("certificate_no", "");
				json.put("certifing_agency", "");

				// json.put("VendorSiteDetails", "");
				// Documents
//				String runType = supDetails.getVendorType();		
//				if("Ad-Hoc".equalsIgnoreCase(runType)) {
//					   
//				}

				// Adding Vendor Details
				JSONObject venDetals = new JSONObject();
				venDetals.put("ln_SupplierSiteCode", "");
				venDetals.put("ln_VendorType", supDetails.getVendorType());

				if (!supDetails.getAddressDetails().isEmpty()) {
					List<AddressDetails> adrsDetails = supDetails.getAddressDetails();
					for (int i = 0; i < adrsDetails.size(); i++) {

						venDetals.put("ln_Addressline1", adrsDetails.get(i).getAddDetails());
						venDetals.put("ln_Addressline2", "");
						venDetals.put("ln_Addressline3", "");
						venDetals.put("ln_Addressline4", "");
						venDetals.put("ln_City", adrsDetails.get(i).getCity());
						venDetals.put("ln_State", adrsDetails.get(i).getState());
						venDetals.put("ln_Country", adrsDetails.get(i).getAddCountry());
						venDetals.put("ln_PinCode", adrsDetails.get(i).getPinCode());

					}

					venDetals.put("ln_operatingUnit", "");
					venDetals.put("ln_PhoneAreaCode", "");
					venDetals.put("ln_LandlineNumber", "");
					venDetals.put("ln_BeneficiaryName", "");
					venDetals.put("ln_ContactPerson", "");
					venDetals.put("ln_EmailAddress", supDetails.getCompEmail());
					venDetals.put("ln_NatureofTrans", supDetails.getNatureOfTransactions());
					venDetals.put("ln_MobileNumber", supDetails.getPhoneNumber());
					venDetals.put("ln_PaymentMethod", supDetails.getPaymentMethod());

//				
//				venDetals.put("ln_BankName", "");
//				venDetals.put("ln_AccountNumber", "");
//				venDetals.put("ln_IFSCcode", "");

					venDetals.put("ln_Currency", "");
					venDetals.put("ln_PaymentTerms", "");
					venDetals.put("ln_GLAccount", "");
					venDetals.put("ln_GSTPartyType", "");

					venDetals.put("ln_InvoiceCurrency", supDetails.getInvoiceCurrency());
					venDetals.put("ln_PaymentCurrency", supDetails.getPaymentCurrency());
					venDetals.put("ln_SupplierGSTRegNo", supDetails.getCompGstn());
					// venDetals.put("vendorportal_regno", "sdf");
					venDetals.put("ln_TDSSection", supDetails.getTdsSection());

					JSONArray arrayforVend = new JSONArray();

					arrayforVend.put(venDetals);
					System.out.println("Fin Json " + venDetals.toString());
					System.out.println("Vendor Site Details " + arrayforVend.toString());
					System.out.println("Header " + json.toString());
					System.out.println("----------------------" + array);
					json.put("Documents", array);
					json.put("VendorSiteDetails", arrayforVend);

					System.out.println("JSON is ::" + json.toString());
					// HEADER

					conn.setRequestMethod("PUT");
					conn.setRequestProperty("Content-Type", "application/json");

					conn.setRequestProperty("Authorization", "Basic bmV3Z2VuOlZFbkQwclBANFQ4OSE=");

					conn.setDoOutput(true);

					OutputStream os = conn.getOutputStream();
					os.write(json.toString().getBytes());
					os.flush();
					if (conn.getResponseCode() != 200) {
						throw new RuntimeException("Failed : HTTP Error code : " + conn.getResponseCode());
					} else {
						System.out.println("conn.responsecode" + conn.getResponseCode());
					}
					InputStreamReader in = new InputStreamReader(conn.getInputStream());
					BufferedReader br = new BufferedReader(in);
					String finalOut = "";
					String outputloop = "";
					while ((outputloop = br.readLine()) != null) {
						finalOut = finalOut + outputloop;
						System.out.println("finalOut :\n" + finalOut);

					}

					System.out.println("Final output ::: " + finalOut);
//            vendor = finalOut.toString();

					if ("".equalsIgnoreCase(finalOut)) {
						System.out.println("Error!!!!!!!!!Output from authentication web service is null");
					} else {
						System.out.println(" FinalOutput JSON in api ::: " + finalOut);
					}

					JSONObject jsonObject = new JSONObject(finalOut);
					if (null != jsonObject) {
						String statuscode = jsonObject.optString("Status");
						if ("201".equalsIgnoreCase(statuscode)) {
							processID = jsonObject.optString("ProcessID");

							supDetails.setPid(processID);
							System.out.println("   ------------" + processID);

						}

					}

					conn.disconnect();
					logger.error("Ran into an error {}");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

//API calling END
			serviceManager.detailsRepo.save(supDetails);

			data.setData(processID);

			new Thread(new Runnable() {
				@Override
				public void run() {
					try {
						List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");
						
						if(!emailList.isEmpty()) {
							EmailConfiguration emailConfiguration=emailList.get(0);
							
							CommEmailFunction.sendEmail(supDetails.getCompEmail(), "Vendor Portal Req Acknowldgement",
									new WelcomeEmail().prepareMailBody("Vendor"), emailConfiguration.getSmtpPort(), emailConfiguration.getUserName(), emailConfiguration.getPassword(), emailConfiguration.getServerName());
						}
						 
						
						

					} catch (Exception e) {
						e.printStackTrace();
					}
					Thread.currentThread().interrupt();
				}
			}).start();

			data.setMsg("success");

		} catch (

		Exception e) {
			data.setMsg("error");
			data.setData(e.toString());
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}
}
