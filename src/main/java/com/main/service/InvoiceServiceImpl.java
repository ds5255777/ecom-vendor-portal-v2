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
		return this.invoiceGenerationEntityRepo.findById(id).orElseThrow(null);
	}

	@Override
	public List<InvoiceGenerationEntity> getAllInvoice() {
		return this.invoiceGenerationEntityRepo.getAllInvoiceByFinance();
	}

	@Override
	public List<InvoiceGenerationEntity> getTopFiftyInvoice() {
		return this.invoiceGenerationEntityRepo.topFiftyUnProcessedInvoice();
	}

	@Override
	public List<InvoiceGenerationEntity> getAllProcessInvoice() {
		return this.invoiceGenerationEntityRepo.getAllProcessInvoice();
	}

	@Override
	public List<InvoiceGenerationEntity> getAllUnProcessInvoice() {
		return this.invoiceGenerationEntityRepo.getAllUnProcessInvoice();
	}

	@Override
	public List<InvoiceGenerationEntity> getAllQueryInvoice() {
		return this.invoiceGenerationEntityRepo.getAllQueryInvoice();
	}

	@Override
	public List<InvoiceGenerationEntity> getAllInReviewInvoice() {
		return this.invoiceGenerationEntityRepo.getAllInReviewInvoice();
	}

	@Override
	public List<InvoiceGenerationEntity> getPaymentReleaseInvoice() {
		return this.invoiceGenerationEntityRepo.getPaymentReleaseInvoice();
	}

	@Override
	public List<InvoiceGenerationEntity> getTripsByFilters(String vendorCode, String invoiceStatus) {

		if ("".equalsIgnoreCase(invoiceStatus)) {
			return invoiceGenerationEntityRepo.getInvoiceFiltersByVendorcode(vendorCode);
		}
		return invoiceGenerationEntityRepo.getInvoiceFiltersByVendorcode(vendorCode, invoiceStatus);
	}

}
