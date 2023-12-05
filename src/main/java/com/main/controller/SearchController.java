package com.main.controller;

import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.Document;
import com.main.payloads.DocumentDto;
import com.main.payloads.RespdocumentDTO;
import com.main.service.SearchService;
import com.main.servicemanager.ServiceManager;

@RestController
@RequestMapping("/searchController")
public class SearchController {

	@Autowired
	private ServiceManager serviceManager;

	@Autowired
	private SearchService searchService;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(VerifierController.class);

	@GetMapping("/searchVendors")
	public String searchVendors(@RequestParam(value = "vendorTypes") List<String> vendorTypes,
			@RequestParam(value = "regions") List<String> regions,
			@RequestParam(value = "creditTerms") List<String> creditTerms,
			@RequestParam(value = "verifierName") String verifierName, @RequestParam(value = "status") String status,Principal pri) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			DataContainer searchVendors = searchService.searchVendors(vendorTypes, regions, creditTerms, verifierName,
					status,pri);
			data.setData(searchVendors);

		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@GetMapping("/listOfAllVendors")
	public String listOfAllVendors(Principal principal) {
		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			data = searchService.listOfAllVendors(principal);

		} catch (Exception e) {
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@GetMapping("/getCommentDetails")
	public String getCommentDetails(@RequestParam(value = "vendorPid") String vendorPid) {

		DataContainer data = new DataContainer();
		Gson gson = new GsonBuilder().setDateFormat(GlobalConstants.DATE_FORMATTER).create();

		try {
			data = searchService.getCommentDetails(vendorPid);

		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return gson.toJson(data);
	}

	@PostMapping("/getDocumentById")
	public String getDocumentById(@RequestBody DocumentDto doc) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {

			Document document = serviceManager.modelMapper.map(doc, Document.class);
			// List<Document> respdocument;
			if (document.getType().contains(",")) {
				// RespdocumentDTO respdocumentDTO =new RespdocumentDTO();
				List<RespdocumentDTO> typeList = new ArrayList<>();
				String[] typeArray = document.getType().split(",");
				String type = "";
//				String typeDuplicate = "";
//				String setDocName = "";
//				String docPath = "";
				List<String> doctypeList = Arrays.asList(typeArray);
				List<Object[]> respdocument = serviceManager.documentRepo
						.getAllTypeDetailsList(document.getForeignKey(), doctypeList, GlobalConstants.ACTIVE_STATUS);
				for (Object[] object : respdocument) {
					RespdocumentDTO respdocumentDTO = new RespdocumentDTO();
					type = (object[0].toString());
					respdocumentDTO.setType(type);
//					if (!typeDuplicate.equals(type)) {
//						respdocumentDTO.setType(type);
//						typeDuplicate = type;
//					}
//					else
//					{
//						respdocumentDTO.setType("");
//					}
//					setDocName = (object[1].toString());
//					docPath = (object[2].toString());
//					respdocumentDTO.setDocName(setDocName);
//					respdocumentDTO.setDocPath(docPath);
					typeList.add(respdocumentDTO);
				}

//			}
//			else {
//
//				respdocument = serviceManager.documentRepo.findDistinctTypeByForeignKeyAndType(document.getForeignKey(),
//						document.getType());
//
//			}

				data.setMsg("success");
				data.setData(typeList);
			}

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
			logger.error("Error occured in getDocumentById  {}", e.toString());
		}
		return gson.toJson(data);
	}

	@PostMapping("/getDocumentTypeById")
	public String getDocumentTypeById(@RequestBody DocumentDto doc) {
		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			Document document = serviceManager.modelMapper.map(doc, Document.class);
			String[] typeArray = document.getType().split(",");
			List<String> doctypeList = Arrays.asList(typeArray);
			List<DocumentDto> documentDtoList = new ArrayList<>();
			List<Document> typeList = serviceManager.documentRepo.findByTypeInAndForeignKey(doctypeList,
					document.getForeignKey());
			for (Document docNameAndPath : typeList) {
				DocumentDto Docbj = new DocumentDto();
				Docbj.setDocName(docNameAndPath.getDocName());
				Docbj.setDocPath(docNameAndPath.getDocPath());
				documentDtoList.add(Docbj);

			}
			data.setData(documentDtoList);
			data.setMsg("success");
		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
			logger.error("Error occurred in getDocumentTypeById: {}", e.toString());
		}

		return gson.toJson(data);
	}
}
