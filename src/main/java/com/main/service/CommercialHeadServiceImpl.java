package com.main.service;

import java.io.File;
import java.io.FileOutputStream;
import java.security.Principal;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.main.bean.DataContainer;
import com.main.commonclasses.CommanFunction;
import com.main.commonclasses.GlobalConstants;
import com.main.controller.VerifierController;
import com.main.db.bpaas.entity.AccountDetails;
import com.main.db.bpaas.entity.AddressDetails;
import com.main.db.bpaas.entity.CommentHistory;
import com.main.db.bpaas.entity.Document;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.MailContent;
import com.main.db.bpaas.entity.SendEmailToVendor;
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.entity.User;
import com.main.db.bpaas.entity.Verifier;
import com.main.payloads.CommentHistoryDTO;
import com.main.payloads.SendEmailToVendorDTO;
import com.main.payloads.SupDetailsDTO;
import com.main.payloads.SupplierFileUploadDTO;
import com.main.payloads.VerifierDTO;
import com.main.servicemanager.ServiceManager;

@Service
public class CommercialHeadServiceImpl implements CommercialHeadService {
	String emailBody = "";
	@Autowired
	private ServiceManager serviceManager;

	@Value("${registrationLink}")
	private String registrationLink;

	@Value("${logFilePath}")
	private String logFilePath;

	@Value("${filepaths}")
	public String filepaths;

	String processID = "";

	@Autowired
	private ServiceManager service;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(CommercialHeadServiceImpl.class);

	@Override
	public DataContainer getDetailFromCommercialTeam(Principal principal) {
		DataContainer data = new DataContainer();
		String username = principal.getName();

		List<SendEmailToVendor> sendEmailToVendor = serviceManager.sendEmailToVendorRepo
				.findByCommercialHeadAndStatusOrderByIdDesc(username, GlobalConstants.STATUS);

		if (sendEmailToVendor != null) {
			List<SendEmailToVendorDTO> sendEmailToVendorDTOList = new ArrayList<>();

			for (SendEmailToVendor emailToVendor : sendEmailToVendor) {
				SendEmailToVendorDTO sendEmailToVendorDTO = new SendEmailToVendorDTO();
				sendEmailToVendorDTO.setId(emailToVendor.getId());
				sendEmailToVendorDTO.setVendorEmail(emailToVendor.getVendorEmail());
				sendEmailToVendorDTO.setVerifierName(emailToVendor.getVerifierName());
				sendEmailToVendorDTO.setVendorType(emailToVendor.getVendorType());
				sendEmailToVendorDTO.setRegion(emailToVendor.getRegion());
				sendEmailToVendorDTO.setCreditTerms(emailToVendor.getCreditTerms());
				sendEmailToVendorDTO.setThirdPartyVerification(emailToVendor.getThirdPartyVerification());
				sendEmailToVendorDTO.setEhsVerification(emailToVendor.getEhsVerification());
				sendEmailToVendorDTO.setComments(emailToVendor.getComments());
				sendEmailToVendorDTO.setProcessBy(emailToVendor.getProcessBy());
				sendEmailToVendorDTO.setProcessOn(emailToVendor.getProcessOn());
				sendEmailToVendorDTO.setVendorPid(emailToVendor.getVendorPid());

				sendEmailToVendorDTOList.add(sendEmailToVendorDTO);
			}

			data.setData(sendEmailToVendorDTOList);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} else {
			data.setMsg(GlobalConstants.DATA_NOT_FOUND);
		}

		return data;
	}

	/*
	 * @Override public DataContainer getDetailFromCommercialTeam() { DataContainer
	 * data = new DataContainer();
	 * 
	 * List<SendEmailToVendor> sendEmailToVendor =
	 * serviceManager.sendEmailToVendorRepo
	 * .findByStatusOrderByIdDesc(GlobalConstants.STATUS);
	 * 
	 * if (sendEmailToVendor != null) { List<SendEmailToVendorDTO>
	 * sendEmailToVendorDTOList = new ArrayList<>();
	 * 
	 * for (SendEmailToVendor emailToVendor : sendEmailToVendor) {
	 * SendEmailToVendorDTO sendEmailToVendorDTO = new SendEmailToVendorDTO();
	 * sendEmailToVendorDTO.setId(emailToVendor.getId());
	 * sendEmailToVendorDTO.setVendorEmail(emailToVendor.getVendorEmail());
	 * sendEmailToVendorDTO.setVerifierName(emailToVendor.getVerifierName());
	 * sendEmailToVendorDTO.setVendorType(emailToVendor.getVendorType());
	 * sendEmailToVendorDTO.setRegion(emailToVendor.getRegion());
	 * sendEmailToVendorDTO.setCreditTerms(emailToVendor.getCreditTerms());
	 * sendEmailToVendorDTO.setThirdPartyVerification(emailToVendor.
	 * getThirdPartyVerification());
	 * sendEmailToVendorDTO.setEhsVerification(emailToVendor.getEhsVerification());
	 * sendEmailToVendorDTO.setComments(emailToVendor.getComments());
	 * sendEmailToVendorDTO.setProcessBy(emailToVendor.getProcessBy());
	 * sendEmailToVendorDTO.setProcessOn(emailToVendor.getProcessOn());
	 * sendEmailToVendorDTO.setVendorPid(emailToVendor.getVendorPid());
	 * 
	 * sendEmailToVendorDTOList.add(sendEmailToVendorDTO); }
	 * 
	 * data.setData(sendEmailToVendorDTOList);
	 * data.setMsg(GlobalConstants.SUCCESS_MESSAGE); } else {
	 * data.setMsg(GlobalConstants.DATA_NOT_FOUND); }
	 * 
	 * return data; }
	 */

