package com.main.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.AccountDetails;
import com.main.db.bpaas.entity.InvoiceNumber;
import com.main.db.bpaas.entity.PoDetails;
import com.main.db.bpaas.entity.PoLineDetails;
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.entity.User;
import com.main.servicemanager.ServiceManager;

@Controller
public class PoUiController {

	@Value("${maxFileSize}")
	private String maxFileSize;

	@Value("${fileSize}")
	private String fileSize;

	@Value("${dataLimit}")
	private String dataLimit;

	@Autowired
	private ServiceManager serviceManager;

	@GetMapping("/dashboardPo")
	public String dashboardPo(Model model, Principal principal, HttpServletRequest request) {

		String bpCode = serviceManager.userRepository.getBpCode(principal.getName());
		User us = serviceManager.userService.findByUsername(principal.getName());
		if (null == bpCode) {
			bpCode = "";
		}

		String vendorType = serviceManager.supDetailsRepo.findVendorType(bpCode);
		if ("".equals(vendorType) || null == vendorType) {
			vendorType = "vendor";
		}

		request.setAttribute("vendorType", vendorType);
		model.addAttribute("vendorType", vendorType);

		String[] vendorType1 = vendorType.split(",");

		if (vendorType1.length == 2 || vendorType.equalsIgnoreCase("Fixed Asset")
				|| vendorType.equalsIgnoreCase("FIXED ASSETS")) {
			String vendorCode = principal.getName();
			String rolename = serviceManager.rolesRepository.getuserRoleByUserName(vendorCode);
			List<PoDetails> details1 = new ArrayList<>();
			List<PoDetails> details = serviceManager.podetailsRepo.getAllUnProcessPo(vendorCode);
			String processBy = principal.getName();
			Date proceessOn = new Date();
			for (int i = 0; i < details.size(); i++) {
				List<PoLineDetails> podet = details.get(i).getPoline();
				String pono = details.get(i).getPoNo();
				float remaningquantity = 0;
				for (int j = 0; j < podet.size(); j++) {
					remaningquantity = remaningquantity + Float.parseFloat(podet.get(j).getRemaningQuatity());
				}
				if (remaningquantity != 0.0 || remaningquantity != 0.00 || remaningquantity != 0) {
					details1.add(details.get(i));
				} else {
					serviceManager.podetailsRepo.updateVendorPoStatusAgainsInvoiceNumber(pono, proceessOn, processBy);
				}
			}

			int totalAllPoCount = serviceManager.podetailsRepo.getAllPoCount(vendorCode);
			model.addAttribute("totalAllPoCount", totalAllPoCount);

			int totalProcessPoCount = serviceManager.podetailsRepo.getAllProcessPoCount(vendorCode);
			model.addAttribute("totalProcessPoCount", totalProcessPoCount);
			int totalUnprocessPOCount = serviceManager.podetailsRepo.getAllUnProcessPoCount(vendorCode);
			model.addAttribute("totalUnprocessPOCount", totalUnprocessPOCount);
			int totalQueryCount = serviceManager.podetailsRepo.getAllQueryCount(vendorCode);
			model.addAttribute("totalQueryCount", totalQueryCount);

			int totalInvoiceCount = serviceManager.poinvoiceRepo.getAllInvoiceCount(vendorCode);
			model.addAttribute("totalInvoiceCount", totalInvoiceCount);

			int allPOcount = serviceManager.poinvoiceRepo.getAllPOcount(vendorCode);
			model.addAttribute("allPOcount", allPOcount);

			int totalDraftInvoiceCount = serviceManager.poinvoiceRepo.getTotalDraftInvoiceCount(vendorCode);
			model.addAttribute("totalDraftInvoiceCount", totalDraftInvoiceCount);

			model.addAttribute("userStatus", us.getStatus());
			model.addAttribute("dataLimit", dataLimit);

			if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

				return "dashboard_Po";

			}
		}

