package com.main.controller;

import java.io.File;
import java.io.FileOutputStream;

import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.dozer.DozerBeanMapper;
import org.dozer.Mapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.bean.InvoiceQueryDto;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.Document;
import com.main.db.bpaas.entity.EmailConfiguration;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.InvoiceLineItem;
import com.main.db.bpaas.entity.PoInvoiceDetails;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.TripDetails;
import com.main.email.CommEmailFunction;
import com.main.serviceManager.ServiceManager;

@RequestMapping("/invoiceController")
@RestController
public class InvoiceController {

	@Value("${filepath}")
	private String filepath;

	@Autowired
	private ServiceManager serviceManager;
	
	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(MasterController.class);

	@RequestMapping({ "/getAllInvoice" })
	@CrossOrigin("*")
	public String getAllInvoice(Principal principal, HttpServletRequest request) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String vendorCode = principal.getName();
		String rolename = (String) request.getSession().getAttribute("role");
		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
				List<InvoiceGenerationEntity> pandingInvoice = serviceManager.invoiceGenerationEntityRepo
						.getAllInvoice(vendorCode);
				data.setData(pandingInvoice);
			} else {
				List<InvoiceGenerationEntity> pandingInvoice = serviceManager.invoiceGenerationEntityRepo
						.getAllNetworkInvoice();
				data.setData(pandingInvoice);
			}

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllPendingInvoice" })
	@CrossOrigin("*")
	public String getAllPendingInvoice(Principal principal, HttpServletRequest request) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<InvoiceGenerationEntity> pandingInvoice = serviceManager.invoiceGenerationEntityRepo
					.getAllProcessedInvoice(vendorCode);

			data.setData(pandingInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllApproveInvoice" })
	@CrossOrigin("*")
	public String getAllApproveInvoice(Principal principal, HttpServletRequest request) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<InvoiceGenerationEntity> pandingInvoice = serviceManager.invoiceGenerationEntityRepo
					.getAllApproveInvoice(vendorCode);

			data.setData(pandingInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllQueryInvoiceVendor" })
	@CrossOrigin("*")
	public String getAllQueryInvoiceVendor(Principal principal, HttpServletRequest request) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		String rolename = (String) request.getSession().getAttribute("role");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
				List<InvoiceGenerationEntity> queryInvoice = serviceManager.invoiceGenerationEntityRepo
						.getAllQueryInvoiceVendor(vendorCode);

				data.setData(queryInvoice);
			} else {
				List<InvoiceGenerationEntity> queryInvoice = serviceManager.invoiceGenerationEntityRepo
						.getAllQueryInvoiceVendor();
				data.setData(queryInvoice);
			}
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllRejectInvoice" })
	@CrossOrigin("*")
	public String getAllRejectInvoice(Principal principal, HttpServletRequest request,
			@RequestBody List<InvoiceGenerationEntity> invoiceDetails) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String vendorCode = principal.getName();
		try {
			List<InvoiceGenerationEntity> pandingInvoice = serviceManager.invoiceGenerationEntityRepo
					.getAllRejectInvoice(vendorCode);

			data.setData(pandingInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllInvoiceToBilling" })
	@CrossOrigin("*")
	public String getMonthallyInvoice(Principal principal, HttpServletRequest request) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String vendorCode = principal.getName();
		try {
			List<InvoiceGenerationEntity> pandingInvoice = serviceManager.invoiceGenerationEntityRepo
					.getAllRejectInvoice(vendorCode);

			data.setData(pandingInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getLineItemDetails" })
	@CrossOrigin("*")
	public String getLineItemDetails(HttpServletRequest request, @RequestBody TripDetails obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String tripID = obj.getTripID();
		logger.info(tripID);
		try {

			tripID = tripID.replaceAll(",", " ");

			logger.info(tripID + "--------");

			String[] split = tripID.split(" ");

			List<Object> listofTrips = new ArrayList<>();

			for (String str : split) {
				logger.info(str);
				TripDetails findByTripID = serviceManager.tripDetailsRepo.findByTripID(str);
				listofTrips.add(findByTripID);
				logger.info("Trip Details :" + findByTripID);
			}
			listofTrips.forEach(m -> logger.info("----" + m + "-----"));
			data.setData(listofTrips);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping("/saveInvoice")
	public String saveInvoice(@RequestBody InvoiceGenerationEntity obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			String filePath = filepath + File.separator + obj.getEcomInvoiceNumber();
			String fullFilePathWithName = "";

			if (null != obj.getInvoiceFileName()) {

				File file1 = new File(filePath);

				if (!file1.exists()) {
					file1.mkdirs();
				}
				fullFilePathWithName = filePath + File.separator + "Invoice-" + obj.getInvoiceFileName();

				Document doc = new Document();
				doc.setDocName(obj.getInvoiceFileName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus("1");
				doc.setType("Invoice");
				doc.setForeignKey(obj.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = obj.getInvoiceFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);

				} catch (Exception e) {
					logger.error("error : "+e);
				}
			}

			if (null != obj.getDocumentFileOneName()) {

				fullFilePathWithName = filePath + File.separator + "Summary Sheet-" + obj.getDocumentFileOneName();

				Document doc = new Document();
				doc.setDocName(obj.getDocumentFileOneName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus("1");
				doc.setType("Invoice");
				doc.setForeignKey(obj.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = obj.getDocumentFileOneText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);

				} catch (Exception e) {
					logger.error("error : "+e);
				}
			}

			if (null != obj.getDocumentFileTwoName()) {

				fullFilePathWithName = filePath + File.separator + "FS Calculation Sheet-"
						+ obj.getDocumentFileTwoName();

				Document doc = new Document();
				doc.setDocName(obj.getDocumentFileTwoName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus("1");
				doc.setType("Invoice");
				doc.setForeignKey(obj.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = obj.getDocumentFileTwoText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);

				} catch (Exception e) {
					logger.error("error : "+e);
				}
			}
			String ecomInvoiceNumber = obj.getEcomInvoiceNumber();

			Long idByinvocienumber = serviceManager.invoiceGenerationEntityRepo.getIdByinvocienumber(ecomInvoiceNumber);
			logger.info(""+idByinvocienumber);
			
			Date date = new Date();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");  
			String processedOn = dateFormat.format(date);

			if (null != idByinvocienumber) {
				obj.setInvoiceStatus("In-Review");
				obj.setId(idByinvocienumber);
				obj.setProcessedBy(obj.getVendorCode());
				obj.setProcessedOn(processedOn);
				obj.setAssignTo("Finance");
				logger.info(ecomInvoiceNumber);
				serviceManager.tripDetailsRepo.updateVendorTripStatusAgainsInvoiceNumber(ecomInvoiceNumber);
				obj = serviceManager.invoiceGenerationEntityRepo.save(obj);
			}

			data.setData(obj.getInvoiceNumber());
			new Thread(new Runnable() {
				@Override
				public void run() {
					try {
						List<EmailConfiguration> emailList = serviceManager.emailConfigurationRepository.findByIsActive("1");
						
						if(!emailList.isEmpty()) {
							EmailConfiguration emailConfiguration=emailList.get(0);
							
							CommEmailFunction.sendEmail("girdhar.supyal@bpaassolutions.com", "Invoice Process",
									"Invoice Process Successfully", emailConfiguration.getSmtpPort(), emailConfiguration.getUserName(), emailConfiguration.getPassword(), emailConfiguration.getServerName());
						}
						 
						
						

					} catch (Exception e) {
						logger.error("error : "+e);
					}
					Thread.currentThread().interrupt();
				}
			}).start();
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();

	}

	@RequestMapping("/updateInvoice")
	public String updateInvoice(@RequestBody InvoiceQueryDto obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			String filePath = filepath + File.separator + obj.getEcomInvoiceNumber();
			logger.info(filePath);
			String fullFilePathWithName = "";
			Date date = new Date();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");  
			String processedOn = dateFormat.format(date);

			if (null != obj.getDocumentFileOneName()) {

				File file1 = new File(filePath);

				if (!file1.exists()) {
					file1.mkdirs();
				}

				fullFilePathWithName = filePath + File.separator + "Summary Sheet-" + obj.getDocumentFileOneName();

				Document doc = new Document();
				doc.setDocName(obj.getDocumentFileOneName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus("1");
				doc.setType("Invoice");
				doc.setForeignKey(obj.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);
				logger.info(fullFilePathWithName);

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = obj.getDocumentFileOneText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
				} catch (Exception e) {
					logger.error("error : "+e);
				}
			}

			if (null != obj.getDocumentFileTwoName()) {

				fullFilePathWithName = filePath + File.separator + "FS Calculation Sheet-"
						+ obj.getDocumentFileTwoName();

				Document doc = new Document();
				doc.setDocName(obj.getDocumentFileTwoName());
				doc.setDocPath(fullFilePathWithName);
				doc.setStatus("1");
				doc.setType("Invoice");
				doc.setForeignKey(obj.getEcomInvoiceNumber());
				serviceManager.documentRepo.save(doc);

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					String b64 = obj.getDocumentFileTwoText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
				} catch (Exception e) {
					logger.error("error : "+e);
				}
			}
			String ecomInvoiceNumber = obj.getEcomInvoiceNumber();

			List<InvoiceLineItem> invoiceLineItemsList = obj.getInvoiceLineItems();
			
			

			InvoiceGenerationEntity invObj = serviceManager.invoiceGenerationEntityRepo.findByEcomInvoiceNumber(ecomInvoiceNumber);
			
			if(null!=obj) {
				
				invObj.setInvoiceLineItem(invoiceLineItemsList);
				invObj.setAssignTo(obj.getAssignTo());
				invObj.setInvoiceStatus(obj.getInvoiceStatus());
				invObj.setInvoiceAmount(obj.getInvoiceAmount());
				invObj.setTaxableAmount(obj.getTaxableAmount());
				invObj.setProcessedBy(obj.getVendorCode());
				invObj.setProcessedOn(processedOn);
				
				serviceManager.invoiceGenerationEntityRepo.save(invObj);
				//serviceManager.invoiceGenerationEntityRepo.updateInvoiceStatusAndAssingTo(obj.getAssignTo(),obj.getInvoiceStatus(),obj.getInvoiceAmount(),obj.getTaxableAmount(), idByinvocienumber);

				//InvoiceGenerationEntity invoiceEntity = new InvoiceGenerationEntity();


				QueryEntity queryEntity = new QueryEntity();
				queryEntity.setComment(obj.getRemarks());
				queryEntity.setForeignKey(Integer.valueOf(invObj.getId().toString()));
				queryEntity.setRaisedAgainQuery(obj.getInvoiceNumber());
				queryEntity.setRaisedBy(obj.getVendorCode());
				queryEntity.setRaisedOn(new Date());
				queryEntity.setReferenceid(obj.getInvoiceNumber());
				queryEntity.setType("Invoice");
				serviceManager.queryRepo.save(queryEntity);

				String invoiceNumber = obj.getEcomInvoiceNumber();
				logger.info(invoiceNumber);
				
			}
			
			
			
			
			/*
			 * InvoiceLineItem invoiceLineItem = new InvoiceLineItem();
			 * invoiceLineItemsList.size();
			 */
			
			
			// obj =
			// serviceManager.invoiceGenerationEntityRepo.getQueryInvoice(obj.getVendorCode(),
			// invoiceNumber);

			data.setData(obj);
			data.setMsg("success");

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();

	}

	@RequestMapping({ "/getSelectInvoiceDetails" })
	@CrossOrigin("*")
	public String getSelectInvoiceDetails(HttpServletRequest request, @RequestBody InvoiceGenerationEntity inviceObj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String invoiceNumber = inviceObj.getEcomInvoiceNumber();
		String rolename = (String) request.getSession().getAttribute("role");
		try {
			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE)
					|| rolename.equalsIgnoreCase(GlobalConstants.ROLE_FINANCE_HEAD)
					|| rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {
				inviceObj = serviceManager.invoiceGenerationEntityRepo.findByEcomInvoiceNumber(invoiceNumber);
				data.setData(inviceObj);
			} else {

				inviceObj = serviceManager.invoiceGenerationEntityRepo.getQueryInvoice(invoiceNumber);
				data.setData(inviceObj);

			}

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllDraftInvoice" })
	@CrossOrigin("*")
	public String getAllDraftInvoice(Principal principal, HttpServletRequest request) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<InvoiceGenerationEntity> draftInvoice = serviceManager.invoiceGenerationEntityRepo
					.getDraftInvoice(vendorCode);

			data.setData(draftInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/deleteDraftInvoice" })
	@CrossOrigin("*")
	public String deleteDraftInvoice(HttpServletRequest request, @RequestBody InvoiceGenerationEntity obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			Long id = obj.getId();
			String ecomInvoiceNumber = obj.getEcomInvoiceNumber();
			serviceManager.invoiceGenerationEntityRepo.deleteById(id);
			serviceManager.tripDetailsRepo.updatetripStatusagainsInvoiceNumber(ecomInvoiceNumber);

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/deleteLineItem" })
	@CrossOrigin("*")
	public String deleteLineItem(HttpServletRequest request, @RequestBody TripDetails obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String tripID = obj.getTripID();

			serviceManager.tripDetailsRepo.updateVendorTripStatus(tripID);

			// serviceManager.invoiceLineItemRepo.updateTrip(tripID);

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/discardDraftInvoice" })
	@CrossOrigin("*")
	public String discardDraftInvoice(HttpServletRequest request, @RequestBody InvoiceGenerationEntity obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String invoiceNumber = obj.getEcomInvoiceNumber();

			logger.info(invoiceNumber);

			serviceManager.tripDetailsRepo.discardDraftInvoice(invoiceNumber);
			logger.info(invoiceNumber);
			serviceManager.tripDetailsRepo.updateVendorTripStatusAgainsInvoice(invoiceNumber);

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllQueryInvoiceVendorPo" })
	@CrossOrigin("*")
	public String getAllQueryInvoiceVendorPo(Principal principal, HttpServletRequest request) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<PoInvoiceDetails> queryInvoice = serviceManager.poinvoiceRepo.getAllQueryInvoiceVendorPo(vendorCode);

			data.setData(queryInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/checkForExistingInvoiceNumber" })
	@CrossOrigin("*")
	public String checkForExistingInvoiceNumber(HttpServletRequest request, @RequestBody InvoiceGenerationEntity obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			String invoiceNumber = serviceManager.invoiceGenerationEntityRepo
					.checkForExistingInvoiceNumber(obj.getVendorCode(), obj.getInvoiceNumber());

			logger.info(invoiceNumber);

			if (null == invoiceNumber) {
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

	@RequestMapping(value = "/getQueryInvoice")
	@CrossOrigin("*")
	public String getQueryInvoice(@RequestBody InvoiceGenerationEntity obj, Principal principal, HttpSession session,
			HttpServletRequest request) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String vendorCode = principal.getName();

		try {
			String invoiceNumber = obj.getEcomInvoiceNumber();
			logger.info(invoiceNumber);
			obj = serviceManager.invoiceGenerationEntityRepo.getQueryInvoice(vendorCode, invoiceNumber);

			data.setData(obj);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	// deleteTripQueryInvoice

	@RequestMapping({ "/deleteTripQueryInvoice" })
	@CrossOrigin("*")
	public String deleteTripQueryInvoice(HttpServletRequest request, @RequestBody TripDetails obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String tripID = obj.getTripID();
			serviceManager.tripDetailsRepo.updateVendorTripStatus(tripID);
			serviceManager.invoiceLineItemRepo.updateTrip(tripID);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/addNewTripInQueryInvoice" })
	@CrossOrigin("*")
	public String addNewTripInQueryInvoice(HttpServletRequest request, @RequestBody TripDetails obj) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			String tripID = obj.getTripID();
			String invoiceNumber = obj.getInvoiceNumber();

			TripDetails tripDetails = serviceManager.tripDetailsRepo.findByTripID(tripID);

			if (null != tripDetails) {
				Mapper mapper = new DozerBeanMapper();

				InvoiceLineItem lineItem = mapper.map(tripDetails, InvoiceLineItem.class);
				lineItem.setId(null);
				data.setData(lineItem);
				// serviceManager.tripDetailsRepo.updateVendorTripStatusAgainsQueryInvoice(tripID,invoiceNumber);
				data.setMsg("success");
			} else {
				data.setData("data Not found");
				data.setMsg("Failed");
			}

		} catch (Exception e) {
			data.setMsg("error");
			logger.error("error : "+e);
		}

		return gson.toJson(data).toString();
	}

}
