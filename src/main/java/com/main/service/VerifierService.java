package com.main.service;

import java.util.List;

import javax.validation.Valid;

import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.Verifier;
import com.main.payloads.VerifierDTO;

public interface VerifierService {


	Verifier findVerifierById(Long id);

	List<Verifier> findByStatus(String status);

	DataContainer deleteVerifier(Long id);

	//Verifier updateVerifier(VerifierDTO verifierDto);
	
	DataContainer updateVerifier(VerifierDTO verifierDto);

	DataContainer addVerifier(@Valid VerifierDTO verifierDto);

	DataContainer listOfAllVerifiers();


	List<VerifierDTO> getVerifierNamesByRegionList(List<String> regionList);

//	List<VerifierDTO> getVerifierNamesByRegionId(List<Integer> regionId);

	

	    
	}
