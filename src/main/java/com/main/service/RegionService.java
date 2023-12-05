package com.main.service;

import java.util.List;

import javax.validation.Valid;

import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.Region;
import com.main.payloads.RegionDTO;

public interface RegionService {


	

	List<Region> findByStatus(String status);

	Region findRegionById(Integer id);



	DataContainer deleteRegion(Integer id);

	DataContainer updateRegion(RegionDTO regionDto);

	DataContainer listOfAllRegions();

	DataContainer addRegion(@Valid RegionDTO regionDto);

}
