package com.main.service;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.controller.UserController;
import com.main.db.bpaas.entity.Region;
import com.main.db.bpaas.entity.Verifier;
import com.main.payloads.RegionDTO;
import com.main.payloads.VerifierDTO;
import com.main.servicemanager.ServiceManager;

@Service
public class VerifierServiceImpl implements VerifierService {

	
	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private ServiceManager serviceManager;
	
	

	@Override
	public DataContainer addVerifier(@Valid VerifierDTO verifierDto) {
		DataContainer data = new DataContainer();
		Optional<Verifier> verifier = serviceManager.verifierRepository
				.findByVerifierNameAndStatus(verifierDto.getVerifierName(), GlobalConstants.ACTIVE_STATUS);
		if (!verifier.isPresent()) {

			Verifier verifierObj = serviceManager.modelMapper.map(verifierDto, Verifier.class);

//			Region region = serviceManager.regionRepository.findById(verifierDto.getRegionId()).orElse(null);
//			verifierObj.setRegion(region);

			verifierObj.setStatus(GlobalConstants.ACTIVE_STATUS);
			serviceManager.verifierRepository.save(verifierObj);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} else {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
		}
		return data;

	}

	@Override
	public Verifier findVerifierById(Long id) {
		return serviceManager.verifierRepository.findById(id).orElse(null);
	}

	@Override
	public List<Verifier> findByStatus(String status) {

		return serviceManager.verifierRepository.findByStatus(status);
	}

	@Override
	public DataContainer deleteVerifier(Long id) {
		DataContainer data = new DataContainer();
		Optional<Verifier> verifierOptional = serviceManager.verifierRepository.findByIdAndStatus(id,
				GlobalConstants.ACTIVE_STATUS);
		if (verifierOptional.isPresent()) {
			Verifier verifier = verifierOptional.get();
			verifier.setStatus(GlobalConstants.INACTIVE_STATUS);
			serviceManager.verifierRepository.save(verifier);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			return data;
		}
		data.setMsg(GlobalConstants.ERROR_MESSAGE);
		return data;
	}

	@Override
	public DataContainer updateVerifier(VerifierDTO verifierDto) {

		DataContainer data = new DataContainer();
		Optional<Verifier> verifier = serviceManager.verifierRepository.findByIdAndStatus(verifierDto.getId(),
				GlobalConstants.ACTIVE_STATUS);

		if (verifier.isPresent()) {
			Verifier verifierObj = verifier.get();
			verifierObj.setVerifierName(verifierDto.getVerifierName());
			verifierObj.setEmailId(verifierDto.getEmailId());
			verifierObj.setRegionId(verifierDto.getRegionId());
			verifierObj.setStatus(GlobalConstants.ACTIVE_STATUS);
			serviceManager.verifierRepository.save(verifierObj);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} else {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
		}

		return data;
	}

	@Override
	public DataContainer listOfAllVerifiers() {
		DataContainer data = new DataContainer();

		List<Verifier> allVerifiers = serviceManager.verifierRepository
				.findByStatusOrderByIdDesc(GlobalConstants.ACTIVE_STATUS);
		if (!allVerifiers.isEmpty()) {
			List<VerifierDTO> verifierDtoList = new ArrayList<>();

			for (Verifier verifier : allVerifiers) {
				VerifierDTO verifierDto = new VerifierDTO();
				verifierDto.setId(verifier.getId());
				verifierDto.setVerifierName(verifier.getVerifierName());
				verifierDto.setEmailId(verifier.getEmailId());
				verifierDto.setStatus(verifier.getStatus());
				verifierDto.setRegionId(verifier.getRegionId());
				verifierDto.setRegionName(verifier.getRegion().getRegionName());
				verifierDtoList.add(verifierDto);
				System.out.println(verifierDto);
			}

			data.setData(verifierDtoList);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} else {
			data.setMsg(GlobalConstants.DATA_NOT_FOUND);
		}

		return data;
	}
	

	@Override
	public List<VerifierDTO> getVerifierNamesByRegionList(List<String> regionList) {
		 List<VerifierDTO> dtoList =new ArrayList<>();	
		

    try {
        List<Verifier> verifiers = serviceManager.verifierRepository.findByRegionNameIn(regionList);
        for (Verifier verifier : verifiers) {
        	VerifierDTO dtoobj=new VerifierDTO();
        	dtoobj.setRegionId(verifier.getRegionId());
        	dtoobj.setRegionName(verifier.getRegionName());
        	dtoobj.setVerifierName(verifier.getVerifierName());
        	dtoobj.setId(verifier.getId());
        	dtoobj.setEmailId(verifier.getEmailId());
        	dtoList.add(dtoobj);
        	
		}
//         dtoList = verifiers.stream().map(entityObj -> modelMapper.map(entityObj, VerifierDTO.class)).collect(Collectors.toList());
      
    } catch (Exception e) {
        logger.error("Error retrieving verifier names by region ID: {}", e);
    }

    return dtoList;
    
	}

}
