package com.main.service;

import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.repo.TripDetailsRepo;
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

		if ("".equalsIgnoreCase(vendorTripStatus) && "".equalsIgnoreCase(paymentStatus) && !"".equalsIgnoreCase(vendorCode)) {
			return tripDetailsRepo.getTripsByFiltersVendorRunStatus(runStatus, vendorCode);
		}
		if (!"".equalsIgnoreCase(runStatus) && !"".equalsIgnoreCase(vendorTripStatus) && "".equalsIgnoreCase(paymentStatus) && !"".equalsIgnoreCase(vendorCode) ) {
			return tripDetailsRepo.getTripsByFiltersRunStatus_VendorTripStatus(runStatus, vendorTripStatus, vendorCode);
		}
		if (!"".equalsIgnoreCase(runStatus) && !"".equalsIgnoreCase(vendorTripStatus) && !"".equalsIgnoreCase(paymentStatus) && !"".equalsIgnoreCase(vendorCode)) {
			return tripDetailsRepo.getTripsByFiltersRunStatus_VEndorTripStatus_paymentStatus(runStatus,
					vendorTripStatus, paymentStatus, vendorCode);
		}
		return null;
	}

	@Override
	public List<TripDetails> findAllTripsLimitFifty() {
		return tripDetailsRepo.findAllTripsLimitFifty();
	}

	@Override
	public List<TripDetails> getTripsByFiltersNetwork(String runStatus, String vendorTripStatus, String PaymentStatus) {

		try {
			if (!"".equalsIgnoreCase(runStatus) && "".equalsIgnoreCase(vendorTripStatus) && "".equalsIgnoreCase(PaymentStatus)) {
				return tripDetailsRepo.getTripsByFiltersVendorRunStatus(runStatus);
			} else if (!"".equalsIgnoreCase(runStatus) && !"".equalsIgnoreCase(vendorTripStatus) && "".equalsIgnoreCase(PaymentStatus)) {
				return tripDetailsRepo.getTripsByFiltersRunStatus_VendorTripStatus(runStatus, vendorTripStatus);
			} else {
				return tripDetailsRepo.getTripsByFiltersRunStatus_VEndorTripStatus_paymentStatus(runStatus,
						vendorTripStatus, PaymentStatus);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
