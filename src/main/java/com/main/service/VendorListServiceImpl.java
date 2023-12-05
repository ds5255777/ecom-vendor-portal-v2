package com.main.service;



import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.SendEmailToVendor;
import com.main.db.bpaas.entity.Verifier;
import com.main.payloads.SendEmailToVendorDTO;
import com.main.payloads.VerifierDTO;
import com.main.servicemanager.ServiceManager;

@Service
public class VendorListServiceImpl implements VendorListService {

	@Autowired
	private ServiceManager serviceManager;
	
	
	@Override
	public DataContainer findByFlag() {
		
		
		DataContainer data = new DataContainer();
		List<Integer> flagsSet = new ArrayList<>();
		flagsSet.add(GlobalConstants.FLAG);
		flagsSet.add(GlobalConstants.APPROVE);

		List<SendEmailToVendor> listOfVendor = serviceManager.sendEmailToVendorRepo
				.findByFlagIn(flagsSet);
		if (!listOfVendor.isEmpty()) {
			 List<SendEmailToVendorDTO> vendorDtoList = listOfVendor.stream()
		                .map(sendMailToVendor -> {
		                	SendEmailToVendorDTO sendEmailToVendorDTO = new SendEmailToVendorDTO();
		                	sendEmailToVendorDTO.setId(sendMailToVendor.getId());
		                	sendEmailToVendorDTO.setVendorEmail(sendMailToVendor.getVendorEmail());
		                	sendEmailToVendorDTO.setVendorType(sendMailToVendor.getVendorType());
		                	sendEmailToVendorDTO.setRegion(sendMailToVendor.getRegion());
		                	sendEmailToVendorDTO.setCreditTerms(sendMailToVendor.getCreditTerms());
		                	sendEmailToVendorDTO.setThirdPartyVerification(sendMailToVendor.getThirdPartyVerification());
		                	sendEmailToVendorDTO.setEhsVerification(sendMailToVendor.getEhsVerification());
		                	sendEmailToVendorDTO.setComments(sendMailToVendor.getComments());
		                	sendEmailToVendorDTO.setFlag(sendMailToVendor.getFlag());
		                    // Set other properties as needed
		                    return sendEmailToVendorDTO;
		                })
		                .collect(Collectors.toList());

		        data.setData(vendorDtoList);
		        data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		    } else {
		        data.setMsg(GlobalConstants.DATA_NOT_FOUND);
		    }

		    return data;
		
	}
	
}
