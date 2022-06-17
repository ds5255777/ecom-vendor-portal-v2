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

import com.main.db.bpaas.entity.AccountDetails;
import com.main.db.bpaas.entity.PoDetails;
import com.main.db.bpaas.entity.PoLineDetails;
import com.main.db.bpaas.entity.SupDetails;
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



		
		

			if (vendorType.equalsIgnoreCase("Fixed Asset") || vendorType.equalsIgnoreCase("FIXED ASSETS")) {
				String rolename = (String) request.getSession().getAttribute("role");
				String vendorCode = (String) request.getSession().getAttribute("userName");
				System.out.println("vendor type : " + vendorType);

				 rolename = (String) request.getSession().getAttribute("role");
				 vendorCode = (String) request.getSession().getAttribute("userName");

				 	List<PoDetails> details1=new ArrayList<PoDetails>();
					List<PoDetails> details = serviceManager.podetailsRepo.getAllUnProcessPo(vendorCode);
					
					for(int i=0;i<details.size();i++) {
						List<PoLineDetails> podet=details.get(i).getPoline();
						String pono=details.get(i).getPoNo();
						float remaningquantity=0;
						for(int j=0;j<podet.size();j++) {
							remaningquantity=remaningquantity+Float.parseFloat(podet.get(j).getRemaningQuatity());
						}
						if(remaningquantity!=0.0 || remaningquantity!=0.00 ||remaningquantity!=0) {
							details1.add(details.get(i));
						}else {
							serviceManager.podetailsRepo.updateVendorPoStatusAgainsInvoiceNumber(pono);
						}
						System.out.println("remaningquantity is :::"+remaningquantity +"VendorCode ::"+vendorCode);
					}

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
		
		return "";
	}

	@GetMapping("/allPO")
	public String allPo(Model model, Principal principal, HttpServletRequest request) {

		String rolename = (String) request.getSession().getAttribute("role");

		String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		model.addAttribute("currentDate", currentDate);
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
		
		List<String>  paymentMethod=  serviceManager.paymentMethodRepo.PaymentMethod();

		String[] arr = new String[exitingInvoiceNo.size()];
		for (int i = 0; i < exitingInvoiceNo.size(); i++) {
			arr[i] = exitingInvoiceNo.get(i);

			if (invoiceNumber.equalsIgnoreCase(arr[i])) {
				
				invoiceNumber = userNameIs + String.format("%08d", totalInvoiceCount + 3);
			}

		}
		model.addAttribute("invoiceDate", new SimpleDateFormat("dd-MM-yyyy").format(new Date()));
		model.addAttribute("invoiceNumber", invoiceNumber);
		request.getSession().setAttribute("invoiceNumber", invoiceNumber);

		String PoNumber = request.getParameter("id");
		model.addAttribute("PoNumber", PoNumber);
		model.addAttribute("maxFileSize", maxFileSize);
		model.addAttribute("paymentMethod", paymentMethod);

		PoDetails findByPoNumber = null;
		findByPoNumber = serviceManager.podetailsRepo.findByPoNo(PoNumber);
		model.addAttribute("curentDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
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
		List<String> accountNumber= new ArrayList<String>();
		List<SupDetails> supDetails = serviceManager.supDetailsRepo.findbankAccountNumber(bpCode);
		String accountnumber="";
		List<AccountDetails> listaccountNumber = supDetails.get(0).getAccountDetails();
		for(int i=0;i<listaccountNumber.size();i++) {
			
		 
			accountnumber= listaccountNumber.get(i).getAccoutNumber();
			accountNumber.add(accountnumber);
		}
		
		
		if ("".equals(accountnumber) || accountnumber == null) {
			accountnumber = "";
		}
		model.addAttribute("accountNumber", accountNumber);

		
		model.addAttribute("creidtTerms", creidtTerms);
		System.out.println("creidtTerms : "+creidtTerms);
		
		
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
		model.addAttribute("curentDate", new SimpleDateFormat("dd-MM-yyyy").format(new Date()));
		model.addAttribute("curentDate1", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		List<String>  paymentMethod=  serviceManager.paymentMethodRepo.PaymentMethod();
		model.addAttribute("maxFileSize", maxFileSize);
		String bpCode = serviceManager.userRepository.getBpCode(principal.getName());
		if ("".equals(bpCode) || bpCode == null) {
			bpCode = "";
		}
		
		String creidtTerms = serviceManager.supDetailsRepo.findCreditTerms(bpCode);
		if ("".equals(creidtTerms) || creidtTerms == null) {
			creidtTerms = "";
		}
		model.addAttribute("creidtTerms", creidtTerms);
		model.addAttribute("paymentMethod", paymentMethod);
		
		List<String> accountNumber= new ArrayList<String>();
		List<SupDetails> supDetails = serviceManager.supDetailsRepo.findbankAccountNumber(bpCode);
		String accountnumber="";
		List<AccountDetails> listaccountNumber = supDetails.get(0).getAccountDetails();
		for(int i=0;i<listaccountNumber.size();i++) {
			
		 
			accountnumber= listaccountNumber.get(i).getAccoutNumber();
			accountNumber.add(accountnumber);
		}
		
		
		if ("".equals(accountnumber) || accountnumber == null) {
			accountnumber = "";
		}
		model.addAttribute("accountNumber", accountNumber);
		
	
		List<String> payment = serviceManager.paymentTermRepo.getPaymentTerms();
		model.addAttribute("payment", payment);
		return "draftPoInvoiceGenerate";
	}

}
