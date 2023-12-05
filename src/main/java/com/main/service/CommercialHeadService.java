package com.main.service;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.SendEmailToVendor;
import com.main.db.bpaas.entity.Verifier;
import com.main.payloads.SendEmailToVendorDTO;
import com.main.payloads.SupDetailsDTO;

public interface CommercialHeadService {


	DataContainer getDetailFromCommercialTeam(Principal principal);


	DataContainer findCommercialTeamDetailsById(SendEmailToVendorDTO sendEmailToVendorDto,Principal principal,HttpServletRequest request);


	DataContainer rejectCommercialTeamDetails(SendEmailToVendorDTO sendEmailToVendorDto,HttpServletRequest request, Principal principal);


	DataContainer rasieQueryCommercialTeam(SendEmailToVendorDTO sendEmailToVendorDto, Principal principal,
			HttpServletRequest request);


	DataContainer approveByCommercialTeam(SendEmailToVendorDTO sendEmailToVendorDto, Principal principal,
			HttpServletRequest request);



//	DataContainer getSupplierDetailsByThirdPartyVerifier();


	DataContainer rejectByVerifier(SendEmailToVendorDTO sendEmailToVendorDto, HttpServletRequest request, Principal principal);


	DataContainer approveByThirdPartyVerifier(SendEmailToVendorDTO sendEmailToVendorDto, Principal principal,
			HttpServletRequest request);


//	DataContainer getSupplierDetailsForEhsVerification();


	DataContainer rejectByEhsVerifier(SendEmailToVendorDTO sendEmailToVendorDto, HttpServletRequest request,
			Principal principal);


	DataContainer approveByEhsVerifier(SendEmailToVendorDTO sendEmailToVendorDto, Principal principal,
			HttpServletRequest request);


	DataContainer findListOfAllVendorByThirdPartyVerifier();


	DataContainer getCommentDetailsOnThirdPartyVerifierPage(String vendorPid);


	DataContainer findListOfAllVendorByEhsVerifier(HttpServletRequest request,Principal principal);


	DataContainer approveBySeniorManagerForEhsVerification(SendEmailToVendorDTO sendEmailToVendorDto,
			Principal principal, HttpServletRequest request);


	DataContainer rejectByEhsManager(SendEmailToVendorDTO sendEmailToVendorDto, HttpServletRequest request,
			Principal principal);


	DataContainer findListOfAllVendorByDocumentChecker(HttpServletRequest request, Principal principal);





	//DataContainer updateVendor(SupDetailsDTO supDetailsDTO, Principal principal, HttpServletRequest request);

	

}
