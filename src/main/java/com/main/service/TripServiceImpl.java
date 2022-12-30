package com.main.service;

import com.main.commonclasses.GlobalConstants;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.repo.TripDetailsRepo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TripServiceImpl implements TripService {

	@Autowired
	private TripDetailsRepo tripDetailsRepo;

	@Override
	public void save(TripDetails details) {
		tripDetailsRepo.save(details);
	}

	@Override
	public List<TripDetails> findAllTripsByStatus(String status) {

		if ("".equalsIgnoreCase(status)) {
			return tripDetailsRepo.findAllTripsWhoseStatusIsNull();
		} else {
			return tripDetailsRepo.findAllTripsByStatus(status);
		}

	}

	@Override
	public int getInTransitTripCountByRunTypeAndRunStatus(String runtype, String runStatus) {
		return tripDetailsRepo.getInTransitTripCountByRunTypeAndRunStatus(runtype, runStatus);
	}

	@Override
	public List<TripDetails> getInTransitTripByRunTypeAndRunStatus(String runtype, String runStatus) {
		return tripDetailsRepo.getInTransitTripByRunTypeAndRunStatus(runtype, runStatus);
	}

	@Override
	public List<TripDetails> getTripsByFilters(String runStatus, String vendorTripStatus, String paymentStatus,
			String vendorCode) {

		if ("".equalsIgnoreCase(vendorTripStatus) && "".equalsIgnoreCase(paymentStatus)
				&& !"".equalsIgnoreCase(vendorCode)) {

			List<String> runStatusList = new ArrayList<>();

			if (runStatus.equalsIgnoreCase(GlobalConstants.RUN_IN_TRANSIT)) {

				runStatusList.add("CLOSED");
				runStatusList.add("Closed");
				runStatusList.add("closed");
				runStatusList.add("CANCELLED");
				runStatusList.add("cancelled");
				runStatusList.add("Cancelled");

				return tripDetailsRepo.findByVendorCodeAndRunStatusNotInOrderByIdDesc(vendorCode, runStatusList);

			} else if (runStatus.equalsIgnoreCase(GlobalConstants.RUN_CLOSED)) {

				return tripDetailsRepo.findByRunStatusIgnoreCaseAndVendorCodeOrderByIdDesc(runStatus, vendorCode);

			}

			// tripDetailsRepo.findbyVendorCodeAndRunStatusIgnoreCase(vendorCode,runStatus);
			return tripDetailsRepo.getTripsByFiltersVendorRunStatus(runStatus, vendorCode);
		}
		if (!"".equalsIgnoreCase(runStatus) && !"".equalsIgnoreCase(vendorTripStatus)
				&& "".equalsIgnoreCase(paymentStatus) && !"".equalsIgnoreCase(vendorCode)) {
			return tripDetailsRepo.getTripsByFiltersRunStatusVendorTripStatus(runStatus, vendorTripStatus, vendorCode);
		}
		if (!"".equalsIgnoreCase(runStatus) && !"".equalsIgnoreCase(vendorTripStatus)
				&& !"".equalsIgnoreCase(paymentStatus) && !"".equalsIgnoreCase(vendorCode)) {
			return tripDetailsRepo.getTripsByFiltersRunStatusVendorTripStatuspaymentStatus(runStatus, vendorTripStatus,
					paymentStatus, vendorCode);
		}
		return Collections.emptyList();
	}

	@Override
	public List<TripDetails> findAllTripsLimitFifty() {
		return tripDetailsRepo.findAllTripsLimitFifty();
	}

	@Override
	public List<TripDetails> getTripsByFiltersNetwork(String runStatus, String vendorTripStatus, String paymentStatus) {

		if (!"".equalsIgnoreCase(runStatus) && "".equalsIgnoreCase(vendorTripStatus)
				&& "".equalsIgnoreCase(paymentStatus)) {
			return tripDetailsRepo.getTripsByFiltersVendorRunStatus(runStatus);
		} else if (!"".equalsIgnoreCase(runStatus) && !"".equalsIgnoreCase(vendorTripStatus)
				&& "".equalsIgnoreCase(paymentStatus)) {
			return tripDetailsRepo.getTripsByFiltersRunStatusVendorTripStatus(runStatus, vendorTripStatus);
		} else {
			return tripDetailsRepo.getTripsByFiltes(runStatus, vendorTripStatus, paymentStatus);
		}
	}

}
