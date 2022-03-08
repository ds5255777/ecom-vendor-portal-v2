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

	/* Find all records
	 * @Query(value =
	 * "select t.id, t.trip_id, t.route, t.run_type, t.run_status, t.status, t.actual_departure, t.actual_km, t.origin_hub, t.dest_hub, t.payment_status from trip_details as t"
	 * , nativeQuery = true) List<TripDetails> getAllTrips();
	 */

//	@Query(value = "select  * from Trip_Details as e WHERE e.trip_id IN (:tripID)", nativeQuery = true)
//	List<TripDetails> getSelectLineItem(@Param("tripID") List<String> tripID);
	
	List<TripDetails> findByTripIDIn(List<TripDetails> trip);

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
	
	@Query(value = "select * from Trip_Details where run_status='In-Transit' and ", nativeQuery = true)
	List<TripDetails> getAllClosedAndApproved();

	@Query(value = "select * from trip_details where run_type='Adhoc' and vendor_trip_status='Pending'", nativeQuery = true)
	List<TripDetails> getAllPendingTrip();

	@Transactional
	@Modifying
	@Query(value = "update Trip_Details set vendor_trip_status=:status where trip_id=:tripID ; ", nativeQuery = true)
	void updateVendorTripStatusByTripId(@Param("status") String status, @Param("tripID") String tripID);

	@Query(value = "select  * from Trip_Details where trip_id=:tripID ; ", nativeQuery = true)
	List<TripDetails> getTripIdbyTripDetail(@Param("tripID") String tripID);

	TripDetails findByTripID(String tripID);
	
	//List<TripDetails> findByBetweenActualArrivalDate(String startDate, String EndDate);
//
//	@Query(value = "SELECT * FROM trip_details WHERE actual_arrival BETWEEN :actualDeparture AND :actualArrival ; ", nativeQuery = true)
//	List<TripDetails> getDateFilterTripsdetails(@Param("actualArrival") String actualArrival,@Param("actualDeparture")String actualDeparture);
	
	List<TripDetails> findByActualDepartureBetween(@Param("startDate") String startDate,@Param("endDate")String endDate);
	
}
