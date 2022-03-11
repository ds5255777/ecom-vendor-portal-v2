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

}
