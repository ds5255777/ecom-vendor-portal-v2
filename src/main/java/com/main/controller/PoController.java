package com.main.controller;

import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.bean.PoAndLineItem;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.PoDetails;
import com.main.db.bpaas.entity.PoInvoiceDetails;
import com.main.db.bpaas.entity.PoLineDetails;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.payloads.PoDetailsDTO;
import com.main.payloads.PoInvoiceDetailsDTO;
import com.main.payloads.PoInvoiceLineDTO;
import com.main.payloads.QueryEntityDTO;
import com.main.servicemanager.ServiceManager;

@RequestMapping("/poController")
@RestController
public class PoController {

	@Autowired
	private ServiceManager serviceManager;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(PoController.class);

	@PostMapping({ "/getAllPODetails" })
	public String getActiveMasterData(HttpServletRequest request, Principal principal) {

		logger.info("Log Some Information getActiveMasterData ");
		String vendorCode = principal.getName();
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			List<PoDetails> allPoDetails = serviceManager.podetailsRepo.findByVendorCode(vendorCode);

			data.setData(allPoDetails);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/poDetailsByPoNo" })
	public String poDetailsByPoNo(HttpServletRequest request, @RequestBody PoDetailsDTO detailsDto) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			PoDetails details = serviceManager.podetailsRepo.findByPoNo(detailsDto.getPoNo());

			data.setData(this.serviceManager.modelMapper.map(details, PoDetailsDTO.class));
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllProcessPo" })
	public String getAllProcessPo(HttpServletRequest request, Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			String vendorCode = principal.getName();
			List<PoDetails> details = serviceManager.podetailsRepo.getAllProcessPo(vendorCode);
			List<PoDetailsDTO> detailsDto = details.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, PoDetailsDTO.class))
					.collect(Collectors.toList());
			data.setData(detailsDto);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllUnProcessPo" })
	public String getAllUnProcessPo(HttpServletRequest request, Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			String vendorCode = principal.getName();
			List<PoDetails> details = serviceManager.podetailsRepo.getAllUnProcessPo(vendorCode);
			List<PoDetailsDTO> detailsDto = details.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, PoDetailsDTO.class))
					.collect(Collectors.toList());
			data.setData(detailsDto);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllInvoiceDetails" })
	public String getAllInvoiceDetails(HttpServletRequest request, Principal principal) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			String vendorCode = principal.getName();

			if (vendorCode.equals("finance1")) {
				List<PoInvoiceDetails> details = serviceManager.poinvoiceRepo.getAllInvoiceDetailsForFinance();

				List<PoInvoiceDetailsDTO> detailsDto = details.stream()
						.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, PoInvoiceDetailsDTO.class))
						.collect(Collectors.toList());
				data.setData(detailsDto);

			} else {
				List<PoInvoiceDetails> details = serviceManager.poinvoiceRepo.getAllInvoiceDetails(vendorCode);
				List<PoInvoiceDetailsDTO> detailsDto = details.stream()
						.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, PoInvoiceDetailsDTO.class))
						.collect(Collectors.toList());
				data.setData(detailsDto);
			}

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getSelectInvoiceDetailsPo" })
	public String getSelectInvoiceDetailsPo(HttpServletRequest request, Principal principal,
			@RequestBody PoInvoiceDetailsDTO detailsDto) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			String vendorCode = principal.getName();

			if (vendorCode.equals("finance1")) {
				List<PoInvoiceDetails> poInvoiceDetails = serviceManager.poinvoiceRepo
						.findByInvoiceNumberByFinance(detailsDto.getInvoiceNumber());

				List<PoInvoiceDetailsDTO> poInvoiceDetailsDto = poInvoiceDetails.stream()
						.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, PoInvoiceDetailsDTO.class))
						.collect(Collectors.toList());
				data.setData(poInvoiceDetailsDto);
			} else {
				List<PoInvoiceDetails> poInvoiceDetails = serviceManager.poinvoiceRepo.findByInvoiceNumber(vendorCode,
						detailsDto.getInvoiceNumber());
				List<PoInvoiceDetailsDTO> poInvoiceDetailsDto = poInvoiceDetails.stream()
						.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, PoInvoiceDetailsDTO.class))
						.collect(Collectors.toList());
				data.setData(poInvoiceDetailsDto);
			}
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllPODetailsByPoNo" })
	public String getAllPODetailsByPoNo(HttpServletRequest request, Principal principal,
			@RequestBody PoDetailsDTO detailsDto) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			String vendorCode = principal.getName();

			List<PoDetails> poInvoiceDetails = serviceManager.podetailsRepo.getPoDetailsByPoNo(detailsDto.getPoNo(),
					vendorCode);

			List<PoDetailsDTO> detailsDtoFromEntity = poInvoiceDetails.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, PoDetailsDTO.class))
					.collect(Collectors.toList());
			data.setData(detailsDtoFromEntity);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getAllPODetailsByLineNumber" })
	public String getAllPODetailsByLineNumber(HttpServletRequest request, @RequestBody PoInvoiceLineDTO detailsDto) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			List<PoLineDetails> poInvoiceDetails = serviceManager.poLineItemRepo
					.getDataByLineNumber(detailsDto.getPoLineId());
			List<PoInvoiceLineDTO> poInvoiceDetailsDto = poInvoiceDetails.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, PoInvoiceLineDTO.class))
					.collect(Collectors.toList());
			data.setData(poInvoiceDetailsDto.get(0));
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/savePoInvoiceQuery" })
	public String savePoInvoiceQuery(HttpServletRequest request, Principal principal,
			@RequestBody QueryEntityDTO detailsDto) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			String raisedBy = principal.getName();

			detailsDto.setRaisedBy(raisedBy);
			detailsDto.setRaisedOn(new Date());

			serviceManager.queryRepo.save(this.serviceManager.modelMapper.map(detailsDto, QueryEntity.class));

			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getPoQueryData" })
	public String getPoQueryData(HttpServletRequest request, Principal principal,
			@RequestBody QueryEntityDTO detailsDto) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			String raisedBy = principal.getName();
			detailsDto.setRaisedBy(raisedBy);
			List<QueryEntity> getPoQueryData = serviceManager.queryRepo
					.findCommentsByRefIDPo(detailsDto.getReferenceid(), detailsDto.getRaisedBy());

			List<QueryEntityDTO> getPoQueryDataDto = getPoQueryData.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, QueryEntityDTO.class))
					.collect(Collectors.toList());
			data.setData(getPoQueryDataDto);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@GetMapping({ "filterPoDetails" })
	public String filterPoDetails(Principal principal, HttpServletRequest request,
			@RequestParam(name = "actualDeparture") Date fromDate, @RequestParam(name = "actualArrival") Date toDate) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		String vendorCode = principal.getName();
		try {

			List<PoDetails> getListByDateFilter = serviceManager.podetailsRepo.findByActualDepartureBetween(fromDate,
					toDate, vendorCode);
			List<PoDetailsDTO> getListByDateFilterDto = getListByDateFilter.stream()
					.map(listOfUser -> this.serviceManager.modelMapper.map(listOfUser, PoDetailsDTO.class))
					.collect(Collectors.toList());
			data.setData(getListByDateFilterDto);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}
		return gson.toJson(data);
	}

	@PostMapping({ "/updateRemaningQuantity" })
	public String updateRemaningQuantity(HttpServletRequest request, Principal principal,
			@RequestBody PoAndLineItem details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {
			String processBy = principal.getName();
			Date proceessOn = new Date();

			serviceManager.podetailsRepo.updateRemaningQuatity(details.getRemaningQuatity(), details.getId());

			Integer flag = details.getFlag();
			if (flag == 1) {
				serviceManager.podetailsRepo.updateVendorPoStatusAgainsInvoiceNumber(details.getPoNumber(), proceessOn,
						processBy);
			} else {
				serviceManager.podetailsRepo.updateVendorPoStatusUnprocess(details.getPoNumber(), proceessOn,
						processBy);
			}


		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/updateRemaningQuantitydraft" })
	public String updateRemaningQuantitydraft(HttpServletRequest request, Principal principal,
			@RequestBody PoAndLineItem details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			serviceManager.podetailsRepo.updateRemaningQuatity(details.getRemaningQuatity(), details.getId());
			String processBy = principal.getName();
			Date proceessOn = new Date();

			Integer flag = details.getFlag();
			if (flag == 1) {
				serviceManager.podetailsRepo.updateVendorPoStatusAgainsInvoiceNumber(details.getPoNumber(), proceessOn,
						processBy);
			} else {
				serviceManager.podetailsRepo.updateVendorPoStatusUnprocess(details.getPoNumber(), proceessOn,
						processBy);
			}

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);

			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

	@PostMapping({ "/getCurrentRemaningQty" })
	public String getCurrentRemaningQty(HttpServletRequest request, @RequestBody PoAndLineItem details) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();
		try {

			String getRemaningQuatity = serviceManager.podetailsRepo.getCurrentRemaningQty(details.getPoLineId());
			if (getRemaningQuatity == null) {

				getRemaningQuatity = serviceManager.podetailsRepo.getCurrentQty(details.getPoLineId());
			}
			data.setData(getRemaningQuatity);
			data.setMsg(GlobalConstants.SUCCESS_MESSAGE);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);

		}

		return gson.toJson(data);
	}

}