	@Override
	public DataContainer findCommercialTeamDetailsById(SendEmailToVendorDTO sendEmailToVendorDto, Principal principal,
			HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Optional<SendEmailToVendor> sendEmailToVendorobj = serviceManager.sendEmailToVendorRepo
				.findById(sendEmailToVendorDto.getId());
		if (sendEmailToVendorobj.isPresent()) {

			Integer roleId = (Integer) request.getSession().getAttribute("roleId");
			String username = (String) request.getSession().getAttribute("username");
			String role = (String) request.getSession().getAttribute("role");

			SendEmailToVendor sendEmailToVendorObj = sendEmailToVendorobj.get();
			sendEmailToVendorDto.setId(sendEmailToVendorObj.getId());
			sendEmailToVendorDto.setStatus(GlobalConstants.APPROVE_BY_COMMERCIAL_HEAD);
			// This code for link will be valid for 72 hours
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(new Date());
			calendar.add(Calendar.HOUR_OF_DAY, 72);
			Date expirationDate = calendar.getTime();

			sendEmailToVendorDto.setLinkExpirationDate(expirationDate);

//			serviceManager.sendEmailToVendorRepo.save(sendEmailToVendorObj);

			CommentHistory cmtHisObj = new CommentHistory();
			cmtHisObj.setRemark(sendEmailToVendorDto.getCommentsHead());
			cmtHisObj.setCreatedOn(new Date());
			cmtHisObj.setCreatedBy(principal.getName());
			cmtHisObj.setRoleId(roleId);
			cmtHisObj.setRoleName(role);
			cmtHisObj.setVendorPid(sendEmailToVendorDto.getVendorPid());
			serviceManager.commentHistoryRepo.save(cmtHisObj);

			Date currentDate = new Date();
			if (currentDate.after(sendEmailToVendorDto.getLinkExpirationDate())) {
				// The link is expired, handle accordingly
				data.setMsg("Link has expired");

			}

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} else {
			data.setMsg(GlobalConstants.DATA_NOT_FOUND);
		}

		try {
			final Random rand = SecureRandom.getInstanceStrong();
			sendEmailToVendorDto.setProcessOn(new Date());
			sendEmailToVendorDto.setProcessBy(principal.getName());
			User us = serviceManager.userService.findByUsername(principal.getName());
			int randInt = rand.nextInt();
			sendEmailToVendorDto.setFlag(randInt);
			String introducerEmail = us.getEmailId();
			Optional<SendEmailToVendor> byVendorPid = serviceManager.sendEmailToVendorRepo
					.getByVendorPid(sendEmailToVendorDto.getVendorPid());

			if (byVendorPid.isPresent()) {
				String verifierName = byVendorPid.get().getVerifierName();
				sendEmailToVendorDto.setVerifierName(verifierName);
			}
			
			sendEmailToVendorDto.setAssignAt(byVendorPid.get().getAssignAt());
			sendEmailToVendorDto.setCommercialHead(byVendorPid.get().getCommercialHead());
			sendEmailToVendorDto.setComm_his_id(byVendorPid.get().getComm_his_id());
			
			serviceManager.sendEmailToVendorRepo
					.save(this.serviceManager.modelMapper.map(sendEmailToVendorDto, SendEmailToVendor.class));

			List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");
			System.out.println("vendorType++++++" + sendEmailToVendorDto.getVendorType());
			System.out.println("assign to ++++++" + byVendorPid.get().getAssignAt());
			
			System.out.println("getRegion++++++" + randInt);
			System.out.println("vendorPIdddddddddddddddddd++++++" + sendEmailToVendorDto.getVendorPid());
			String maillink = registrationLink + "?vendorEmail="

					+ Base64.getEncoder().encodeToString(sendEmailToVendorDto.getVendorEmail().getBytes())
					+ "&vendorType="
					+ Base64.getEncoder().encodeToString(sendEmailToVendorDto.getVendorType().getBytes()) + "&region="
					+ Base64.getEncoder().encodeToString(sendEmailToVendorDto.getRegion().getBytes()) + "&creditTerms="
					+ Base64.getEncoder().encodeToString(sendEmailToVendorDto.getCreditTerms().getBytes())
					+ "&processBy=" + Base64.getEncoder().encodeToString(sendEmailToVendorDto.getProcessBy().getBytes())
					+ "&pid=" + Base64.getEncoder().encodeToString(sendEmailToVendorDto.getVendorPid().getBytes())
					+ "&processByEmailId=" + Base64.getEncoder().encodeToString(introducerEmail.getBytes()) + "&flag="
					+ randInt;
			String newmailLink = maillink.replace(" ", "%20");

			System.out.println("maillink++++" + maillink);

			List<MailContent> mailType = serviceManager.mailContentRepo.findByType("Vendor Onboarding Link");

			MailContent mailContent = mailType.get(0);
			emailBody = mailContent.getEmailBody();
			/*
			 * Date date = new Date(); DateFormat dateFormat = new
			 * SimpleDateFormat(GlobalConstants.DATE_FORMATTER); String strDate =
			 * dateFormat.format(date);
			 */
			emailBody = emailBody.replace("#URL_VENDOR_ONBOARD#", newmailLink);
			// emailBody = emailBody.replace("#OndordingDate#", strDate);

			new Thread(new Runnable() {
				@Override
				public void run() {
					try {
						if (!emailList.isEmpty()) {
							for (int i = 0; i < emailList.size(); i++) {
								CommanFunction.sendEmail(emailList.get(i), sendEmailToVendorDto.getVendorEmail(),
										introducerEmail, "", "Ecom | Vendor Onboarding Link", "" + emailBody);
							}
						}
					} catch (Exception e) {
						// logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
					}
					Thread.currentThread().interrupt();
				}
			}).start();

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			e.printStackTrace();

		}

		return data;
	}

	@Override
	public DataContainer rejectCommercialTeamDetails(SendEmailToVendorDTO sendEmailToVendorDto,
			HttpServletRequest request, Principal principal) {
		DataContainer data = new DataContainer();

		Optional<SendEmailToVendor> sendEmailToVendorobj = serviceManager.sendEmailToVendorRepo
				.findById(sendEmailToVendorDto.getId());

		if (sendEmailToVendorobj.isPresent()) {

			Integer roleId = (Integer) request.getSession().getAttribute("roleId");
			String username = (String) request.getSession().getAttribute("username");
			String role = (String) request.getSession().getAttribute("role");

			SendEmailToVendor sendEmailToVendorObj = sendEmailToVendorobj.get();

			sendEmailToVendorObj.setCommentsHead(sendEmailToVendorDto.getCommentsHead());
			sendEmailToVendorObj.setStatus(GlobalConstants.REJECT);
			serviceManager.sendEmailToVendorRepo.save(sendEmailToVendorObj);

			CommentHistory cmtHisObj = new CommentHistory();
			cmtHisObj.setRemark(sendEmailToVendorDto.getCommentsHead());
			cmtHisObj.setCreatedOn(new Date());
			cmtHisObj.setCreatedBy(principal.getName());
			cmtHisObj.setRoleId(roleId);
			cmtHisObj.setRoleName(role);
			cmtHisObj.setVendorPid(sendEmailToVendorObj.getVendorPid());
			serviceManager.commentHistoryRepo.save(cmtHisObj);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} else {
			data.setMsg(GlobalConstants.DATA_NOT_FOUND);
		}

		return data;
	}

