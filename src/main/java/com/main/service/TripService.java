package com.main.service;

import org.springframework.stereotype.Service;
import com.main.db.bpaas.entity.TripDetails;
import java.util.List;

@Service
public interface TripService {

	void save(TripDetails details);

	List<TripDetails> findAllTripsByStatus(String status);

	int getInTransitTripCountByRunTypeAndRunStatus(String runtype, String runStatus);

	List<TripDetails> getInTransitTripByRunTypeAndRunStatus(String runtype, String runStatus);

	List<TripDetails> getTripsByFilters(String vendorTripStatus, String runStatus, String paymentStatus, String vendorCode);

	List<TripDetails> getTripsByFiltersNetwork(String vendorTripStatus, String runStatus, String paymentStatus);
	
	List<TripDetails> findAllTripsLimitFifty();

}
