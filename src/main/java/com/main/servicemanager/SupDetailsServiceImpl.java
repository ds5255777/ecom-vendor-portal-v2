package com.main.servicemanager;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.SupDetails;
import com.main.db.bpaas.entity.SupDetailsTransaction;
import com.main.db.bpaas.repo.SupDetailsTransactionRepo;
import com.main.payloads.AccountDetailsDTO;
import com.main.payloads.AccountDetailsTransactionDTO;
import com.main.payloads.AddressDetailsDTO;
import com.main.payloads.AddressDetailsTransactionDTO;
import com.main.payloads.ContactDetailsDTO;
import com.main.payloads.ContactDetailsTransactionDTO;
import com.main.payloads.SupDetailsDTO;
import com.main.payloads.SupDetailsTransactionDTO;
import com.main.service.SupDetailsService;

@Service
public class SupDetailsServiceImpl implements SupDetailsService {

	private static Logger logger = LoggerFactory.getLogger(SupDetailsServiceImpl.class);

	@Autowired
	private ModelMapper modelMapper;

	@Autowired
	private ServiceManager serviceManager;

	@Autowired
	private SupDetailsTransactionRepo supRepo;

	@Override
	public SupDetailsTransaction updateSuppDetails(SupDetailsTransactionDTO supDetails, String userName) {

		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat(GlobalConstants.DATE_FORMATTER);
		String strDate = dateFormat.format(date);

		SupDetailsTransaction supDetailsTransaction = null;
		try {
			SupDetails findBybpCode = serviceManager.supDetailsRepo.findBybpCode(supDetails.getBpCode());

			logger.info("Vendor Update :::::: {}", supDetails.getBpCode());
			SupDetailsDTO supDetailsDTO = new SupDetailsDTO();

			supDetailsDTO.setId(findBybpCode.getId());
			supDetailsDTO.setPid(findBybpCode.getPid());
			supDetailsDTO.setBpCode(findBybpCode.getBpCode());
			supDetailsDTO.setSuppName(supDetails.getSuppName());
			supDetailsDTO.setAadharNumber(findBybpCode.getAadharNumber());
			supDetailsDTO.setAdharLinkStatus(findBybpCode.getAdharLinkStatus());
			supDetailsDTO.setCreateDate(findBybpCode.getCreateDate());
			supDetailsDTO.setCreditTerms(findBybpCode.getCreditTerms());
			supDetailsDTO.setEro(findBybpCode.getEro());
			supDetailsDTO.setIhq(findBybpCode.getIhq());
			supDetailsDTO.setIntroducedByEmailID(findBybpCode.getIntroducedByEmailID());
			supDetailsDTO.setIntroducedByName(findBybpCode.getIntroducedByName());
			supDetailsDTO.setInvoiceCurrency(findBybpCode.getInvoiceCurrency());
			supDetailsDTO.setNro(findBybpCode.getNro());

			supDetailsDTO.setPanNumber(findBybpCode.getPanNumber());
			supDetailsDTO.setPaymentCurrency(findBybpCode.getPaymentCurrency());
			supDetailsDTO.setReferralEmailId(findBybpCode.getReferralEmailId());
			supDetailsDTO.setSro(findBybpCode.getSro());
			supDetailsDTO.setWro(findBybpCode.getWro());
			supDetailsDTO.setFlag(findBybpCode.getFlag());
			supDetailsDTO.setBusinessClassification(supDetails.getBusinessClassification());
			supDetailsDTO.setMesmeNumber(supDetails.getMesmeNumber());
			supDetailsDTO.setSectionType(supDetails.getSectionType());
			supDetailsDTO.setTanNumber(supDetails.getTanNumber());
			supDetailsDTO.setEnInvApplicable(supDetails.getEnInvApplicable());
			supDetailsDTO.setPaymentMethod(supDetails.getPaymentMethod());
			supDetailsDTO.setDeliveryTerms(supDetails.getDeliveryTerms());
			supDetailsDTO.setDateBasis(supDetails.getDateBasis());
			supDetailsDTO.setTdsApplication(supDetails.getTdsApplication());
			supDetailsDTO.setTdsRate(supDetails.getTdsRate());
			supDetailsDTO.setTdsSection(supDetails.getTdsSection());
			supDetailsDTO.setFyYear1(supDetails.getFyYear1());
			supDetailsDTO.setFyYear2(supDetails.getFyYear2());
			supDetailsDTO.setFyYear3(supDetails.getFyYear3());
			supDetailsDTO.setAcknowledgementNumber1(supDetails.getAcknowledgementNumber1());
			supDetailsDTO.setAcknowledgementNumber2(supDetails.getAcknowledgementNumber2());
			supDetailsDTO.setAcknowledgementNumber3(supDetails.getAcknowledgementNumber3());
			supDetailsDTO.setProcessedBy(userName);
			supDetailsDTO.setProcessedOn(strDate);
			supDetailsDTO.setVenStatus(GlobalConstants.UPDATE_VENDOR);

			List<ContactDetailsTransactionDTO> contactDetails = supDetails.getContactDetails();
			List<AddressDetailsTransactionDTO> addressDetails = supDetails.getAddressDetails();
			List<AccountDetailsTransactionDTO> accountDetails = supDetails.getAccountDetails();

			// supDetails.setAccountDetails(accountDetails);
			List<ContactDetailsDTO> contactMap = new ArrayList<>();
			for (ContactDetailsTransactionDTO contactDto : contactDetails) {
				ContactDetailsDTO contactDetailsDTO = this.modelMapper.map(contactDto, ContactDetailsDTO.class);
				contactMap.add(contactDetailsDTO);
			}

			List<AddressDetailsDTO> addressMap = new ArrayList<>();
			for (AddressDetailsTransactionDTO addressDto : addressDetails) {
				AddressDetailsDTO addressDetailsDTO = this.modelMapper.map(addressDto, AddressDetailsDTO.class);
				addressMap.add(addressDetailsDTO);
			}

			List<AccountDetailsDTO> accountMap = new ArrayList<>();
			for (AccountDetailsTransactionDTO accountDto : accountDetails) {
				AccountDetailsDTO accountDetailsDTO = this.modelMapper.map(accountDto, AccountDetailsDTO.class);
				accountMap.add(accountDetailsDTO);
			}

			supDetailsDTO.setAccountDetails(accountMap);
			supDetailsDTO.setContactDetails(contactMap);
			supDetailsDTO.setAddressDetails(addressMap);

			SupDetails supplierDetails = this.modelMapper.map(supDetailsDTO, SupDetails.class);

			serviceManager.supDetailsRepo.save(supplierDetails);

			supDetails.setVenStatus(GlobalConstants.UPDATE_VENDOR);
			supDetails.setProcessedBy(userName);
			supDetails.setProcessedOn(strDate);
			supDetailsTransaction = this.modelMapper.map(supDetails, SupDetailsTransaction.class);
			supRepo.save(supDetailsTransaction);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("Error in SupDetailsServiceImpl, updateSuppDetails ::::: {}", e);
		}

		return supDetailsTransaction;
	}

	@Override
	public SupDetails getSupplierDetailsByVendorPid(String vendorPid) {
		// TODO Auto-generated method stub
		return null;
	}

}
