package com.main.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.TripDetails;

@Service
public interface InvoiceService {
	
	InvoiceGenerationEntity getInvoiceById(Long id);
	
	List<InvoiceGenerationEntity> getTopFiftyInvoice();
	
	List<InvoiceGenerationEntity> getAllInvoice();
	
	List<InvoiceGenerationEntity> getAllProcessInvoice();
	
	List<InvoiceGenerationEntity> getAllUnProcessInvoice();

	List<InvoiceGenerationEntity> getAllQueryInvoice();

	List<InvoiceGenerationEntity> getAllInReviewInvoice();

	List<InvoiceGenerationEntity> getPaymentReleaseInvoice();

	List<InvoiceGenerationEntity> getTripsByFilters(String vendorCode, String selectInvoicingStatus);

}
