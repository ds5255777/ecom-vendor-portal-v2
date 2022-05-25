package com.main.db.bpaas.repo;

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

    @Query(value = "select count(*) from Trip_Details where vendor_code=?", nativeQuery = true)
    int getTripCount(String vendorCode);

    @Query(value = "select count(*) from Trip_Details where run_status='Closed' and vendor_code=?", nativeQuery = true)
    int getCloseTripCount(String vendorCode);

    @Query(value = "select count(*) from Trip_Details where run_status='In-Transit' and vendor_code=?", nativeQuery = true)
    int getInTransitTripCount(String vendorCode);

    @Query(value = "select count(*) from trip_details where run_type='Adhoc' and vendor_trip_status='Approved' and vendor_code=?", nativeQuery = true)
    int getApproveAdHocTripCount(String vendorCode);

    @Query(value = "select * from Trip_Details where run_status='Closed' and vendor_code=?", nativeQuery = true)
    List<TripDetails> getAllCloseTrip(String vendorCode);

    @Query(value = "select * from Trip_Details where run_status='In-Transit' and vendor_code=?", nativeQuery = true)
    List<TripDetails> getAllInTransitTrip(String vendorCode);

    @Query(value = "select * from trip_details where vendor_trip_status='Yet To Be Approved' and run_status='Closed' and assign_to = 'Vendor' and vendor_code=?", nativeQuery = true)
    List<TripDetails> getAllPendingTrip(String vendorCode);

    @Query(value = "select * from trip_details where vendor_code=?  ORDER by id desc limit ?", nativeQuery = true)
    List<TripDetails> getTopTripRecods(String vendorCode, int limit );

    @Query(value = "select * from trip_details  where invoice_number=:invoiceNumber ; ", nativeQuery = true)
    List<TripDetails> findByTripAgainsInvoiceNumber(String invoiceNumber);

    @Transactional
    @Modifying
    @Query(value = "update Trip_Details set vendor_trip_status=:status where trip_id=:tripID ; ", nativeQuery = true)
    void updateVendorTripStatusByTripId(@Param("status") String status, @Param("tripID") String tripID);
    
    @Transactional
    @Modifying
    @Query(value = "update trip_details set vendor_trip_status=:vendorTripStatus, opening_reading=:openingReading, closing_reading=:closingReading,processed_By=:processedBy, processed_On=:processedOn where trip_id=:tripID ; ", nativeQuery = true)
    void updateVendorTripStatusByTripId(@Param("tripID") String tripID, @Param("vendorTripStatus") String vendorTripStatus, @Param("openingReading") String openingReading, @Param("closingReading") String closingReading, @Param("processedBy") String processedBy, @Param("processedOn") String processedOn);

    @Transactional
    @Modifying
    @Query(value = "update Trip_Details set vendor_trip_status='Approved', invoice_number='',payment_status='' where trip_id=:tripID ; ", nativeQuery = true)
    void updateVendorTripStatus(String tripID);

    @Transactional
    @Modifying
    @Query(value = "update Trip_Details set vendor_trip_status='Approved'  where invoice_number=:invoiceNumber ;", nativeQuery = true)
    void discardDraftInvoice(String invoiceNumber);

    @Transactional
    @Modifying
    @Query(value = "DELETE FROM invoice_generation WHERE ecom_invoice_nunmber=:invoiceNumber ; ", nativeQuery = true)
    void updateVendorTripStatusAgainsInvoice(String invoiceNumber);

    @Transactional
    @Modifying
    @Query(value = "update Trip_Details set vendor_trip_status='Draft-Invoicing', invoice_number=:invoiceNumber where trip_id=:tripID  ; ", nativeQuery = true)
	void findTripDetailAgainTripID(String invoiceNumber, String tripID);
    
    @Transactional
    @Modifying
    @Query(value = "update Trip_Details set vendor_trip_status='Invoicing', invoice_number=:invoiceNumber,payment_status='Pending' where trip_id=:tripID ; ", nativeQuery = true)
    void updateVendorTripStatusAgainsQueryInvoice(String tripID, String invoiceNumber);

    @Query(value = "select  trip_id from Trip_Details WHERE vendor_trip_status = 'Approved' And vendor_code=?; ", nativeQuery = true)
    List<String> getTripId(String vendorCode);

    @Query(value = "select  * from Trip_Details where trip_id=:tripID ; ", nativeQuery = true)
    List<TripDetails> getTripIdbyTripDetail(@Param("tripID") String tripID);

    TripDetails findByTripID(String tripID);

    List<TripDetails> findByActualDepartureBetween(@Param("startDate") String startDate, @Param("endDate") String endDate);

    @Query(value = "select  * from trip_details  where trip_id IN(:tripID)", nativeQuery = true)
    List<TripDetails> findByTripIDIn(@Param("tripID") String[] tripID);

    @Query(value = "select  * from trip_details  where invoice_number=:invoiceNumber ", nativeQuery = true)
    List<TripDetails> getTripStatusIsDraftInvoicing(String invoiceNumber);

    @Query(value = "select * from trip_details where run_status='Closed' and vendor_trip_status='Approved' AND vendor_code=?", nativeQuery = true)
    List<TripDetails> getAllCloseAndApproveTrip(String vendorCode);

    @Transactional
    @Modifying
    @Query(value = "update Trip_Details set vendor_trip_status=:status where trip_id=:tripID ; ", nativeQuery = true)
    void updateVendorInvoiceStatusByTripId(@Param("status") String status, @Param("tripID") String tripID);

    @Transactional
    @Modifying
    @Query(value = "update Trip_Details set vendor_trip_status='Approved' where invoice_number=:ecomInvoiceNumber ; ", nativeQuery = true)
    void updatetripStatusagainsInvoiceNumber(String ecomInvoiceNumber);

    @Transactional
    @Modifying
    @Query(value = "update Trip_Details set vendor_trip_status='Invoicing',payment_status='Pending' where invoice_number=:ecomInvoiceNumber ; ", nativeQuery = true)
    void updateVendorTripStatusAgainsInvoiceNumber(String ecomInvoiceNumber);

    @Query(value = "select count(*) from Trip_Details where run_type = ?", nativeQuery = true)
    int getADHocTripCount(String type);
    
    @Query(value = "SELECT * FROM trip_details where vendor_trip_status=:ApprovalStatus and assign_to = 'Vendor' and  run_type='Adhoc'; ", nativeQuery = true)
    List<TripDetails> findAllTripsByStatus(@Param("ApprovalStatus") String ApprovalStatus);

    @Query(value = "SELECT * FROM trip_details where vendor_trip_status = 'Yet To Be Approved By Network Team' and assign_to = 'Network' and run_type='Adhoc' and run_status = 'Closed'; ", nativeQuery = true)
    List<TripDetails> findAllTripsWhoseStatusIsNull();

    @Query(value = "select count(*) from Trip_Details where run_status=:runStatus and run_type= :runtype", nativeQuery = true)
    int getInTransitTripCountByRunTypeAndRunStatus(@Param("runtype") String runtype, @Param("runStatus") String runStatus);

    @Query(value = "select * from Trip_Details where run_status=:runStatus and run_type= :runtype", nativeQuery = true)
    List<TripDetails> getInTransitTripByRunTypeAndRunStatus(@Param("runtype") String runtype, @Param("runStatus") String runStatus);

    @Query(value = "SELECT * FROM trip_details where trip_id =:tripID ; ", nativeQuery = true)
    List<TripDetails> findTripsByID(@Param("tripID") String tripID);

    @Query(value = "select * from Trip_Details where vendor_trip_status= ?", nativeQuery = true)
    List<TripDetails> getQueryTripsForNetwork(String vendor_trip_status);

    @Transactional
    @Modifying
    @Query(value = "update Trip_Details set "
            + "processed_By=:processed_By,processed_On=:processed_On,"
            + "lumpSome_CheckBox=:LumpSomeCheckBox,lumpSome_Amount=:LumpSomeAmount,"
            + "current_fuel_rate=:currentFuelRate,fs_base_rate=:fsBaseRate,"
            + "mileage=:milage,rate_per_km=:ratePerKm,"
            + "route_kms=:routeKms,"
            + "standard_km=:standardKM,"
            + "fs_diff=:fs_diff,basic_freight=:basicFreight,total_freight=:totalFreight,fs=:fs ,vendor_name=:vendorName  where trip_id=:tripID ;", nativeQuery = true)
    public void updateDetailsByNetworkInQuery(
            @Param("tripID") String tripID,
            @Param("processed_By") String processed_By,
            @Param("processed_On") String processed_On,
            @Param("LumpSomeCheckBox") String LumpSomeCheckBox,
            @Param("LumpSomeAmount") String LumpSomeAmount,
            @Param("standardKM") double standardKM,
            @Param("milage") double milage,
            @Param("ratePerKm") double ratePerKm,
            @Param("routeKms") double routeKms,
            @Param("fsBaseRate") double fsBaseRate,
            @Param("currentFuelRate") double currentFuelRate,
            @Param("fs_diff") double fs_diff,
            @Param("basicFreight") double basicFreight,
            @Param("totalFreight") double totalFreight, @Param("vendorName") String vendorName);
			
    
	  @Transactional
	    @Modifying
	    @Query(value = "update Trip_Details set vendor_trip_status=:vendor_tripStatus,assign_to=:assignto ,processed_By=:processed_By,processed_On=:processed_On,lumpSome_CheckBox=:LumpSomeCheckBox,lumpSome_Amount=:LumpSomeAmount,basic_freight=:basicFreight,total_freight=:totalFreight,fs=:fs ,vendor_name=:vendorName where trip_id=:tripID ;", nativeQuery = true)
	    public void updateDetailsByNetwork(
	            @Param("assignto") String assignto,
	            @Param("tripID") String tripID,
	            @Param("processed_By") String processed_By,
	            @Param("processed_On") String processed_On,
	            @Param("LumpSomeCheckBox") String LumpSomeCheckBox,
	            @Param("LumpSomeAmount") String LumpSomeAmount,
	            @Param("vendor_tripStatus") String vendor_tripStatus,
	            @Param("basicFreight") double basicFreight,
	            @Param("totalFreight") double totalFreight,
	            @Param("fs") double fs, @Param("vendorName") String vendorName);//fs


    @Query(value = "select * from  Trip_Details where 1=1 and run_status=:runStatus and vendor_code=:vendorCode", nativeQuery = true)
    List<TripDetails> getTripsByFiltersVendorRunStatus(@Param("runStatus") String runStatus, @Param("vendorCode") String vendorCode);

    @Query(value = "select * from Trip_Details where 1=1 and vendor_trip_status=:vendorTripStatus and run_status=:runStatus and vendor_code=:vendorCode", nativeQuery = true)
    List<TripDetails> getTripsByFiltersRunStatus_VendorTripStatus(@Param("runStatus") String runStatus, @Param("vendorTripStatus") String vendorTripStatus, @Param("vendorCode") String vendorCode);

    @Query(value = "select * from Trip_Details where 1=1 and run_status=:runStatus and vendor_trip_status=:vendorTripStatus and  payment_status=:paymentStatus and vendor_code=:vendorCode", nativeQuery = true)
    List<TripDetails> getTripsByFiltersRunStatus_VEndorTripStatus_paymentStatus( @Param("runStatus") String runStatus, @Param("vendorTripStatus") String vendorTripStatus, @Param("paymentStatus") String paymentStatus, @Param("vendorCode") String vendorCode);

    @Query(value = "select * from  Trip_Details where 1=1 and run_status=:runStatus", nativeQuery = true)
    List<TripDetails> getTripsByFiltersVendorRunStatus(@Param("runStatus") String runStatus);

    @Query(value = "select * from Trip_Details where 1=1 and vendor_trip_status=:vendorTripStatus and run_status=:runStatus", nativeQuery = true)
    List<TripDetails> getTripsByFiltersRunStatus_VendorTripStatus(@Param("runStatus") String runStatus, @Param("vendorTripStatus") String vendorTripStatus);

    @Query(value = "select * from Trip_Details where 1=1 and run_status=:runStatus and vendor_trip_status=:vendorTripStatus and  payment_status=:paymentStatus ", nativeQuery = true)
    List<TripDetails> getTripsByFiltersRunStatus_VEndorTripStatus_paymentStatus( @Param("runStatus") String runStatus, @Param("vendorTripStatus") String vendorTripStatus, @Param("paymentStatus") String paymentStatus);
    
    @Query(value = "select * from Trip_Details where vendor_code=? ", nativeQuery = true)
    List<TripDetails> getAllTripByVendorCode(String vendorCode);

	@Query(value = "SELECT * FROM trip_details where vendor_trip_status = 'Yet To Be Approved By Network Team' and assign_to = 'Network' and run_type='Adhoc' and run_status = 'Closed' order by id limit 50; ", nativeQuery = true)
	List<TripDetails> findAllTripsLimitFifty();

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
	
	@Query(value = "select * from trip_details where vendor_trip_status='Yet To Be Approved' and assign_to = 'Vendor'", nativeQuery = true)
	List<TripDetails> getAllPendingTrip();

	List<TripDetails> findByVendorCodeAndActualDepartureBetween(String vendorCode,String fromDate, String toDate);
	
	@Query(value = "select DISTINCT vendor_name from trip_details order by vendor_name asc ",nativeQuery = true)
	List<String> getVendorName();

}
