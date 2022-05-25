package com.main.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.main.db.bpaas.entity.PoDetails;
import com.main.db.bpaas.entity.User;
import com.main.serviceManager.ServiceManager;

@Controller
public class PoUiController {

	@Value("${maxFileSize}")
	public String maxFileSize;

	@Value("${fileSize}")
	public String fileSize;

	@Value("${dataLimit}")
	public String dataLimit;

	@Autowired
	private ServiceManager serviceManager;

	@GetMapping("/dashboard_Po")
	public String dashboard_Po(Model model, Principal principal, HttpServletRequest request) {

		String bpCode = serviceManager.userRepository.getBpCode(principal.getName());
		User us = serviceManager.userService.findByUsername(principal.getName());
		if (bpCode == "" || bpCode == null) {
			bpCode = "";
		}

		String vendorType = serviceManager.supDetailsRepo.findVendorType(bpCode);
		if (vendorType == "" || vendorType == null) {
			vendorType = "vendor";
		}
		System.out.println("vendorType in dashboard : " + vendorType);

		String[] strArray = null;

		strArray = vendorType.split(",");

		for (int i = 0; i < strArray.length; i++) {

		}

		for (int i = 0; i < strArray.length; i++) {

			if (strArray[i].equalsIgnoreCase("Network") && strArray[i + 1].equalsIgnoreCase("Fixed Asset")) {
				System.out.println("vendor type : " + strArray[i] + " and " + strArray[i + 1]);

				String rolename = (String) request.getSession().getAttribute("role");
				String vendorCode = (String) request.getSession().getAttribute("userName");

				// po Details
				int totalAllPoCount = serviceManager.podetailsRepo.getAllPoCount(vendorCode);
				model.addAttribute("totalAllPoCount", totalAllPoCount);

				int totalProcessPoCount = serviceManager.podetailsRepo.getAllProcessPoCount(vendorCode);
				model.addAttribute("totalProcessPoCount", totalProcessPoCount);
				System.out.println("totalProcessPoCount : " + totalProcessPoCount);
				int totalUnprocessPOCount = serviceManager.podetailsRepo.getAllUnProcessPoCount(vendorCode);
				model.addAttribute("totalUnprocessPOCount", totalUnprocessPOCount);
				// Query
				int totalQueryCount = serviceManager.podetailsRepo.getAllQueryCount(vendorCode);
				model.addAttribute("totalQueryCount", totalQueryCount);

				// Query
				int totalInvoiceCount = serviceManager.poinvoiceRepo.getAllInvoiceCount(vendorCode);
				model.addAttribute("totalInvoiceCount", totalInvoiceCount);

				int allPOcount = serviceManager.poinvoiceRepo.getAllPOcount(vendorCode);
				model.addAttribute("allPOcount", allPOcount);

				int totalDraftInvoiceCount = serviceManager.poinvoiceRepo.getTotalDraftInvoiceCount(vendorCode);
				model.addAttribute("totalDraftInvoiceCount", totalDraftInvoiceCount);

				model.addAttribute("userStatus", us.getStatus());
				model.addAttribute("dataLimit", dataLimit);

				System.out.println("end of dashboard_Po");

				if (rolename.equalsIgnoreCase("Vendor")) {

					return "dashboard_Po";

				}
			}
		}
		return "";
	}

	@GetMapping("/allPO")
	public String allPo(Model model, Principal principal, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");
		model.addAttribute("dataLimit", dataLimit);

		if (rolename.equalsIgnoreCase("Vendor")) {

			return "allPO";

		}
		return "";
	}

	@GetMapping("/processPO")
	public String processPO(Model model, Principal principal, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");
		model.addAttribute("dataLimit", dataLimit);

		if (rolename.equalsIgnoreCase("Vendor")) {

			return "processPO";

		}
		return "";
	}

	@GetMapping("/unprocessPO")
	public String unprocessPO(Model model, Principal principal, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");
		model.addAttribute("dataLimit", dataLimit);

		if (rolename.equalsIgnoreCase("Vendor")) {

			return "unprocessPO";

		}
		return "";
	}

	@GetMapping("/poInvoiceDetails")
	public String poInvoiceDetails(Model model, Principal principal, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");
		model.addAttribute("dataLimit", dataLimit);

		if (rolename.equalsIgnoreCase("Vendor")) {

			return "poInvoiceDetails";

		}
		return "";
	}

	@GetMapping("/QueryPo")
	public String QueryPo(Model model, Principal principal, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");
		model.addAttribute("dataLimit", dataLimit);

		if (rolename.equalsIgnoreCase("Vendor")) {

			return "QueryPo";

		}
		return "";
	}