	@Override
	public DataContainer rasieQueryCommercialTeam(SendEmailToVendorDTO sendEmailToVendorDto, Principal principal,
			HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Integer roleId = (Integer) request.getSession().getAttribute("roleId");
		String username = (String) request.getSession().getAttribute("username");
		String role = (String) request.getSession().getAttribute("role");

		Optional<SendEmailToVendor> sendEmailToVendorobj = serviceManager.sendEmailToVendorRepo
				.getByVendorPid(sendEmailToVendorDto.getVendorPid());
		SendEmailToVendor sendEmailToVendorObj = null;
		if (sendEmailToVendorobj.isPresent()) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(new Date());
			// calendar.add(Calendar.HOUR_OF_DAY, 72);
			// Date expirationDate = calendar.getTime();

			sendEmailToVendorObj = sendEmailToVendorobj.get();

			CommentHistory cmtHisObj = new CommentHistory();
			cmtHisObj.setRemark(sendEmailToVendorDto.getComments());
			cmtHisObj.setCreatedOn(new Date());
			cmtHisObj.setCreatedBy(principal.getName());
			cmtHisObj.setRoleId(roleId);
			cmtHisObj.setRoleName(role);
			cmtHisObj.setVendorPid(sendEmailToVendorDto.getVendorPid());
			serviceManager.commentHistoryRepo.save(cmtHisObj);

			sendEmailToVendorObj.setStatus(GlobalConstants.RAISE_QUERY);
			// sendEmailToVendorObj.setLinkExpirationDate(expirationDate);
			serviceManager.sendEmailToVendorRepo.save(sendEmailToVendorObj);

			Optional<SupDetails> supDetails = serviceManager.supDetailsRepo.findByPidAndVenStatus(
					sendEmailToVendorDto.getVendorPid(), GlobalConstants.PENDING_FOR_COMMERCIAL_TEAM_STATUS);
			if (supDetails.isPresent()) {
				SupDetails updateStatus = supDetails.get();
				updateStatus.setVenStatus(GlobalConstants.RAISE_QUERY);
				serviceManager.supDetailsRepo.save(updateStatus);
			}

			Date currentDate = new Date();
			/*
			 * if (currentDate.after(expirationDate)) { // The link is expired
			 * data.setMsg("Link has expired"); return data; }
			 */

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} else {
			data.setMsg(GlobalConstants.DATA_NOT_FOUND);
		}

		try {
			final Random rand = SecureRandom.getInstanceStrong();
			sendEmailToVendorDto.setProcessOn(new Date());
			sendEmailToVendorDto.setProcessBy(principal.getName());
			User us = serviceManager.userService.findByUsername(principal.getName());
			int randInt = rand.nextInt();

			Optional<SendEmailToVendor> getFlagId = serviceManager.sendEmailToVendorRepo
					.getByVendorPid(sendEmailToVendorDto.getVendorPid());
//				sendEmailToVendorDto.setFlag(randInt);
			String introducerEmail = us.getEmailId();
			SendEmailToVendor SendEmailToVendorObj = getFlagId.get();
			Integer getFlag = SendEmailToVendorObj.getFlag();

			String vendorType = SendEmailToVendorObj.getVendorType();
//				serviceManager.sendEmailToVendorRepo
//						.save(this.serviceManager.modelMapper.map(sendEmailToVendorDto, SendEmailToVendor.class));

			List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");
			System.out.println("vendorType++++++" + sendEmailToVendorDto.getVendorType());
			System.out.println("getRegion++++++" + sendEmailToVendorDto.getRegion());
			System.out.println("vendorEmail++++++" + sendEmailToVendorDto.getVendorEmail());
			System.out.println("getCreditTerms++++++" + sendEmailToVendorDto.getCreditTerms());
			System.out.println("getProcessBy++++++" + sendEmailToVendorDto.getProcessBy());
			String sendmail = getFlagId.get().getVendorEmail();
			String maillink = registrationLink + "?vendorEmail="

					+ Base64.getEncoder().encodeToString(getFlagId.get().getVendorEmail().getBytes()) + "&vendorType="
					+ Base64.getEncoder().encodeToString(sendEmailToVendorObj.getVendorType().getBytes()) + "&region="
					+ Base64.getEncoder().encodeToString(sendEmailToVendorDto.getRegion().getBytes()) + "&creditTerms="
					+ Base64.getEncoder().encodeToString(sendEmailToVendorDto.getCreditTerms().getBytes())
					+ "&processBy=" + Base64.getEncoder().encodeToString(sendEmailToVendorDto.getProcessBy().getBytes())
					+ "&pid=" + Base64.getEncoder().encodeToString(sendEmailToVendorDto.getVendorPid().getBytes())
					+ "&processByEmailId=" + Base64.getEncoder().encodeToString(introducerEmail.getBytes()) + "&flag="
					+ getFlag;

			String newmailLink = maillink.replace(" ", "%20");

			System.out.println("maillink++++" + maillink);

			List<MailContent> mailType = serviceManager.mailContentRepo.findByType("Mail On Raise Query");

			MailContent mailContent = mailType.get(0);
			emailBody = mailContent.getEmailBody();
			/*
			 * Date date = new Date(); DateFormat dateFormat = new
			 * SimpleDateFormat(GlobalConstants.DATE_FORMATTER); String strDate =
			 * dateFormat.format(date);
			 */
			emailBody = emailBody.replace("#URL_VENDOR_ONBOARD#", newmailLink);
			// emailBody = emailBody.replace("#OndordingDate#", strDate);

			new Thread(new Runnable() {
				@Override
				public void run() {
					try {
						if (!emailList.isEmpty()) {
							for (int i = 0; i < emailList.size(); i++) {
								CommanFunction.sendEmail(emailList.get(i), getFlagId.get().getVendorEmail(), sendmail,
										"", "Ecom | Raise Query Link", "" + emailBody);
							}
						}
					} catch (Exception e) {
						// logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
					}
					Thread.currentThread().interrupt();
				}
			}).start();

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			e.printStackTrace();

		}

