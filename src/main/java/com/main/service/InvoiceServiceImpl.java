package com.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.repo.InvoiceGenerationEntityRepo;
@Service
public class InvoiceServiceImpl implements InvoiceService {

	@Autowired
	private InvoiceGenerationEntityRepo invoiceGenerationEntityRepo;

	@Override
	public InvoiceGenerationEntity getInvoiceById(Long id) {
		InvoiceGenerationEntity invoice = this.invoiceGenerationEntityRepo.findById(id).orElseThrow();
		return invoice;
	}

	@Override
	public List<InvoiceGenerationEntity> getAllInvoice() {
		List<InvoiceGenerationEntity> invoice = this.invoiceGenerationEntityRepo.getAllInvoiceByFinance();
		return invoice;
	}

	@Override
	public List<InvoiceGenerationEntity> getTopFiftyInvoice() {
		List<InvoiceGenerationEntity> invoice = this.invoiceGenerationEntityRepo.topFiftyUnProcessedInvoice();
		return invoice;
	}

}
