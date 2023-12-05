package com.main.controller;

import java.security.Principal;
import java.security.SecureRandom;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.itextpdf.text.log.SysoCounter;
import com.main.bean.DataContainer;
import com.main.commonclasses.CommanFunction;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.CommentHistory;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.MailContent;
import com.main.db.bpaas.entity.SendEmailToVendor;
import com.main.db.bpaas.entity.User;
import com.main.db.bpaas.repo.CommentHistoryRepo;
import com.main.payloads.SendEmailToVendorDTO;
import com.main.payloads.UserDTO;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/commercialMailController")
@RestController
public class CommercialMailingController {

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(CommercialMailingController.class);

	@Autowired
	private ServiceManager serviceManager;

	@Autowired
	private CommentHistoryRepo commentsRepo;

	@Value("${registrationLink}")
	private String registrationLink;

	String emailBody = "";
	String processID = "";

	@PostMapping({ "/sendEmailToVendor" })
	public String sendEmailToVendor(HttpServletRequest request, Principal principal,
			@RequestBody SendEmailToVendorDTO entityDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			final Random rand = SecureRandom.getInstanceStrong();
			entityDto.setProcessOn(new Date());
			entityDto.setProcessBy(principal.getName());
			entityDto.setAssignAt(principal.getName());
			entityDto.setStatus(GlobalConstants.STATUS);

			// String name=entityDto.getVerifierName();
//			System.out.println(name+"kkkkkkkkkkkkkk");			
//			System.out.println("processID+"+processID);
//			entityDto.setVendorPid(processID);
//			System.out.println("name++++"+name);
//			User us = serviceManager.userService.findByUsername(principal.getName());
//			User us = serviceManager.userService.findByRoleId(GlobalConstants.ROLEID_COMMERCIAL_HEAD);
//			serviceManager.sendEmailToVendorRepo.save(serviceManager.modelMapper.m)
//			System.out.println("hello");
			// int randInt = rand.nextInt();m
			// entityDto.setFlag(randInt);
//			String introducerEmail = us.getEmailId();
			// .out.println("hhhh-----");
			Integer roleId = (Integer) request.getSession().getAttribute("roleId");
			String username = (String) request.getSession().getAttribute("username");
			String role = (String) request.getSession().getAttribute("role");

			SendEmailToVendor smds = (this.serviceManager.modelMapper.map(entityDto, SendEmailToVendor.class));

//			

			serviceManager.sendEmailToVendorRepo.save(smds);

			Integer id = smds.getId();
			processID = GlobalConstants.VENDOR_PID_PREFIX + id + GlobalConstants.VENDOR_PID_SUFFIX;
			serviceManager.sendEmailToVendorRepo.vendorIdGenerate(id, processID);
			CommentHistory cmtHisObj = new CommentHistory();
			cmtHisObj.setRemark(entityDto.getComments());
			cmtHisObj.setCreatedOn(new Date());
			cmtHisObj.setCreatedBy(principal.getName());
			cmtHisObj.setRoleId(roleId);
			cmtHisObj.setRoleName(role);
			cmtHisObj.setVendorPid(processID);
			serviceManager.commentHistoryRepo.save(cmtHisObj);

			CommentHistory getCommentId = serviceManager.commentHistoryRepo.findByVendorPid(processID);
			Integer commentId = getCommentId.getId();
			serviceManager.sendEmailToVendorRepo.vendorCommentId(id, commentId);

//			List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");

			/*
			 * String maillink = registrationLink + "?vendorEmail=" +
			 * Base64.getEncoder().encodeToString(entityDto.getVendorEmail().getBytes()) +
			 * "&vendorType=" +
			 * Base64.getEncoder().encodeToString(entityDto.getVendorType().getBytes()) +
			 * "&resgion=" +
			 * Base64.getEncoder().encodeToString(entityDto.getRegion().getBytes()) +
			 * "&creditTerms=" +
			 * Base64.getEncoder().encodeToString(entityDto.getCreditTerms().getBytes()) +
			 * "&processBy=" +
			 * Base64.getEncoder().encodeToString(entityDto.getProcessBy().getBytes()) +
			 * "&processByEmailId=" +
			 * Base64.getEncoder().encodeToString(entityDto.getThirdPartyVerification().
			 * getBytes()) + "&thirdPartyVerification" +
			 * Base64.getEncoder().encodeToString(entityDto.getEhsVerification().getBytes())
			 * + "&ehsVerification=" +
			 * Base64.getEncoder().encodeToString(entityDto.getComments().getBytes()) +
			 * "&comments=" + Base64.getEncoder().encodeToString(introducerEmail.getBytes())
			 * + "&flag=" + randInt; String newmailLink = maillink.replace(" ", "%20");
			 */

			// emailBody = emailBody.replace("#OndordingDate#", strDate);

			/*
			 * String thirdPartyVerificationRequired =
			 * entityDto.getThirdPartyVerification(); String ehsVerificationRequired =
			 * entityDto.getEhsVerification(); if (thirdPartyVerificationRequired ||
			 * ehsVerificationRequired) { String verifierName = entityDto.getVerifierName();
			 * // Use the verifier name for further processing }
			 */

			/*
			 * String approvalStatus = "Rejected"; String approvalComments = ""; // Default
			 * to empty string for rejection // Check if the commercial head approves the
			 * request if (commercialHeadApprovesRequest(entityDto)) { approvalStatus =
			 * "Approved"; approvalComments = entityDto.getCommercialHeadComments();
			 */

//		            new Thread(new Runnable() {
//				@Override
//				public void run() {
//					try {
//						if (!emailList.isEmpty()) {
//							
//							List<MailContent> mailType = serviceManager.mailContentRepo.findByType("Commercial Head Email");
//							List<String> userStatusList = new ArrayList<>();
//
//							userStatusList.add(GlobalConstants.ACTIVE_STATUS);
//							userStatusList.add(GlobalConstants.CHANGE_PASSWORD_STATUS);
//							
//							List<User> usersList=serviceManager.userRepository.getUsersByRole(GlobalConstants.ROLEID_COMMERCIAL_HEAD, userStatusList);
//						//	List<String >emailId = usersList.stream().map(User::getEmailId).collect(Collectors.toList());
//
//							if (!usersList.isEmpty() ) {
//								List<String> emailId = usersList.stream()
//							            .map(User::getEmailId)
//							            .filter(email -> email != null && !email.isEmpty())
//							            .collect(Collectors.toList());
//								MailContent mailContent = mailType.get(0);
//								emailBody = mailContent.getEmailBody();
//								String comaSeparatedEmails = String.join(",", emailId);
//								for (int i = 0; i < emailList.size(); i++) {
//									
//									CommanFunction.sendEmail(emailList.get(i), comaSeparatedEmails, "","",
//											mailContent.getSubject(),emailBody);
//								}
//							} 

//							 SendEmailToVendor sendEmailToVendor = serviceManager.sendEmailToVendorRepo.findByVendorPid(processID);
//		                        if (sendEmailToVendor != null) {
//		                            CommentHistory comments = sendEmailToVendor.getCommentHistory();
//		                            if (comments != null) {
//		                                String remark = comments.getRemark();
//
//		                                comments.setCreatedBy(principal.getName());
//		                                comments.setCreatedOn(new Date());
//		                                commentsRepo.save(comments);
//							
			/*
			 * Date date = new Date(); DateFormat dateFormat = new
			 * SimpleDateFormat(GlobalConstants.DATE_FORMATTER); String strDate =
			 * dateFormat.format(date);
			 */
//							emailBody = emailBody.replace("#URL_VENDOR_ONBOARD#", newmailLink);

//						}
//					} catch (Exception e) {
//					logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
//					}
//					Thread.currentThread().interrupt();
//				}
//			}).start();

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllSentEmail" })
	public String getAllSentEmail(Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			List<Object[]> emailList = serviceManager.sendEmailToVendorRepo.findByProcessBy(principal.getName());

			/*
			 * List<SendEmailToVendor> collect =
			 * emailList.stream().sorted(Comparator.comparingInt(SendEmailToVendor::getId).
			 * reversed()).collect(Collectors.toList());
			 */
			data.setData(emailList);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@GetMapping({ "/getActiveCommercialHeadUser" })
	public String getActiveCommercialHeadUser(Principal principal) {
		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);
		System.out.println("userName " + userName);
		;
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			Optional<User> users = serviceManager.userRepository.findByUsernameAndStatus(userName,
					GlobalConstants.ACTIVE_STATUS);
			UserDTO userObj = new UserDTO();
			if (users.isPresent()) {
				userObj.setCommercialHead(users.get().getCommercialHead());
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setMsg(GlobalConstants.DATA_NOT_FOUND);
			}
			data.setData(userObj);
			/*
			 * List<UserDTO> collect = users.stream().map(user ->
			 * serviceManager.modelMapper.map(user, UserDTO.class))
			 * .collect(Collectors.toList());
			 */

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

}