	@GetMapping("/invoiceViewPo")
	public String invoiceViewPo(Model model, HttpServletRequest request, Principal principal) {

		String obj = request.getParameter("ob");
		String invoiceNumber = "";
		String status = "";
		String[] arrSplit = obj.split(",");
		for (int i = 0; i < arrSplit.length; i++) {
			if (i == 0) {
				invoiceNumber = arrSplit[i];
			}
			if (i == 1) {
				status = arrSplit[i];
			}
		}

		System.out.println("invoiceNo" + invoiceNumber);
		model.addAttribute("invoiceNo", invoiceNumber);
		System.out.println("status" + status);
		model.addAttribute("status", status);
		return "invoiceViewPo";
	}

	@GetMapping("/invoiceQueryPo")
	public String invoiceQueryPo(Model model, HttpServletRequest request, Principal principal) {

		String obj = request.getParameter("ob");
		String invoiceNumber = "";
		String status = "";
		String[] arrSplit = obj.split(",");
		for (int i = 0; i < arrSplit.length; i++) {
			if (i == 0) {
				invoiceNumber = arrSplit[i];
			}
			if (i == 1) {
				status = arrSplit[i];
			}
		}

		System.out.println("invoiceNo" + invoiceNumber);
		model.addAttribute("invoiceNo", invoiceNumber);
		System.out.println("status" + status);
		model.addAttribute("status", status);
		return "invoiceViewPo";
	}

	@GetMapping("/PoView")
	public String PoView(Model model, HttpServletRequest request, Principal principal) {

		String id = request.getParameter("id");
		String arr[] = id.split(",");
		String poNumber = "";
		String viewPage = "";
		for (int i = 0; i < arr.length; i++) {
			if (arr.length == 1) {
				poNumber = arr[0];
				break;
			} else {
				poNumber = arr[0];
				viewPage = arr[1];
				break;
			}
		}

		System.out.println("poNumber" + poNumber);
		model.addAttribute("poNumber", poNumber);

		System.out.println("viewPage" + viewPage);
		model.addAttribute("viewPage", viewPage);
		return "PoView";
	}

	@GetMapping("/poInvoiceGenerate")
	public String poInvoiceGenerate(Model model, HttpServletRequest request, Principal principal) {

		String userNameIs = "ECOM-";

		String vendorCode = (String) request.getSession().getAttribute("userName");

		int totalInvoiceCount = serviceManager.poinvoiceRepo.getAllInvoiceCountForInvoiceNo(vendorCode);
		String invoiceNumber = userNameIs + String.format("%08d", totalInvoiceCount + 1); // Filling with zeroes

		List<String> exitingInvoiceNo = serviceManager.poinvoiceRepo.getExitingInvoiceNo();

		String[] arr = new String[exitingInvoiceNo.size()];
		for (int i = 0; i < exitingInvoiceNo.size(); i++) {
			arr[i] = exitingInvoiceNo.get(i);

			if (invoiceNumber.equalsIgnoreCase(arr[i])) {
				invoiceNumber = userNameIs + String.format("%08d", totalInvoiceCount + 3);
			}

		}

		model.addAttribute("invoiceNumber", invoiceNumber);
		request.getSession().setAttribute("invoiceNumber", invoiceNumber);

		String PoNumber = request.getParameter("id");
		model.addAttribute("PoNumber", PoNumber);

		PoDetails findByPoNumber = null;
		findByPoNumber = serviceManager.podetailsRepo.findByPoNo(PoNumber);
		model.addAttribute("curentDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));

		if (null != findByPoNumber.getPoNo()) {
			// findByPoNumber.setStatus("Draft-Invoicing");
			// findByPoNumber.setInvoiceNumber(invoiceNumber);
			// podetailsRepo.save(findByPoNumber);
		}

		System.out.println("Eom invoiceNumber : " + invoiceNumber);

		return "poInvoiceGenerate";
	}

	@GetMapping("/draftPO")
	public String draftPO(Model model, HttpServletRequest request, Principal principal) {

		String PoNumber = request.getParameter("id");
		model.addAttribute("dataLimit", dataLimit);
		model.addAttribute("PoNumber", PoNumber);
		return "draftPO";
	}

	@GetMapping("/draftPoInvoiceGenerate")
	public String draftPoInvoiceGenerate(Model model, HttpServletRequest request, Principal principal) {

		String PoNumber = request.getParameter("id");
		model.addAttribute("PoNumber", PoNumber);
		model.addAttribute("invoiceNumber", PoNumber);
		return "draftPoInvoiceGenerate";
	}

}
