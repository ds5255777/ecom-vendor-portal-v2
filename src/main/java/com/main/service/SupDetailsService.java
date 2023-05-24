package com.main.service;

import com.main.db.bpaas.entity.SupDetailsTransaction;
import com.main.payloads.SupDetailsTransactionDTO;

public interface SupDetailsService {

	SupDetailsTransaction updateSuppDetails(SupDetailsTransactionDTO supDetails, String userName);

}
