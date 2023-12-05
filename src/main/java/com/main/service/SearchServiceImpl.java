package com.main.service;

import java.awt.SystemColor;
import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.bean.DataContainer;
import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.CommentHistory;
import com.main.db.bpaas.entity.SendEmailToVendor;
import com.main.db.bpaas.entity.Verifier;
import com.main.payloads.CommentHistoryDTO;
import com.main.payloads.SendEmailToVendorDTO;
import com.main.payloads.VerifierDTO;
import com.main.servicemanager.ServiceManager;
import java.time.format.DateTimeFormatter;

import org.slf4j.LoggerFactory;

@Service
public class SearchServiceImpl implements SearchService {

	@Autowired
	private ServiceManager serviceManager;

	@PersistenceContext
	private EntityManager entityManager; // Injected EntityManager

	@Autowired
	private ModelMapper modelMapper;

	static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
	private static Logger logger = LoggerFactory.getLogger(SearchServiceImpl.class);

	/*
	 * @Override public DataContainer searchVendors(List<String> vendorTypes,
	 * List<String> regions, List<String> creditTerms, String verifierName, String
	 * status) { DataContainer data = new DataContainer(); try {
	 * 
	 * if("".equals(verifierName)) { verifierName = null ; }
	 * 
	 * List<SendEmailToVendor> filteredVendors =
	 * serviceManager.sendEmailToVendorRepo
	 * .findByVendorTypeInOrRegionInOrCreditTermsInOrVerifierNameOrStatusOrderByIdDesc
	 * (vendorTypes, regions, creditTerms, verifierName, status); if
	 * (!filteredVendors.isEmpty()) { List<SendEmailToVendorDTO> vendorDtoList =
	 * filteredVendors.stream() .map(vendor -> modelMapper.map(vendor,
	 * SendEmailToVendorDTO.class)) .collect(Collectors.toList());
	 * 
	 * data.setData(vendorDtoList); data.setMsg(GlobalConstants.SUCCESS_MESSAGE); }
	 * else { data.setMsg(GlobalConstants.DATA_NOT_FOUND); } } catch (Exception e) {
	 * e.printStackTrace(); data.setMsg(GlobalConstants.ERROR_MESSAGE);
	 * logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e); }
	 * 
	 * return data; }
	 */

	public DataContainer searchVendors(List<String> vendorTypes, List<String> regions, List<String> creditTerms,
			String verifierName, String status , Principal pri) {
		DataContainer data = new DataContainer();

		try {
			CriteriaBuilder cb = entityManager.getCriteriaBuilder();
				CriteriaQuery<SendEmailToVendor> query = cb.createQuery(SendEmailToVendor.class);
				Root<SendEmailToVendor> root = query.from(SendEmailToVendor.class);
				List<Predicate> predicates = new ArrayList<>();
				if (vendorTypes != null && !vendorTypes.isEmpty()) {
					predicates.add(root.get("vendorType").in(vendorTypes));
				}
				if (regions != null && !regions.isEmpty()) {
					predicates.add(root.get("region").in(regions));
				}
				if (creditTerms != null && !creditTerms.isEmpty()) {
					predicates.add(root.get("creditTerms").in(creditTerms));
				}
				if (verifierName != null && !verifierName.isEmpty()) {
					predicates.add(cb.equal(root.get("verifierName"), "%" + verifierName + "%"));
				}
				if (status != null && !status.isEmpty()) {
					predicates.add(cb.equal(root.get("status"), status));
				}
				if(null!= pri.getName()) {
					predicates.add(cb.equal(root.get("assignAt"), pri.getName()));
				}
				query.where(predicates.toArray(new Predicate[0]));

			query.orderBy(cb.desc(root.get("id")));

			List<SendEmailToVendor> filteredVendors = entityManager.createQuery(query).getResultList();
			if (!filteredVendors.isEmpty()) {
				List<SendEmailToVendorDTO> vendorDtoList = filteredVendors.stream()
						.map(vendor -> modelMapper.map(vendor, SendEmailToVendorDTO.class))
						.collect(Collectors.toList());
				data.setData(vendorDtoList);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
				System.out.println(filteredVendors.size());
			} else {
				data.setMsg(GlobalConstants.DATA_NOT_FOUND);
			}
		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return data;
	}

	@Override
	public DataContainer listOfAllVendors(Principal principal) {
		DataContainer data = new DataContainer();
		String username = principal.getName();

		try {
			List<String> statusOfVendor = new ArrayList<>();
			statusOfVendor.add(GlobalConstants.APPROVE_BY_COMMERCIAL_HEAD);
			statusOfVendor.add(GlobalConstants.PENDING_AT_DOC_CHECKER);
			statusOfVendor.add(GlobalConstants.PENDING_AT_EHS_VERIFICATION_AT_AM_DM);
			statusOfVendor.add(GlobalConstants.PENDING_AT_SERNIOR_MANAGER);
			statusOfVendor.add(GlobalConstants.REJECTED_BY_SENIOR_MANAGER);
			statusOfVendor.add(GlobalConstants.REJECTED_BY_AM_DM);
			statusOfVendor.add(GlobalConstants.APPROVE_BY_VERIFIER);
			statusOfVendor.add(GlobalConstants.REJECTED_BY_VERIFIER);
			statusOfVendor.add(GlobalConstants.PENDING_AT_VERIFIER);
			statusOfVendor.add(GlobalConstants.PENDING_FOR_COMMERCIAL_TEAM_STATUS);
			statusOfVendor.add(GlobalConstants.RAISE_QUERY);
			statusOfVendor.add(GlobalConstants.STATUS);
			statusOfVendor.add(GlobalConstants.REJECT);
			System.out.println("username " + username);

			List<SendEmailToVendor> filteredVendors = serviceManager.sendEmailToVendorRepo
					.findByStatusInAndAssignAtOrderByIdDesc(statusOfVendor,username);

			/*
			 * List<SendEmailToVendor> filteredVendors =serviceManager.sendEmailToVendorRepo
			 * .findByProcessByAndStatusInOrderByIdDesc(username,statusOfVendor);
			 */

			if (!filteredVendors.isEmpty()) {
				List<SendEmailToVendorDTO> vendorDtoList = filteredVendors.stream()
						.map(vendor -> modelMapper.map(vendor, SendEmailToVendorDTO.class))
						.collect(Collectors.toList());

				data.setData(vendorDtoList);
				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setMsg(GlobalConstants.DATA_NOT_FOUND);
			}
		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return data;
	}

	@Override
	public DataContainer getCommentDetails(String vendorPid) {
		DataContainer data = new DataContainer();
		try {

			List<CommentHistory> commentHistoryList = serviceManager.commentHistoryRepo
					.findByVendorPidOrderByIdDesc(vendorPid);
			List<CommentHistoryDTO> CommentHistoryDtoList = new ArrayList<>();
			if (!commentHistoryList.isEmpty()) {
				for (CommentHistory commentHistoryObj : commentHistoryList) {
					CommentHistoryDTO commentHistoryDTObj = modelMapper.map(commentHistoryObj, CommentHistoryDTO.class);
					CommentHistoryDtoList.add(commentHistoryDTObj);
				}
				data.setData(CommentHistoryDtoList);

				data.setMsg(GlobalConstants.SUCCESS_MESSAGE);
			} else {
				data.setMsg(GlobalConstants.DATA_NOT_FOUND);
			}
		} catch (Exception e) {
			e.printStackTrace();
			data.setMsg(GlobalConstants.ERROR_MESSAGE);
			logger.error(GlobalConstants.ERROR_MESSAGE + " {}", e);
		}

		return data;
	}

}
