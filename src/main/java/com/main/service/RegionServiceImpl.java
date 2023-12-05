package com.main.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.Region;
import com.main.db.bpaas.entity.Verifier;
import com.main.payloads.RegionDTO;
import com.main.servicemanager.ServiceManager;

@Service
public class RegionServiceImpl implements RegionService {
	
	@Autowired
	private ServiceManager serviceManager;
	
	@Override
	public List<Region> findByStatus(String status) {
		
		return serviceManager.regionRepository.findByStatus(status);
	}

	@Override
	public Region findRegionById(Integer id) {
		return serviceManager.regionRepository.findById(id).orElse(null);
	}

	@Override
	public DataContainer deleteRegion(Integer id) {
		DataContainer data = new DataContainer();
	    Optional<Region> regionOptional = serviceManager.regionRepository.findById(id);
	    if (regionOptional.isPresent()) {
	        Region region = regionOptional.get();
	        region.setStatus(GlobalConstants.INACTIVE_STATUS);
	        serviceManager.regionRepository.save(region);
	        data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
	        return data;
	    }
	    data.setMsg(GlobalConstants.ERROR_MESSAGE);
	    return data;
	}

	@Override
	public DataContainer updateRegion(RegionDTO regionDto) {
		
		DataContainer data = new DataContainer();
		Optional<Region> region = serviceManager.regionRepository.findById(regionDto.getId());
		
		if(region.isPresent()) {
			Region regionObj = region.get();
			regionObj.setRegionName(regionDto.getRegionName());
			regionObj.setStatus(GlobalConstants.ACTIVE_STATUS);
			serviceManager.regionRepository.save(regionObj);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			
		}else {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
		}
		
		return data;
	}

	

	@Override
	public DataContainer listOfAllRegions() {
		DataContainer data = new DataContainer();
		
		List<Region> allRegions=serviceManager.regionRepository.findByStatusOrderByIdDesc(GlobalConstants.ACTIVE_STATUS);
		if(!allRegions.isEmpty()) {
			 List<RegionDTO> regionDtoList = allRegions.stream()
		                .map(region -> serviceManager.modelMapper.map(region, RegionDTO.class))
		                .collect(Collectors.toList());

		        data.setData(regionDtoList);
		        data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		}else {
		data.setData(allRegions);
        data.setMsg(GlobalConstants.DATA_NOT_FOUND);
		}
		return data;
	}

	@Override
	public DataContainer addRegion(@Valid RegionDTO regionDto) {
		DataContainer data = new DataContainer();
		Optional<Region> region = serviceManager.regionRepository
				.findByRegionNameAndStatus(regionDto.getRegionName(), GlobalConstants.ACTIVE_STATUS);
		if (!region.isPresent()) {
			
			Region regionObj = serviceManager.modelMapper.map(regionDto, Region.class);
			
			regionObj.setStatus(GlobalConstants.ACTIVE_STATUS);
			serviceManager.regionRepository.save(regionObj);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} else {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
		}
		return data;
		
	}

	
	


	

}
