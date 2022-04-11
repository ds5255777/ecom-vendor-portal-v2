package com.main.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.main.db.bpaas.entity.InvoiceGenerationEntity;

@Service
public interface InvoiceService {
	
	InvoiceGenerationEntity getInvoiceById(Long id);
	
	List<InvoiceGenerationEntity> getTopFiftyInvoice();
	
	List<InvoiceGenerationEntity> getAllInvoice();

}
