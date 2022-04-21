package com.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.db.bpaas.entity.TripDetails;
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

	@Override
	public List<InvoiceGenerationEntity> getAllProcessInvoice() {
		List<InvoiceGenerationEntity> invoice = this.invoiceGenerationEntityRepo.getAllProcessInvoice();
		return invoice;
	}

	@Override
	public List<InvoiceGenerationEntity> getAllUnProcessInvoice() {
		List<InvoiceGenerationEntity> invoice = this.invoiceGenerationEntityRepo.getAllUnProcessInvoice();
		return invoice;
	}
	
	@Override
	public List<InvoiceGenerationEntity> getAllQueryInvoice() {
		List<InvoiceGenerationEntity> invoice = this.invoiceGenerationEntityRepo.getAllQueryInvoice();
		return invoice;
	}
	
	@Override
	public List<InvoiceGenerationEntity> getAllInReviewInvoice() {
		List<InvoiceGenerationEntity> invoice = this.invoiceGenerationEntityRepo.getAllInReviewInvoice();
		return invoice;
	}
	
	@Override
	public List<InvoiceGenerationEntity> getPaymentReleaseInvoice() {
		List<InvoiceGenerationEntity> invoice = this.invoiceGenerationEntityRepo.getPaymentReleaseInvoice();
		return invoice;
	}

	@Override
	public List<InvoiceGenerationEntity> getTripsByFilters(String vendorCode, String invoiceStatus) {
		
		if ( "".equalsIgnoreCase(invoiceStatus)) {
			System.out.println(vendorCode + " : " + invoiceStatus );
			return invoiceGenerationEntityRepo.getInvoiceFiltersByVendorcode(vendorCode);
		}
		System.out.println(vendorCode + " : " + invoiceStatus );
		return invoiceGenerationEntityRepo.getInvoiceFiltersByVendorcode(vendorCode, invoiceStatus);
	}

}
