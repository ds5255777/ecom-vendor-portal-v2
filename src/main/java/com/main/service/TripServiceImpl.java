package com.main.service;

import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.repo.TripDetailsRepo;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TripServiceImpl implements TripService {

    @Autowired
    private TripDetailsRepo TripDetailsRepo;

    @Override
    public void save(TripDetails details) {
        TripDetailsRepo.save(details);
    }

    @Override
    public List<TripDetails> findAllTripsByStatus(String status) {

        if ("".equalsIgnoreCase(status)) {
            return TripDetailsRepo.findAllTripsWhoseStatusIsNull();
        } else {
            return TripDetailsRepo.findAllTripsByStatus(status);
        }

    }

    @Override
    public int getInTransitTripCountByRunTypeAndRunStatus(String runtype, String runStatus) {
        return TripDetailsRepo.getInTransitTripCountByRunTypeAndRunStatus(runtype, runStatus);
    }

    @Override
    public List<TripDetails> getInTransitTripByRunTypeAndRunStatus(String runtype, String runStatus) {
        System.out.println("*************getInTransitTripByRunTypeAndRunStatus***************");
        return TripDetailsRepo.getInTransitTripByRunTypeAndRunStatus(runtype, runStatus);
    }

    @Override
    public List<TripDetails> getTripsByFilters(String runStatus, String vendorTripStatus, String PaymentStatus) {
        System.out.println("vendorTripStatus " + vendorTripStatus
                + "\nrunStatus " + runStatus + ""
                + "\nPaymentStatus " + PaymentStatus);

        if ("".equalsIgnoreCase(vendorTripStatus) && "".equalsIgnoreCase(PaymentStatus)) {
            return TripDetailsRepo.getTripsByFiltersVendorRunStatus(runStatus);
        } else if (runStatus!="" && vendorTripStatus!="" && "".equalsIgnoreCase(PaymentStatus)) {
            return TripDetailsRepo.getTripsByFiltersRunStatus_VendorTripStatus(runStatus, vendorTripStatus);
        } else {
            return TripDetailsRepo.getTripsByFiltersRunStatus_VEndorTripStatus_paymentStatus(runStatus, vendorTripStatus, PaymentStatus);
        }

    }

}