		return "";
	}

	@GetMapping("/allPO")
	public String allPo(Model model, Principal principal, HttpServletRequest request) {

		String userName = principal.getName();
		String rolename = serviceManager.rolesRepository.getuserRoleByUserName(userName);

		String currentDate = new SimpleDateFormat(GlobalConstants.DATE_FORMATTER_YYYY_MM_DD).format(new Date());
		model.addAttribute("currentDate", currentDate);
		model.addAttribute("dataLimit", dataLimit);

		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

			return "allPO";

		}
		return "";
	}

	@GetMapping("/processPO")
	public String processPO(Model model, Principal principal, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");
		model.addAttribute("dataLimit", dataLimit);

		if (rolename.equalsIgnoreCase(GlobalConstants.ROLE_VENDOR)) {

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
	public String queryPo(Model model, Principal principal, HttpServletRequest request) {
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
		model.addAttribute("invoiceNo", invoiceNumber);
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

		model.addAttribute("invoiceNo", invoiceNumber);
		model.addAttribute("status", status);
		return "invoiceQueryPo";
	}

	@GetMapping("/PoView")
	public String poView(Model model, HttpServletRequest request, Principal principal) {

		String id = request.getParameter("id");
		String[] arr = id.split(",");
		String poNumber = "";
		String viewPage = "";

		if (arr.length == 1) {
			poNumber = arr[0];
		} else if (arr.length == 2) {
			poNumber = arr[0];
			viewPage = arr[1];
		}
		model.addAttribute("poNumber", poNumber);

		model.addAttribute("viewPage", viewPage);
		return "PoView";
	}

	@GetMapping("/poInvoiceGenerate")
	public String poInvoiceGenerate(Model model, HttpServletRequest request, Principal principal) {
		String invoiceNumber = "";
		invoiceNumber = generateInvoiceNumber();
		InvoiceNumber inNumber = new InvoiceNumber();
		inNumber.setEcomInvoiceNumber(invoiceNumber);
		inNumber.setStatus("Used_PO_Invoice");
		serviceManager.invoiceNumberRepo.save(inNumber);
		model.addAttribute("invoiceNumber", invoiceNumber);
		request.getSession().setAttribute("invoiceNumber", invoiceNumber);
		model.addAttribute("invoiceDate", new SimpleDateFormat("dd-MM-yyyy").format(new Date()));
		model.addAttribute("invoiceNumber", invoiceNumber);
		request.getSession().setAttribute("invoiceNumber", invoiceNumber);
		String poNumber = request.getParameter("id");
		List<String> paymentMethod = serviceManager.paymentMethodRepo.paymentMethod();
		model.addAttribute("PoNumber", poNumber);
		model.addAttribute("maxFileSize", maxFileSize);
		model.addAttribute("paymentMethod", paymentMethod);

		model.addAttribute("curentDate", new SimpleDateFormat(GlobalConstants.DATE_FORMATTER_YYYY_MM_DD).format(new Date()));
		List<String> payment = serviceManager.paymentTermRepo.getPaymentTerms();
		model.addAttribute("payment", payment);

		String bpCode = serviceManager.userRepository.getBpCode(principal.getName());
		if ("".equals(bpCode) || bpCode == null) {
			bpCode = "";
		}

		String creidtTerms = serviceManager.supDetailsRepo.findCreditTerms(bpCode);
		if ("".equals(creidtTerms) || creidtTerms == null) {
			creidtTerms = "";
		}
		List<String> accountNumber = new ArrayList<>();
		List<SupDetails> supDetails = serviceManager.supDetailsRepo.findbankAccountNumber(bpCode);
		String accountnumber = "";
		List<AccountDetails> listaccountNumber = supDetails.get(0).getAccountDetails();
		for (int i = 0; i < listaccountNumber.size(); i++) {
			accountnumber = listaccountNumber.get(i).getAccoutNumber();
			accountNumber.add(accountnumber);
		}

		model.addAttribute("accountNumber", accountNumber);
		model.addAttribute("creidtTerms", creidtTerms);
		return "poInvoiceGenerate";
	}

	@GetMapping("/draftPO")
	public String draftPO(Model model, HttpServletRequest request, Principal principal) {
		String poNumber = request.getParameter("id");
		model.addAttribute("dataLimit", dataLimit);
		model.addAttribute("PoNumber", poNumber);
		return "draftPO";
	}

	@GetMapping("/draftPoInvoiceGenerate")
	public String draftPoInvoiceGenerate(Model model, HttpServletRequest request, Principal principal) {
		String poNumber = request.getParameter("id");
		model.addAttribute("PoNumber", poNumber);
		model.addAttribute("invoiceNumber", poNumber);
		model.addAttribute("curentDate", new SimpleDateFormat("dd-MM-yyyy").format(new Date()));
		model.addAttribute("curentDate1", new SimpleDateFormat(GlobalConstants.DATE_FORMATTER_YYYY_MM_DD).format(new Date()));
		List<String> paymentMethod = serviceManager.paymentMethodRepo.paymentMethod();
		model.addAttribute("maxFileSize", maxFileSize);
		String bpCode = serviceManager.userRepository.getBpCode(principal.getName());
		if (null == bpCode) {
			bpCode = "";
		}

		String creidtTerms = serviceManager.supDetailsRepo.findCreditTerms(bpCode);
		if (null == creidtTerms) {
			creidtTerms = "";
		}
		model.addAttribute("creidtTerms", creidtTerms);
		model.addAttribute("paymentMethod", paymentMethod);

		List<String> accountNumber = new ArrayList<>();
		List<SupDetails> supDetails = serviceManager.supDetailsRepo.findbankAccountNumber(bpCode);
		String accountnumber = "";
		List<AccountDetails> listaccountNumber = supDetails.get(0).getAccountDetails();
		for (int i = 0; i < listaccountNumber.size(); i++) {
			accountnumber = listaccountNumber.get(i).getAccoutNumber();
			accountNumber.add(accountnumber);
		}
		model.addAttribute("accountNumber", accountNumber);
		List<String> payment = serviceManager.paymentTermRepo.getPaymentTerms();
		model.addAttribute("payment", payment);
		return "draftPoInvoiceGenerate";
	}

	public synchronized String generateInvoiceNumber() {
		long count = serviceManager.invoiceNumberRepo.count();
		String invoiceNumberPrefix = "ECOM-";
		count = count + 1;
		return invoiceNumberPrefix + String.format("%08d", count);
	}
}
