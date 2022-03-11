package com.main.db.bpaas.repo;

import java.util.Collection;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.main.db.bpaas.entity.TripDetails;

@Repository
public interface TripDetailsRepo extends JpaRepository<TripDetails, Integer> {

	@Query(value = "select * from Trip_Details where trip_id=?", nativeQuery = true)
	List<TripDetails> getTripDetailsById(String id);

	@Query(value = "select * from Trip_Details where payment_status=?", nativeQuery = true)
	List<TripDetails> getPaymentStatus(String status);

	@Query(value = "select * from Trip_Details where run_status=?", nativeQuery = true)
	List<TripDetails> getTripStatus(String status);

	@Query(value = "select * from Trip_Details where run_status=? AND status =?", nativeQuery = true)
	List<TripDetails> getRunAndStatus(String status, String statusOne);

	@Query(value = "select count(*) from Trip_Details", nativeQuery = true)
	int getTripCount();

	@Query(value = "select count(*) from Trip_Details where run_status='Closed'", nativeQuery = true)
	int getCloseTripCount();

	@Query(value = "select count(*) from Trip_Details where run_status='In-Transit'", nativeQuery = true)
	int getInTransitTripCount();

	@Query(value = "select count(*) from trip_details where run_type='Adhoc' and vendor_trip_status='Approved'", nativeQuery = true)
	int getApproveAdHocTripCount();

	@Query(value = "select * from Trip_Details where run_status='Closed'", nativeQuery = true)
	List<TripDetails> getAllCloseTrip();

	@Query(value = "select * from Trip_Details where run_status='In-Transit'", nativeQuery = true)
	List<TripDetails> getAllInTransitTrip();

//	@Query(value = "select * from Trip_Details where run_status='In-Transit' and ", nativeQuery = true)
//	List<TripDetails> getAllClosedAndApproved();

	@Query(value = "select * from trip_details where vendor_trip_status='Yet To Be Approved' and assign_to = 'Vendor'", nativeQuery = true)
	List<TripDetails> getAllPendingTrip();

	@Transactional
	@Modifying
	@Query(value = "update Trip_Details set vendor_trip_status=:status where trip_id=:tripID ; ", nativeQuery = true)
	void updateVendorTripStatusByTripId(@Param("status") String status, @Param("tripID") String tripID);

	@Query(value = "select  * from Trip_Details where trip_id=:tripID ; ", nativeQuery = true)
	List<TripDetails> getTripIdbyTripDetail(@Param("tripID") String tripID);

	TripDetails findByTripID(String tripID);

	List<TripDetails> findByActualDepartureBetween(@Param("startDate") String startDate,@Param("endDate") String endDate);

	@Query(value = "select  * from trip_details  where trip_id IN(:tripID)", nativeQuery = true)
	List<TripDetails> findByTripIDIn(@Param("tripID") String[] tripID);

	@Query(value = "select * from trip_details where run_status='Closed' and vendor_trip_status='Approved'",nativeQuery=true)
	List<TripDetails> getAllCloseAndApproveTrip();

//SAurabh
@Query(value = "select count(*) from Trip_Details where run_type = ?", nativeQuery = true)
    int getADHocTripCount(String type);

 @Query(value = "SELECT id,processed_By,processed_On, actual_arrival, actual_departure, actual_km, actual_vechicle_type, assign_to, basic_freight, closing_reading, current_fuel_rate, dest_hub, fs, fs_base_rate, fs_diff, mileage, mode, opening_reading, origin_hub, origin_region, payment_status, rate_per_km, route, route_kms, run_status, run_type, standard_km, standard_payload_capacity, standard_shipment_capacity, status, total_freight, trip_id, trip_starting_date, vehicle_number, vendor_code, vendor_name, vendor_trip_status, tripdetails_id, actual_shipment, actual_chargeable_weight, approval_status FROM trip_details where vendor_trip_status=:ApprovalStatus ; ", nativeQuery = true)
    List<TripDetails> findAllTripsByStatus(@Param("ApprovalStatus") String ApprovalStatus);

    @Query(value = "SELECT id,processed_By,processed_On, actual_arrival, actual_departure, actual_km, actual_vechicle_type, assign_to, basic_freight, closing_reading, current_fuel_rate, dest_hub, fs, fs_base_rate, fs_diff, mileage, mode, opening_reading, origin_hub, origin_region, payment_status, rate_per_km, route, route_kms, run_status, run_type, standard_km, standard_payload_capacity, standard_shipment_capacity, status, total_freight, trip_id, trip_starting_date, vehicle_number, vendor_code, vendor_name, vendor_trip_status, tripdetails_id, actual_shipment, actual_chargeable_weight, approval_status FROM trip_details where vendor_trip_status = 'Yet To Be Approved' and assign_to = 'Network' and run_type='Adhoc' and run_status = 'Closed'; ", nativeQuery = true)
    List<TripDetails> findAllTripsWhoseStatusIsNull();

    @Query(value = "select count(*) from Trip_Details where run_status=:runStatus and run_type= :runtype", nativeQuery = true)
    int getInTransitTripCountByRunTypeAndRunStatus(@Param("runtype") String runtype,@Param("runStatus") String runStatus);

    @Query(value = "SELECT id,processed_By,processed_On, actual_arrival, actual_departure, actual_km, actual_vechicle_type, assign_to, basic_freight, closing_reading, current_fuel_rate, dest_hub, fs, fs_base_rate, fs_diff, mileage, mode, opening_reading, origin_hub, origin_region, payment_status, rate_per_km, route, route_kms, run_status, run_type, standard_km, standard_payload_capacity, standard_shipment_capacity, status, total_freight, trip_id, trip_starting_date, vehicle_number, vendor_code, vendor_name, vendor_trip_status, tripdetails_id, actual_shipment, actual_chargeable_weight, approval_status FROM trip_details where trip_id =:tripID ; ", nativeQuery = true)
    List<TripDetails> findTripsByID(@Param("tripID") String tripID);


@Transactional
@Modifying
@Query(value = "update Trip_Details set assign_to=:assignto where trip_id=:tripID ; ", nativeQuery = true)
void updateDetailsByNetwork(@Param("assignto") String assignto, @Param("tripID") String tripID);



//END

}
