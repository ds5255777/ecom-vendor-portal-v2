package com.main.service;

import com.main.db.bpaas.entity.SupDetails;
//import com.main.controller.SupDetails;
import com.main.db.bpaas.entity.SupDetailsTransaction;
import com.main.payloads.SupDetailsTransactionDTO;

public interface SupDetailsService {

	SupDetailsTransaction updateSuppDetails(SupDetailsTransactionDTO supDetails, String userName);

	SupDetails getSupplierDetailsByVendorPid(String vendorPid);


//	SupDetails getSupplierDetailsByVendorPid(String vendorPid);

}