		return data;
	}

	@Override
	public DataContainer approveByCommercialTeam(SendEmailToVendorDTO sendEmailToVendorDto, Principal principal,
			HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Integer roleId = (Integer) request.getSession().getAttribute("roleId");
		String role = (String) request.getSession().getAttribute("role");
		String username = principal.getName();

		Optional<SendEmailToVendor> sendEmailToVendorobj = serviceManager.sendEmailToVendorRepo
				.getByVendorPid(sendEmailToVendorDto.getVendorPid());

		Optional<SupDetails> supdetails = serviceManager.supDetailsRepo
				.getByVendorPid(sendEmailToVendorDto.getVendorPid());

		if (sendEmailToVendorobj.isPresent() && supdetails.isPresent()) {

			SendEmailToVendor sendEmailToVendor = sendEmailToVendorobj.get();
			String ehsVerification = sendEmailToVendor.getEhsVerification();
			String thirdPartyVerification = sendEmailToVendor.getThirdPartyVerification();

			SupDetails supDetails = supdetails.get();

			if (ehsVerification.equals(GlobalConstants.YES) && thirdPartyVerification.equals(GlobalConstants.YES)) {
				sendEmailToVendor.setStatus(GlobalConstants.PENDING_AT_VERIFIER);
			} else if (ehsVerification.equals(GlobalConstants.NO)
					&& thirdPartyVerification.equals(GlobalConstants.YES)) {
				sendEmailToVendor.setStatus(GlobalConstants.PENDING_AT_VERIFIER);
			} else if (ehsVerification.equals(GlobalConstants.YES)
					&& thirdPartyVerification.equals(GlobalConstants.NO)) {
				sendEmailToVendor.setStatus(GlobalConstants.PENDING_AT_EHS_VERIFICATION_AT_AM_DM);

			} else {
				sendEmailToVendor.setStatus(GlobalConstants.PENDING_REQUEST_STATUS);
			}

			supDetails.setVenStatus(sendEmailToVendor.getStatus());
//			sendEmailToVendor.setStatus(GlobalConstants.PENDING_AT_VERIFIER);
			serviceManager.sendEmailToVendorRepo.save(sendEmailToVendor);
			serviceManager.supDetailsRepo.save(supDetails);

			CommentHistory cmtHisObj = new CommentHistory();
			cmtHisObj.setRemark(sendEmailToVendorDto.getComments());
			cmtHisObj.setCreatedOn(new Date());
			cmtHisObj.setCreatedBy(username);
			cmtHisObj.setRoleId(roleId);
			cmtHisObj.setRoleName(role);
			cmtHisObj.setVendorPid(sendEmailToVendor.getVendorPid());
			serviceManager.commentHistoryRepo.save(cmtHisObj);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} else {
			data.setMsg(GlobalConstants.DATA_NOT_FOUND);
		}

		return data;
	}

	public DataContainer findListOfAllVendorByThirdPartyVerifier() {
		DataContainer data = new DataContainer();
		try {
			List<SendEmailToVendor> filteredVendors = serviceManager.sendEmailToVendorRepo
					.findByStatusOrderByIdDesc(GlobalConstants.PENDING_AT_VERIFIER);
			if (!filteredVendors.isEmpty()) {
				List<SendEmailToVendorDTO> vendorDtoList = filteredVendors.stream()
						.map(vendor -> serviceManager.modelMapper.map(vendor, SendEmailToVendorDTO.class))
						.collect(Collectors.toList());

				data.setData(vendorDtoList);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setMsg(GlobalConstants.DATA_NOT_FOUND);
			}
		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return data;
	}

//	@Override
//	public DataContainer getSupplierDetailsByThirdPartyVerifier() {
//		DataContainer data = new DataContainer();
//		List<SendEmailToVendor> findByStatus = serviceManager.sendEmailToVendorRepo
//				.findByStatus(GlobalConstants.PENDING_AT_VERIFIER);
//		List<String> vebdorPid = findByStatus.stream().map(SendEmailToVendor::getVendorPid)
//				.collect(Collectors.toList());
//		
//		
//		List<SupDetails> allData = serviceManager.supDetailsRepo.findByPidIn(vebdorPid);
//
//		if (!allData.isEmpty()) {
//			List<SupDetailsDTO> suplierDtoObj = allData.stream()
//					.map(dtoObj -> serviceManager.modelMapper.map(dtoObj, SupDetailsDTO.class))
//					.collect(Collectors.toList());
//
//			data.setData(suplierDtoObj);
//			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
//
//		} else {
//			data.setMsg(GlobalConstants.DATA_NOT_FOUND);
//		}
//
//		return data;
//	}

	@Override
	public DataContainer getCommentDetailsOnThirdPartyVerifierPage(String vendorPid) {
		DataContainer data = new DataContainer();
		try {

			List<CommentHistory> commentHistoryList = serviceManager.commentHistoryRepo
					.findByVendorPidOrderByIdDesc(vendorPid);
			List<CommentHistoryDTO> CommentHistoryDtoList = new ArrayList<>();
			if (!commentHistoryList.isEmpty()) {
				for (CommentHistory commentHistoryObj : commentHistoryList) {
					CommentHistoryDTO commentHistoryDTObj = serviceManager.modelMapper.map(commentHistoryObj,
							CommentHistoryDTO.class);
					CommentHistoryDtoList.add(commentHistoryDTObj);
				}
				data.setData(CommentHistoryDtoList);

				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setMsg(GlobalConstants.DATA_NOT_FOUND);
			}
		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return data;
	}

	@Override
	public DataContainer rejectByVerifier(SendEmailToVendorDTO sendEmailToVendorDto, HttpServletRequest request,
			Principal principal) {
		DataContainer data = new DataContainer();

		Integer roleId = (Integer) request.getSession().getAttribute("roleId");
		String username = principal.getName();
		String role = (String) request.getSession().getAttribute("role");

		Optional<SendEmailToVendor> sendEmailToVendorobjOpt = serviceManager.sendEmailToVendorRepo
				.findByVendorPid(sendEmailToVendorDto.getVendorPid());
		if (sendEmailToVendorobjOpt.isPresent()) {

			SendEmailToVendor sendEmailToVendorObj = sendEmailToVendorobjOpt.get();

			sendEmailToVendorObj.setComments(sendEmailToVendorDto.getComments());
			sendEmailToVendorObj.setStatus(GlobalConstants.REJECTED_BY_VERIFIER);
			serviceManager.sendEmailToVendorRepo.save(sendEmailToVendorObj);

			CommentHistory cmtHisObj = new CommentHistory();
			cmtHisObj.setRemark(sendEmailToVendorDto.getComments());
			cmtHisObj.setCreatedOn(new Date());
			cmtHisObj.setCreatedBy(username);
			cmtHisObj.setRoleId(roleId);
			cmtHisObj.setRoleName(role);
			cmtHisObj.setVendorPid(sendEmailToVendorObj.getVendorPid());
			serviceManager.commentHistoryRepo.save(cmtHisObj);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} else {
			data.setMsg(GlobalConstants.DATA_NOT_FOUND);

		}

		return data;

	}

	@Override
	public DataContainer approveByThirdPartyVerifier(SendEmailToVendorDTO sendEmailToVendorDto, Principal principal,
			HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Optional<SendEmailToVendor> sendEmailToVendorobj = serviceManager.sendEmailToVendorRepo
				.getByVendorPid(sendEmailToVendorDto.getVendorPid());

		Optional<SupDetails> supdetails = serviceManager.supDetailsRepo
				.getByVendorPid(sendEmailToVendorDto.getVendorPid());

		if (sendEmailToVendorobj.isPresent() && supdetails.isPresent()) {

			Integer roleId = (Integer) request.getSession().getAttribute("roleId");
			String username = (String) request.getSession().getAttribute("username");
			String role = (String) request.getSession().getAttribute("role");

			SendEmailToVendor sendEmailToVendor = sendEmailToVendorobj.get();
			String ehsVerification = sendEmailToVendor.getEhsVerification();

			SupDetails supDetails = supdetails.get();

			if (ehsVerification.equals("Yes")) {
				sendEmailToVendor.setStatus(GlobalConstants.PENDING_AT_EHS_VERIFICATION_AT_AM_DM);

			} else {

				sendEmailToVendor.setStatus(GlobalConstants.PENDING_REQUEST_STATUS);

			}

			supDetails.setVenStatus(sendEmailToVendor.getStatus());

			// for Document Upload

			String filePath = filepaths + sendEmailToVendorDto.getVendorPid();
			String fullFilePathWithName = "";
			File file1 = new File(filePath);
			if (!file1.exists()) {
				file1.mkdirs();
			}
			File logFilePathFolder = new File(logFilePath);
			if (!logFilePathFolder.exists()) {
				logFilePathFolder.mkdir();
			}

			List<SupplierFileUploadDTO> attachments = sendEmailToVendorDto.getUploadFile();

			if ((null != attachments) && (!attachments.isEmpty())) {

				Document document = new Document();

				String fileName = "";
				String fullfileNameAndPath = "";
				String modifiedFilePath = "";

				List<String> filenameList = new ArrayList<>();

				for (SupplierFileUploadDTO attachmentobj : attachments) {

					String[] breakFile = new String[2];
					int indexPostion = attachmentobj.getFileNameList().lastIndexOf(".");
					breakFile[0] = attachmentobj.getFileNameList().substring(0, indexPostion);
					breakFile[1] = attachmentobj.getFileNameList().substring(indexPostion + 1,
							attachmentobj.getFileNameList().length());
					String newFileName = "";
					String modifiedFileName = breakFile[0];

					modifiedFileName = modifiedFileName.replace("\\*", "");
					modifiedFileName = modifiedFileName.replace("\\?", "");
					modifiedFileName = modifiedFileName.replace("\\\\", "");
					modifiedFileName = modifiedFileName.replace("\\//", "");
					modifiedFileName = modifiedFileName.replace("\\/", "");
					modifiedFileName = modifiedFileName.replace("\\:", "");
					modifiedFileName = modifiedFileName.replace("\"", "");
					modifiedFileName = modifiedFileName.replace("\\>", "");
					modifiedFileName = modifiedFileName.replace("\\<", "");
					modifiedFileName = modifiedFileName.replace("\\|", "");
					modifiedFileName = modifiedFileName.replace(",", "");
					modifiedFileName = modifiedFileName.replace("@", "");
					modifiedFileName = modifiedFileName.replace("#", "");
					modifiedFileName = modifiedFileName.replace("\\.", "");
					modifiedFileName = modifiedFileName.replace("_", "");
					modifiedFileName = modifiedFileName.replace("\\s+", " ");

					String currentDateTime = new SimpleDateFormat("YYYY-MM-DD").format(new Date());

					newFileName = modifiedFileName + "_" + currentDateTime + "." + breakFile[1];

					filenameList.add(newFileName);

					modifiedFilePath = filePath;

					File uploadedPathFile = new File(modifiedFilePath);
					if (!uploadedPathFile.exists()) {

						uploadedPathFile.mkdirs();
					}
					fullfileNameAndPath = modifiedFilePath + "//" + newFileName;

					savFileData(fullfileNameAndPath, attachmentobj);
					logger.error(GlobalConstants.ERROR_MESSAGE + " {}");
				}

				if (!filenameList.isEmpty()) {
					String delim = ",";
					fileName = String.join(delim, filenameList);
				}

				document.setDocName(fileName);
				document.setForeignKey(sendEmailToVendorDto.getVendorPid());
				document.setStatus(GlobalConstants.ACTIVE_STATUS);
				document.setDocPath(fullfileNameAndPath);
				document.setType(GlobalConstants.SET_TYPE_REGISTRATION);

				serviceManager.documentRepo.save(document);

				logger.info("Info log message");
			}

//			// ------------------------------------------------------------------------------

			serviceManager.sendEmailToVendorRepo.save(sendEmailToVendor);
			serviceManager.supDetailsRepo.save(supDetails);

			CommentHistory cmtHisObj = new CommentHistory();
			cmtHisObj.setRemark(sendEmailToVendorDto.getComments());
			cmtHisObj.setCreatedOn(new Date());
			cmtHisObj.setCreatedBy(principal.getName());
			cmtHisObj.setRoleId(roleId);
			cmtHisObj.setRoleName(role);
			cmtHisObj.setVendorPid(sendEmailToVendor.getVendorPid());
			serviceManager.commentHistoryRepo.save(cmtHisObj);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} else {
			data.setMsg(GlobalConstants.DATA_NOT_FOUND);
		}

		return data;
	}

//	@Override
//	public DataContainer getSupplierDetailsForEhsVerification() {
//		DataContainer data = new DataContainer();
//		List<SendEmailToVendor> findByStatus = serviceManager.sendEmailToVendorRepo
//				.findByStatus(GlobalConstants.PENDING_AT_EHS_VERIFICATION);
//		List<String> vebdorPid = findByStatus.stream().map(SendEmailToVendor::getVendorPid)
//				.collect(Collectors.toList());
//		
//		
//		List<SupDetails> allData = serviceManager.supDetailsRepo.findByPidIn(vebdorPid);
//
//		if (!allData.isEmpty()) {
//			List<SupDetailsDTO> suplierDtoObj = allData.stream()
//					.map(dtoObj -> serviceManager.modelMapper.map(dtoObj, SupDetailsDTO.class))
//					.collect(Collectors.toList());
//
//			data.setData(suplierDtoObj);
//			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
//
//		} else {
//			data.setMsg(GlobalConstants.DATA_NOT_FOUND);
//		}
//
//		return data;
//	}

	public DataContainer findListOfAllVendorByEhsVerifier(HttpServletRequest request, Principal principal) {
		DataContainer data = new DataContainer();

		Integer roleId = (Integer) request.getSession().getAttribute("roleId");
		String username = (String) request.getSession().getAttribute("username");
		String role = (String) request.getSession().getAttribute("role");

		try {
			if (role.equalsIgnoreCase(GlobalConstants.ROLEID_EHS_AM_DM)) {

				List<SendEmailToVendor> vendorList = serviceManager.sendEmailToVendorRepo
						.findByStatusOrderByIdDesc((GlobalConstants.PENDING_AT_EHS_VERIFICATION_AT_AM_DM));

				if (!vendorList.isEmpty()) {
					List<SendEmailToVendorDTO> vendorDtoList = vendorList.stream()
							.map(vendor -> serviceManager.modelMapper.map(vendor, SendEmailToVendorDTO.class))
							.collect(Collectors.toList());

					data.setData(vendorDtoList);
					data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				} else {
					data.setMsg(GlobalConstants.DATA_NOT_FOUND);
				}

			} else {

				List<SendEmailToVendor> filteredVendors = serviceManager.sendEmailToVendorRepo
						.findByStatusOrderByIdDesc((GlobalConstants.PENDING_AT_SERNIOR_MANAGER));

				if (!filteredVendors.isEmpty()) {
					List<SendEmailToVendorDTO> vendorDtoList = filteredVendors.stream()
							.map(vendor -> serviceManager.modelMapper.map(vendor, SendEmailToVendorDTO.class))
							.collect(Collectors.toList());

					data.setData(vendorDtoList);
					data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				} else {
					data.setMsg(GlobalConstants.DATA_NOT_FOUND);
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE, e);
		}

		return data;
	}

	@Override
	public DataContainer rejectByEhsVerifier(SendEmailToVendorDTO sendEmailToVendorDto, HttpServletRequest request,
			Principal principal) {
		DataContainer data = new DataContainer();

		Integer roleId = (Integer) request.getSession().getAttribute("roleId");
		String username = principal.getName();
		String role = (String) request.getSession().getAttribute("role");

		Optional<SendEmailToVendor> sendEmailToVendorobjOpt = serviceManager.sendEmailToVendorRepo
				.findByVendorPid(sendEmailToVendorDto.getVendorPid());
		if (sendEmailToVendorobjOpt.isPresent()) {

			SendEmailToVendor sendEmailToVendorObj = sendEmailToVendorobjOpt.get();

			sendEmailToVendorObj.setComments(sendEmailToVendorDto.getComments());
			sendEmailToVendorObj.setStatus(GlobalConstants.REJECTED_BY_AM_DM);
			serviceManager.sendEmailToVendorRepo.save(sendEmailToVendorObj);

			CommentHistory cmtHisObj = new CommentHistory();
			cmtHisObj.setRemark(sendEmailToVendorDto.getComments());
			cmtHisObj.setCreatedOn(new Date());
			cmtHisObj.setCreatedBy(username);
			cmtHisObj.setRoleId(roleId);
			cmtHisObj.setRoleName(role);
			cmtHisObj.setVendorPid(sendEmailToVendorObj.getVendorPid());
			serviceManager.commentHistoryRepo.save(cmtHisObj);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} else {
			data.setMsg(GlobalConstants.DATA_NOT_FOUND);

		}

		return data;

	}

	@Override
	public DataContainer approveByEhsVerifier(SendEmailToVendorDTO sendEmailToVendorDto, Principal principal,
			HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Optional<SendEmailToVendor> sendEmailToVendorobj = serviceManager.sendEmailToVendorRepo
				.getByVendorPid(sendEmailToVendorDto.getVendorPid());
		if (sendEmailToVendorobj.isPresent()) {

			Integer roleId = (Integer) request.getSession().getAttribute("roleId");
			String username = (String) request.getSession().getAttribute("username");
			String role = (String) request.getSession().getAttribute("role");

			SendEmailToVendor sendEmailToVendor = sendEmailToVendorobj.get();
			sendEmailToVendor.setComments(sendEmailToVendorDto.getComments());

			sendEmailToVendor.setStatus(GlobalConstants.PENDING_AT_SERNIOR_MANAGER);

//          Upload Document

			String filePath = filepaths + sendEmailToVendorDto.getVendorPid();
			String fullFilePathWithName = "";
			File file1 = new File(filePath);
			if (!file1.exists()) {
				file1.mkdirs();
			}
			File logFilePathFolder = new File(logFilePath);
			if (!logFilePathFolder.exists()) {
				logFilePathFolder.mkdir();
			}

			List<SupplierFileUploadDTO> attachments = sendEmailToVendorDto.getUploadFile();

			if ((null != attachments) && (!attachments.isEmpty())) {

				Document document = new Document();

				String fileName = "";
				String fullfileNameAndPath = "";
				String modifiedFilePath = "";

				List<String> filenameList = new ArrayList<>();

				for (SupplierFileUploadDTO attachmentobj : attachments) {

					String[] breakFile = new String[2];
					int indexPostion = attachmentobj.getFileNameList().lastIndexOf(".");
					breakFile[0] = attachmentobj.getFileNameList().substring(0, indexPostion);
					breakFile[1] = attachmentobj.getFileNameList().substring(indexPostion + 1,
							attachmentobj.getFileNameList().length());
					String newFileName = "";
					String modifiedFileName = breakFile[0];

					modifiedFileName = modifiedFileName.replace("\\*", "");
					modifiedFileName = modifiedFileName.replace("\\?", "");
					modifiedFileName = modifiedFileName.replace("\\\\", "");
					modifiedFileName = modifiedFileName.replace("\\//", "");
					modifiedFileName = modifiedFileName.replace("\\/", "");
					modifiedFileName = modifiedFileName.replace("\\:", "");
					modifiedFileName = modifiedFileName.replace("\"", "");
					modifiedFileName = modifiedFileName.replace("\\>", "");
					modifiedFileName = modifiedFileName.replace("\\<", "");
					modifiedFileName = modifiedFileName.replace("\\|", "");
					modifiedFileName = modifiedFileName.replace(",", "");
					modifiedFileName = modifiedFileName.replace("@", "");
					modifiedFileName = modifiedFileName.replace("#", "");
					modifiedFileName = modifiedFileName.replace("\\.", "");
					modifiedFileName = modifiedFileName.replace("_", "");
					modifiedFileName = modifiedFileName.replace("\\s+", " ");

					String currentDateTime = new SimpleDateFormat("YYYY-MM-DD").format(new Date());

					newFileName = modifiedFileName + "_" + currentDateTime + "." + breakFile[1];

					filenameList.add(newFileName);

					modifiedFilePath = filePath;

					File uploadedPathFile = new File(modifiedFilePath);
					if (!uploadedPathFile.exists()) {

						uploadedPathFile.mkdirs();
					}
					fullfileNameAndPath = modifiedFilePath + "//" + newFileName;

					savFileData(fullfileNameAndPath, attachmentobj);
					logger.error(GlobalConstants.ERROR_MESSAGE + " {}");
				}

				if (!filenameList.isEmpty()) {
					String delim = ",";
					fileName = String.join(delim, filenameList);
				}

				document.setDocName(fileName);
				document.setForeignKey(sendEmailToVendorDto.getVendorPid());
				document.setStatus(GlobalConstants.ACTIVE_STATUS);
				document.setDocPath(fullfileNameAndPath);
				document.setType(GlobalConstants.SET_TYPE_REGISTRATION);

				serviceManager.documentRepo.save(document);

				logger.info("Info log message");
			}

//	________________________________________________________________________________________		

			serviceManager.sendEmailToVendorRepo.save(sendEmailToVendor);

			CommentHistory cmtHisObj = new CommentHistory();
			cmtHisObj.setRemark(sendEmailToVendorDto.getComments());
			cmtHisObj.setCreatedOn(new Date());
			cmtHisObj.setCreatedBy(principal.getName());
			cmtHisObj.setRoleId(roleId);
			cmtHisObj.setRoleName(role);
			cmtHisObj.setVendorPid(sendEmailToVendor.getVendorPid());
			serviceManager.commentHistoryRepo.save(cmtHisObj);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} else {
			data.setMsg(GlobalConstants.DATA_NOT_FOUND);
		}

		return data;
	}

	@Override
	public DataContainer approveBySeniorManagerForEhsVerification(SendEmailToVendorDTO sendEmailToVendorDto,
			Principal principal, HttpServletRequest request) {
		DataContainer data = new DataContainer();
		Optional<SendEmailToVendor> sendEmailToVendorobj = serviceManager.sendEmailToVendorRepo
				.getByVendorPid(sendEmailToVendorDto.getVendorPid());

		if (sendEmailToVendorobj.isPresent()) {

			Integer roleId = (Integer) request.getSession().getAttribute("roleId");
			String username = (String) request.getSession().getAttribute("username");
			String role = (String) request.getSession().getAttribute("role");

			SendEmailToVendor sendEmailToVendor = sendEmailToVendorobj.get();
			sendEmailToVendor.setComments(sendEmailToVendorDto.getComments());

			String vendorPid = sendEmailToVendor.getVendorPid();
			SupDetails supdetail = serviceManager.supDetailsRepo.findByPid(vendorPid);
			supdetail.setVenStatus(GlobalConstants.PENDING_REQUEST_STATUS);

			sendEmailToVendor.setStatus(GlobalConstants.PENDING_REQUEST_STATUS);

//          Upload Document

			String filePath = filepaths + sendEmailToVendorDto.getVendorPid();
			String fullFilePathWithName = "";
			File file1 = new File(filePath);
			if (!file1.exists()) {
				file1.mkdirs();
			}
			File logFilePathFolder = new File(logFilePath);
			if (!logFilePathFolder.exists()) {
				logFilePathFolder.mkdir();
			}

			List<SupplierFileUploadDTO> attachments = sendEmailToVendorDto.getUploadFile();

			if ((null != attachments) && (!attachments.isEmpty())) {

				Document document = new Document();

				String fileName = "";
				String fullfileNameAndPath = "";
				String modifiedFilePath = "";

				List<String> filenameList = new ArrayList<>();

				for (SupplierFileUploadDTO attachmentobj : attachments) {

					String[] breakFile = new String[2];
					int indexPostion = attachmentobj.getFileNameList().lastIndexOf(".");
					breakFile[0] = attachmentobj.getFileNameList().substring(0, indexPostion);
					breakFile[1] = attachmentobj.getFileNameList().substring(indexPostion + 1,
							attachmentobj.getFileNameList().length());
					String newFileName = "";
					String modifiedFileName = breakFile[0];

					modifiedFileName = modifiedFileName.replace("\\*", "");
					modifiedFileName = modifiedFileName.replace("\\?", "");
					modifiedFileName = modifiedFileName.replace("\\\\", "");
					modifiedFileName = modifiedFileName.replace("\\//", "");
					modifiedFileName = modifiedFileName.replace("\\/", "");
					modifiedFileName = modifiedFileName.replace("\\:", "");
					modifiedFileName = modifiedFileName.replace("\"", "");
					modifiedFileName = modifiedFileName.replace("\\>", "");
					modifiedFileName = modifiedFileName.replace("\\<", "");
					modifiedFileName = modifiedFileName.replace("\\|", "");
					modifiedFileName = modifiedFileName.replace(",", "");
					modifiedFileName = modifiedFileName.replace("@", "");
					modifiedFileName = modifiedFileName.replace("#", "");
					modifiedFileName = modifiedFileName.replace("\\.", "");
					modifiedFileName = modifiedFileName.replace("_", "");
					modifiedFileName = modifiedFileName.replace("\\s+", " ");

					String currentDateTime = new SimpleDateFormat("YYYY-MM-DD").format(new Date());

					newFileName = modifiedFileName + "_" + currentDateTime + "." + breakFile[1];

					filenameList.add(newFileName);

					modifiedFilePath = filePath;

					File uploadedPathFile = new File(modifiedFilePath);
					if (!uploadedPathFile.exists()) {

						uploadedPathFile.mkdirs();
					}
					fullfileNameAndPath = modifiedFilePath + "//" + newFileName;

					savFileData(fullfileNameAndPath, attachmentobj);
					logger.error(GlobalConstants.ERROR_MESSAGE + " {}");
				}

				if (!filenameList.isEmpty()) {
					String delim = ",";
					fileName = String.join(delim, filenameList);
				}

				document.setDocName(fileName);
				document.setForeignKey(sendEmailToVendorDto.getVendorPid());
				document.setStatus(GlobalConstants.ACTIVE_STATUS);
				document.setDocPath(fullfileNameAndPath);
				document.setType(GlobalConstants.SET_TYPE_REGISTRATION);

				serviceManager.documentRepo.save(document);

				logger.info("Info log message");
			}

//	________________________________________________________________________________________		

			serviceManager.sendEmailToVendorRepo.save(sendEmailToVendor);
			serviceManager.supDetailsRepo.save(supdetail);

			CommentHistory cmtHisObj = new CommentHistory();
			cmtHisObj.setRemark(sendEmailToVendorDto.getComments());
			cmtHisObj.setCreatedOn(new Date());
			cmtHisObj.setCreatedBy(principal.getName());
			cmtHisObj.setRoleId(roleId);
			cmtHisObj.setRoleName(role);
			cmtHisObj.setVendorPid(sendEmailToVendor.getVendorPid());
			serviceManager.commentHistoryRepo.save(cmtHisObj);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} else {
			data.setMsg(GlobalConstants.DATA_NOT_FOUND);
		}

		return data;
	}

	@Override
	public DataContainer rejectByEhsManager(SendEmailToVendorDTO sendEmailToVendorDto, HttpServletRequest request,
			Principal principal) {
		DataContainer data = new DataContainer();

		Integer roleId = (Integer) request.getSession().getAttribute("roleId");
		String username = principal.getName();
		String role = (String) request.getSession().getAttribute("role");

		Optional<SendEmailToVendor> sendEmailToVendorobjOpt = serviceManager.sendEmailToVendorRepo
				.findByVendorPid(sendEmailToVendorDto.getVendorPid());
		if (sendEmailToVendorobjOpt.isPresent()) {

			SendEmailToVendor sendEmailToVendorObj = sendEmailToVendorobjOpt.get();

			sendEmailToVendorObj.setComments(sendEmailToVendorDto.getComments());
			sendEmailToVendorObj.setStatus(GlobalConstants.REJECTED_BY_SENIOR_MANAGER);
			serviceManager.sendEmailToVendorRepo.save(sendEmailToVendorObj);

			CommentHistory cmtHisObj = new CommentHistory();
			cmtHisObj.setRemark(sendEmailToVendorDto.getComments());
			cmtHisObj.setCreatedOn(new Date());
			cmtHisObj.setCreatedBy(username);
			cmtHisObj.setRoleId(roleId);
			cmtHisObj.setRoleName(role);
			cmtHisObj.setVendorPid(sendEmailToVendorObj.getVendorPid());
			serviceManager.commentHistoryRepo.save(cmtHisObj);

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} else {
			data.setMsg(GlobalConstants.DATA_NOT_FOUND);

		}

		return data;

	}

	public DataContainer findListOfAllVendorByDocumentChecker(HttpServletRequest request, Principal principal) {
		DataContainer data = new DataContainer();
		try {
			List<SendEmailToVendor> filteredVendors = serviceManager.sendEmailToVendorRepo
					.findByStatusOrderByIdDesc(GlobalConstants.PENDING_REQUEST_STATUS);

			List<String> vebdorPid = filteredVendors.stream().map(SendEmailToVendor::getVendorPid)
					.collect(Collectors.toList());

			List<SupDetails> allData = serviceManager.supDetailsRepo.findByPidIn(vebdorPid);

			if (!allData.isEmpty()) {
				List<SupDetailsDTO> supplierDtoList = allData.stream()
						.map(vendor -> serviceManager.modelMapper.map(vendor, SupDetailsDTO.class))
						.collect(Collectors.toList());

				data.setData(supplierDtoList);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setMsg(GlobalConstants.DATA_NOT_FOUND);
			}
		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return data;
	}

	public void savFileData(String fullfileNameAndPath, SupplierFileUploadDTO attachmentobj) {
		try (FileOutputStream fos = new FileOutputStream(fullfileNameAndPath);) {

			String b64 = attachmentobj.getBase64List();
			byte[] decoder = Base64.getDecoder().decode(b64);
			fos.write(decoder);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Error log savFileData {}", e.toString());
		}
	}

}
