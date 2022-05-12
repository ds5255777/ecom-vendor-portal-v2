package com.main.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.main.db.bpaas.entity.PoDetails;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.repo.PoDetailsRepo;
import com.main.db.bpaas.repo.PoInvoiceRepo;

@Controller
public class PoUiController {
	
	Integer i=1;
	
	@Autowired 
	PoDetailsRepo podetailsRepo;
	
	@Autowired
	PoInvoiceRepo poinvoiceRepo;

	 @GetMapping("/dashboard_Po")
	   	public String dashboard_Po(Model model, Principal principal, HttpServletRequest request) {
	   		
			 String rolename = (String) request.getSession().getAttribute("role");
			 String vendorCode = (String) request.getSession().getAttribute("userName");
				
				//po Details
			 	int totalAllPoCount = podetailsRepo.getAllPoCount(vendorCode);
				model.addAttribute("totalAllPoCount", totalAllPoCount);
			 
				int totalProcessPoCount = podetailsRepo.getAllProcessPoCount(vendorCode);
				model.addAttribute("totalProcessPoCount", totalProcessPoCount);
				System.out.println("totalProcessPoCount : "+totalProcessPoCount);
				int totalUnprocessPOCount= podetailsRepo.getAllUnProcessPoCount(vendorCode);
				model.addAttribute("totalUnprocessPOCount", totalUnprocessPOCount);
				//Query
				int totalQueryCount= podetailsRepo.getAllQueryCount(vendorCode);
				model.addAttribute("totalQueryCount", totalQueryCount);
				
				//Query
				int totalInvoiceCount= poinvoiceRepo.getAllInvoiceCount(vendorCode);
				model.addAttribute("totalInvoiceCount", totalInvoiceCount);
				
				int allPOcount= poinvoiceRepo.getAllPOcount(vendorCode);
				model.addAttribute("allPOcount", allPOcount);
				
				int totalDraftInvoiceCount= poinvoiceRepo.getTotalDraftInvoiceCount(vendorCode);
				model.addAttribute("totalDraftInvoiceCount", totalDraftInvoiceCount);
				
				System.out.println("end of dashboard_Po");
			 
			 
				if (rolename.equalsIgnoreCase("Vendor")) {
					
					return "dashboard_Po";
					
				}
	   		return "";
	   	}
	 
	 @GetMapping("/allPO")
	   	public String allPo(Model model, Principal principal, HttpServletRequest request) {
	   		
			 String rolename = (String) request.getSession().getAttribute("role");

				if (rolename.equalsIgnoreCase("Vendor")) {
					
					return "allPO";
					
				}
	   		return "";
	   	}
	 @GetMapping("/processPO")
	   	public String processPO(Model model, Principal principal, HttpServletRequest request) {
	   		
			 String rolename = (String) request.getSession().getAttribute("role");

				if (rolename.equalsIgnoreCase("Vendor")) {
					
					return "processPO";
					
				}
	   		return "";
	   	}
	
	 @GetMapping("/unprocessPO")
	   	public String unprocessPO(Model model, Principal principal, HttpServletRequest request) {
	   		
			 String rolename = (String) request.getSession().getAttribute("role");

				if (rolename.equalsIgnoreCase("Vendor")) {
					
					return "unprocessPO";
					
				}
	   		return "";
	   	}
	 
		 @GetMapping("/poInvoiceDetails")
	   	public String poInvoiceDetails(Model model, Principal principal, HttpServletRequest request) {
	   		
			 String rolename = (String) request.getSession().getAttribute("role");
			
				if (rolename.equalsIgnoreCase("Vendor")) {
					
					return "poInvoiceDetails";
					
				}
	   		return "";
	   	}
	 
	 @GetMapping("/QueryPo")
	   	public String QueryPo(Model model, Principal principal, HttpServletRequest request) {
	   		
			 String rolename = (String) request.getSession().getAttribute("role");
			
				if (rolename.equalsIgnoreCase("Vendor")) {
					
					return "QueryPo";
					
				}
	   		return "";
	   	}
	 
	 @GetMapping("/invoiceViewPo")
		public String invoiceViewPo(Model model, HttpServletRequest request, Principal principal) {
		 	
			String obj= request.getParameter("ob");
			String invoiceNumber="";
			String status="";
			String[] arrSplit = obj.split(",");
		    for (int i=0; i < arrSplit.length; i++)
		    {
		      if(i==0) {
		    	  invoiceNumber= arrSplit[i];
		      }
		      if(i==1) {
		    	  status=arrSplit[i];
		      }
		    }
		
			System.out.println("invoiceNo"+invoiceNumber);
			model.addAttribute("invoiceNo", invoiceNumber);
			System.out.println("status"+status);
			model.addAttribute("status", status);
			return "invoiceViewPo";
		}
	 @GetMapping("/invoiceQueryPo")
		public String invoiceQueryPo(Model model, HttpServletRequest request, Principal principal) {
		 	
			String obj= request.getParameter("ob");
			String invoiceNumber="";
			String status="";
			String[] arrSplit = obj.split(",");
		    for (int i=0; i < arrSplit.length; i++)
		    {
		      if(i==0) {
		    	  invoiceNumber= arrSplit[i];
		      }
		      if(i==1) {
		    	  status=arrSplit[i];
		      }
		    }
		
			System.out.println("invoiceNo"+invoiceNumber);
			model.addAttribute("invoiceNo", invoiceNumber);
			System.out.println("status"+status);
			model.addAttribute("status", status);
			return "invoiceViewPo";
		}
		@GetMapping("/PoView")
		public String PoView(Model model, HttpServletRequest request, Principal principal) {

			String id = request.getParameter("id");
			String arr[]=id.split(",");
			String poNumber="";
			String viewPage="";
			for(int i=0;i<arr.length;i++) {
				if(arr.length==1) {
					poNumber=arr[0];
					break;
				}else {
					poNumber=arr[0];
					viewPage=arr[1];
					break;
				}
			}
			
			System.out.println("poNumber"+poNumber);
			model.addAttribute("poNumber", poNumber);
		
			System.out.println("viewPage"+viewPage);
			model.addAttribute("viewPage", viewPage);
			return "PoView";
		}
		
		@GetMapping("/poInvoiceGenerate")
		public String poInvoiceGenerate(Model model, HttpServletRequest request, Principal principal) {

			String userName = principal.getName();
			
			String userNameIs ="00000000";
			String invoiceNumber = "";

				 
			invoiceNumber = "ECOM-" + userNameIs +i;
			i++;

			
			model.addAttribute("invoiceNumber", invoiceNumber);
			request.getSession().setAttribute("invoiceNumber", invoiceNumber);

			
			
			

			
					
				
			
			
			String PoNumber = request.getParameter("id");
			model.addAttribute("PoNumber", PoNumber);
			
			PoDetails findByPoNumber = null;
			findByPoNumber = podetailsRepo.findByPoNo(PoNumber);

			if (null != findByPoNumber.getPoNo()) {
				findByPoNumber.setStatus("Draft-Invoicing");
				findByPoNumber.setInvoiceNumber(invoiceNumber);
				podetailsRepo.save(findByPoNumber);
			}
			
			System.out.println("Eom invoiceNumber : "+invoiceNumber);
			
			return "poInvoiceGenerate";
		}
		
		@GetMapping("/draftPO")
		public String draftPO(Model model, HttpServletRequest request, Principal principal) {

			String PoNumber = request.getParameter("id");
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
