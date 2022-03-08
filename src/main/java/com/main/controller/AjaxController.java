/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.main.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.repo.SupDetailsRepo;
import com.main.db.bpaas.repo.TripDetailsRepo;
import com.main.email.CommEmailFunction;
import com.main.email.WelcomeEmail;
import com.main.service.SecurityService;
import com.main.service.UserService;
import com.sun.xml.messaging.saaj.packaging.mime.MessagingException;

@RequestMapping("/ajaxController")
@RestController
public class AjaxController {

	@Autowired
	private UserService userService;

	@Autowired
	private SupDetailsRepo detailsRepo;

	@Autowired
	private SecurityService securityService;

	@Autowired
	private TripDetailsRepo tripDetailsRepo;

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Value("${smtpPort}")
	public String smtpPort;

	@Value("${emailUserName}")
	public String username;

	@Value("${password}")
	public String password;

	@Value("${host}")
	public String host;

	@RequestMapping("/SaveRegistration")
	public String SaveRegistration(@RequestBody SupDetails supDetails) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {

//			supDetails.setId(id);
			String filePath = "C:/1.BPAAS/VendorPortal/" + supDetails.getCompEmail();
			String fullFilePathWithName = "";

			if (null != supDetails.getGstFileName()) {

				File file1 = new File(filePath);

				if (!file1.exists()) {
					file1.mkdirs();
				}
				// Creating the directory
//				boolean bool = 
//				System.out.println("vdsvsv " + bool);
				fullFilePathWithName = filePath + "/" + "GST Certificate-"
						+ supDetails.getGstFileName();
//				File file = new File(filePath);

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
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

				fullFilePathWithName = filePath + "/" + "Proprietorship Declaration-" + supDetails.getPdFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
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

				fullFilePathWithName = filePath + "/" + "PAN Certificate-" + supDetails.getpANFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
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

				fullFilePathWithName = filePath + "/" + "Cancelled Cheque-" + supDetails.getCcFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
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

				fullFilePathWithName = filePath + "/" + "Aadhar Card-" + supDetails.getAcFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
					String b64 = supDetails.getAcFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved" +fullFilePathWithName);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
			
			System.out.println("APL File name : " + supDetails.getAplFileName());
			if (null != supDetails.getAplFileName()) {

				fullFilePathWithName = filePath + "/" + "Aadhar and PAN Card linking declaration-" + supDetails.getAplFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
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

				fullFilePathWithName = filePath + "/" + "ITR Filling Declaration-" + supDetails.getItrFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
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

				fullFilePathWithName = filePath + "/" + "Filled Updated VRF Form-" + supDetails.getFuvfFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
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

				fullFilePathWithName = filePath + "/" + "MSME Certificate-" + supDetails.getMsmecFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
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

				fullFilePathWithName = filePath + "/" + "Approval Mail-" + supDetails.getAmFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
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

				fullFilePathWithName = filePath + "/" + "ITR Acknowledgment of 3 years-" + supDetails.getItraFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
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

				fullFilePathWithName = filePath + "/" + "Name mismatch affidavit-" + supDetails.getNmisFileName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
					String b64 = supDetails.getNmisFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

		//	System.out.println("supDetails " + supDetails.getCompEmail());
//			System.out.println("supDetails " + supDetails.getAccountDetails().get(0).getAccoutCurrency());
//			System.out.println("supDetails " + supDetails.getAddressDetails().get(0).getAddDetails());
//			System.out.println("supDetails " + supDetails.getContactDetails().get(0).getConEmail());
			
			
			supDetails.setPid("12");
			supDetails.setVenStatus("2");
			SupDetails supSaved = detailsRepo.save(supDetails);

			data.setData(supSaved);
			

			/*
			 * WFDetails wFDetails = new WFDetails();
			 * 
			 * wFDetails.setAssignedTo("shashank"); wFDetails.setStatus("RUNNING");
			 * wFDetails.setSupName(supDetails.getCompEmail());
			 * 
			 * wFDetails.setContactNum(supDetails.getPhoneNumber());
			 * wFDetails.setEmail(supDetails.getCompEmail());
			 * wFDetails.setExtID(supSaved.getId()); wFDetails.setType(1);
			 * wFDetails.setTypeDesc("Vendor On Board Request");
			 * 
			 * wFDetailsRepo.save(wFDetails);
			 */

			new Thread(new Runnable() {
				@Override
				public void run() {
					try {
						CommEmailFunction.sendEmail(supDetails.getCompEmail(), "Vendor Portal Req Acknowldgement",
								new WelcomeEmail().prepareMailBody("Vwndor"), smtpPort, username, password, host);

					} catch (Exception e) {
						e.printStackTrace();
					}
					Thread.currentThread().interrupt();
				}
			}).start();

			data.setMsg("success");
			//data.setData(refId);

		} catch (Exception e) {
			data.setMsg("error");
			data.setData(e.toString());
			e.printStackTrace();
		}

		return gson.toJson(data).toString();

	}

	@RequestMapping(value = "/checkemail", method = RequestMethod.POST)
	@CrossOrigin("*")
	public String checkEmail(@RequestParam(name = "email") String email)
			throws UnsupportedEncodingException, MessagingException {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		System.out.println("Email.check****************" + email);
		// return new ResponseEntity<>("ok",HttpStatus.OK);

		List<String> emailCheck = detailsRepo.checkEmail();
		boolean checkMailId = emailCheck.contains(email);
		System.out.println("Mail " + checkMailId);
		if (checkMailId == true) {

			// return Json(new { success = false, responseText = "The attached file is not
			// supported." }, JsonRequestBehavior.AllowGet);

			data.setMsg("Duplicate Mail Id ");

		} else {
			data.setMsg("New Mail Id");
		}
		return gson.toJson(data).toString();
	}

}
