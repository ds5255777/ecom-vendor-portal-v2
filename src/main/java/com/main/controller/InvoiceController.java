package com.main.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.PoInvoiceDetails;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.repo.InvoiceGenerationEntityRepo;
import com.main.db.bpaas.repo.PoInvoiceRepo;
import com.main.db.bpaas.repo.TripDetailsRepo;

@RequestMapping("/invoiceController")
@RestController
public class InvoiceController {

//	@Autowired
//	private InvoiceDetailsRepo invoiceDetailsRepo;
	@Autowired
	PoInvoiceRepo poinvoiceRepo;

	@Autowired
	private InvoiceGenerationEntityRepo invoiceGenerationEntityRepo;

	@Autowired
	private TripDetailsRepo tripDetailsRepo;

	@RequestMapping({ "/getAllInvoice" })
	@CrossOrigin("*")
	public String getAllInvoice(Principal principal, HttpServletRequest request,
			@RequestBody List<InvoiceGenerationEntity> invoiceDetails) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		// String vendorCode = request.getSession().getAttribute("userName").toString();
		String vendorCode = principal.getName();
		try {
			List<InvoiceGenerationEntity> pandingInvoice = invoiceGenerationEntityRepo.getAllInvoice(vendorCode);

			data.setData(pandingInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllPendingInvoice" })
	@CrossOrigin("*")
	public String getAllPendingInvoice(Principal principal, HttpServletRequest request,
			@RequestBody List<InvoiceGenerationEntity> invoiceDetails) {

		DataContainer data = new DataContainer();
		// String vendorCode = request.getSession().getAttribute("userName").toString();
		String vendorCode = principal.getName();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<InvoiceGenerationEntity> pandingInvoice = invoiceGenerationEntityRepo
					.getAllProcessedInvoice(vendorCode);

			data.setData(pandingInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllApproveInvoice" })
	@CrossOrigin("*")
	public String getAllApproveInvoice(Principal principal, HttpServletRequest request,
			@RequestBody List<InvoiceGenerationEntity> invoiceDetails) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<InvoiceGenerationEntity> pandingInvoice = invoiceGenerationEntityRepo.getAllApproveInvoice(vendorCode);

			data.setData(pandingInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
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
			List<InvoiceGenerationEntity> pandingInvoice = invoiceGenerationEntityRepo.getAllRejectInvoice(vendorCode);

			data.setData(pandingInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
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
			List<InvoiceGenerationEntity> pandingInvoice = invoiceGenerationEntityRepo.getAllRejectInvoice(vendorCode);

			data.setData(pandingInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getLineItemDetails" })
	@CrossOrigin("*")
	public String getLineItemDetails(HttpServletRequest request, @RequestBody TripDetails obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String tripID = obj.getTripID();
		System.out.println(tripID);
		try {

			tripID = tripID.replaceAll(",", " ");

			System.out.println(tripID + "--------");

			String[] split = tripID.split(" ");

			List<Object> listofTrips = new ArrayList<>();

			for (String str : split) {
				System.out.println(str);
				TripDetails findByTripID = tripDetailsRepo.findByTripID(str);
				listofTrips.add(findByTripID);
				System.out.println("Trip Details :" + findByTripID);
			}
			listofTrips.forEach(m -> System.out.println("----" + m + "-----"));
			data.setData(listofTrips);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping("/saveInvoice")
	public String saveInvoice(@RequestBody InvoiceGenerationEntity obj) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

		try {
			String filePath = "C:/1.BPAAS/Invoice/" + obj.getInvoiceNumber();
			String fullFilePathWithName = "";

			System.out.println(filePath);

			System.out.println("getCICFileName : " + obj.getInvoiceFileName());

			if (null != obj.getInvoiceFileName()) {

				File file1 = new File(filePath);

				if (!file1.exists()) {
					file1.mkdirs();
				}
				// Creating the directory
//				boolean bool = 
//				System.out.println("vdsvsv " + bool);
				fullFilePathWithName = filePath + "/" + "Invoice-" + obj.getInvoiceFileName();
//				File file = new File(filePath);
				System.out.println(fullFilePathWithName);

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
					String b64 = obj.getInvoiceFileText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			System.out.println("Pan File Name : " + obj.getDocumentFileOneName());

			if (null != obj.getDocumentFileOneName()) {

				fullFilePathWithName = filePath + "/" + "Document One-" + obj.getDocumentFileOneName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
					String b64 = obj.getDocumentFileOneText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			System.out.println("Pan File Name : " + obj.getDocumentFileTwoName());

			if (null != obj.getDocumentFileTwoName()) {

				fullFilePathWithName = filePath + "/" + "Document Two-" + obj.getDocumentFileTwoName();

				try (FileOutputStream fos = new FileOutputStream(fullFilePathWithName);) {
					// To be short I use a corrupted PDF string, so make sure to use a valid one if
					// you want to preview the PDF file
					String b64 = obj.getDocumentFileTwoText();
					byte[] decoder = Base64.getDecoder().decode(b64);

					fos.write(decoder);
					System.out.println("File Saved");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			String ecomInvoiceNumber = obj.getEcomInvoiceNumber();

			Long idByinvocienumber = invoiceGenerationEntityRepo.getIdByinvocienumber(ecomInvoiceNumber);
			System.out.println(idByinvocienumber);

			if (null != idByinvocienumber) {
				obj.setInvoiceStatus("Processed");
				obj.setId(idByinvocienumber);
				System.out.println(ecomInvoiceNumber);
				tripDetailsRepo.updateVendorTripStatusAgainsInvoiceNumber(ecomInvoiceNumber);
				obj = invoiceGenerationEntityRepo.save(obj);
			}

			data.setData(obj);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			// data.setData(e.toString());
			e.printStackTrace();
		}

		return gson.toJson(data).toString();

	}

	@RequestMapping({ "/getSelectInvoiceDetails" })
	@CrossOrigin("*")
	public String getSelectInvoiceDetails(HttpServletRequest request, @RequestBody InvoiceGenerationEntity inviceObj) {

		DataContainer data = new DataContainer();
		System.out.println("trip id : " + inviceObj.getInvoiceNumber());

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			inviceObj = invoiceGenerationEntityRepo.findByInvoiceNumber(inviceObj.getInvoiceNumber());
			inviceObj.getInvoiceLineItem().forEach(t -> System.out.println(t.getActualKM()));
			data.setData(inviceObj);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

	@RequestMapping({ "/getAllDraftInvoice" })
	@CrossOrigin("*")
	public String getAllDraftInvoice(Principal principal, HttpServletRequest request,
			@RequestBody List<InvoiceGenerationEntity> invoiceList) {

		DataContainer data = new DataContainer();
		String vendorCode = principal.getName();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			invoiceList = invoiceGenerationEntityRepo.getDraftInvoice(vendorCode);

			data.setData(invoiceList);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
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
			invoiceGenerationEntityRepo.deleteById(id);
			tripDetailsRepo.updatetripStatusagainsInvoiceNumber(ecomInvoiceNumber);

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
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

			tripDetailsRepo.updateVendorTripStatus(tripID);

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
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

			System.out.println(invoiceNumber);

			tripDetailsRepo.discardDraftInvoice(invoiceNumber);

			tripDetailsRepo.updateVendorTripStatusAgainsInvoice(invoiceNumber);

			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
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
			List<PoInvoiceDetails> queryInvoice = poinvoiceRepo.getAllQueryInvoiceVendorPo(vendorCode);

			data.setData(queryInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
			}

	
	

}
