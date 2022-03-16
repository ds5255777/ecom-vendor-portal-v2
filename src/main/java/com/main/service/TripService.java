/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.main.service;

import org.springframework.stereotype.Service;
import com.main.db.bpaas.entity.TripDetails;
import java.util.List;

@Service
public interface TripService {
  
 void save(TripDetails details);

List<TripDetails> findAllTripsByStatus(String status);


int getInTransitTripCountByRunTypeAndRunStatus(String runtype,String runStatus);

List<TripDetails> getInTransitTripByRunTypeAndRunStatus(String runtype,String runStatus);

List<TripDetails> getTripsByFilters(String vendorTripStatus, String runStatus, String PaymentStatus);
 
  
}
