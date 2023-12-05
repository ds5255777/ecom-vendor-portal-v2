package com.main.service;

import java.security.Principal;
import java.util.List;

import com.main.bean.DataContainer;


public interface SearchService {

	DataContainer searchVendors(List<String> vendorTypes, List<String> regions, List<String> creditTerms, String verifierName, String status,Principal pri);

	DataContainer listOfAllVendors(Principal principal);

	DataContainer getCommentDetails(String vendorPid);

}
