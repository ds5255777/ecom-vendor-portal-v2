package com.main.controller;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.JdbcConnection;
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.repo.QueryRepo;
import com.main.db.bpaas.repo.TripDetailsRepo;
import com.sun.xml.messaging.saaj.packaging.mime.MessagingException;

@RequestMapping("/tripControllers")
@RestController
public class TripControllers {

    @Autowired
    private TripDetailsRepo tripDetailsRepo;

    @Autowired
    private QueryRepo queryRepo;

    @Autowired
    JdbcConnection dbconnection;

    @RequestMapping({"filterTripDetails"})
    @CrossOrigin("*")
    public String filterTripDetails(@RequestParam(name = "actualDeparture") String fromDate, @RequestParam(name = "actualArrival") String toDate) {

        DataContainer data = new DataContainer();
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        try {
            System.out.println(fromDate);
            System.out.println(toDate);

            List<TripDetails> getListByDateFilter = tripDetailsRepo.findByActualDepartureBetween(fromDate, toDate);
            //List<TripDetails> getListByDateFilter = tripDetailsRepo.findByBetweenActualArrivalDate(fromDate, toDate);
            getListByDateFilter.forEach(w -> {
                System.out.println("all data" + w);
            });

            System.out.println(getListByDateFilter);
            data.setData(getListByDateFilter);
            data.setMsg("success");
        } catch (Exception e) {
            // TODO: handle exception
            data.setMsg("error");
            e.printStackTrace();
        }
        return gson.toJson(data).toString();
    }

    @RequestMapping({"/getAllTripsDetails"})
    @CrossOrigin("*")
    public String getAllTripsDetails(HttpServletRequest request, @RequestBody List<TripDetails> tripList) {

        DataContainer data = new DataContainer();

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        try {
            List<TripDetails> allTripDetailsList = tripDetailsRepo.findAll();

            data.setData(allTripDetailsList);
            data.setMsg("success");

        } catch (Exception e) {
            data.setMsg("error");
            e.printStackTrace();
        }

        return gson.toJson(data).toString();
    }

    @RequestMapping({"/getCloseTripsDetails"})
    @CrossOrigin("*")
    public String getCloseTripsDetails(HttpServletRequest request, @RequestBody List<TripDetails> tripList) {

        DataContainer data = new DataContainer();
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        try {
            List<TripDetails> allTripDetailsList = tripDetailsRepo.getAllCloseTrip();

            data.setData(allTripDetailsList);
            data.setMsg("success");

        } catch (Exception e) {
            data.setMsg("error");
            e.printStackTrace();
        }

        return gson.toJson(data).toString();
    }

    @RequestMapping({"/getCloseAndApprovedTripsDetails"})
    @CrossOrigin("*")
    public String getCloseAndApprovedTripsDetails(HttpServletRequest request, @RequestBody List<TripDetails> tripList) {

        DataContainer data = new DataContainer();
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        try {
            List<TripDetails> allTripDetailsList = tripDetailsRepo.getAllCloseAndApproveTrip();

            data.setData(allTripDetailsList);
            data.setMsg("success");

        } catch (Exception e) {
            data.setMsg("error");
            e.printStackTrace();
        }

        return gson.toJson(data).toString();
    }

    @RequestMapping({"/getInTransitTripsDetails"})
    @CrossOrigin("*")
    public String getInTransitTripsDetails(HttpServletRequest request, @RequestBody List<TripDetails> tripList) {

        DataContainer data = new DataContainer();
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        try {
            List<TripDetails> allTripDetailsList = tripDetailsRepo.getAllInTransitTrip();

            data.setData(allTripDetailsList);
            data.setMsg("success");

        } catch (Exception e) {
            data.setMsg("error");
            e.printStackTrace();
        }

        return gson.toJson(data).toString();
    }

    @RequestMapping({"/getPendingApprovelTripsDetails"})
    @CrossOrigin("*")
    public String getPendingApprovelTripsDetails(HttpServletRequest request, @RequestBody List<TripDetails> tripList) {

        DataContainer data = new DataContainer();
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        try {
            List<TripDetails> allTripDetailsList = tripDetailsRepo.getAllPendingTrip();

            data.setData(allTripDetailsList);
            data.setMsg("success");

        } catch (Exception e) {
            data.setMsg("error");
            e.printStackTrace();
        }

        return gson.toJson(data).toString();
    }

    @RequestMapping({"/updateVendorTripStatusByTripId"})
    @CrossOrigin("*")
    public String getApprovePendingApprovelTripsDetails(HttpServletRequest request, @RequestBody TripDetails tripObj) {

        DataContainer data = new DataContainer();
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        try {

            tripDetailsRepo.updateVendorTripStatusByTripId(tripObj.getVendorTripStatus(), tripObj.getTripID());
            data.setMsg("success");

        } catch (Exception e) {
            data.setMsg("error");
            e.printStackTrace();
        }

        return gson.toJson(data).toString();
    }

    @RequestMapping(value = "/status", method = RequestMethod.POST)
    @CrossOrigin("*")
    public String status(@RequestBody TripDetails obj) throws UnsupportedEncodingException, MessagingException {

        DataContainer data = new DataContainer();
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<TripDetails> TripDetailsList = new ArrayList<TripDetails>();
        TripDetails tripDetail = null;

        try {
            conn = dbconnection.getConnection();
            String sql = "select e.id as id, e.trip_id as tripID, e.route as route, e.run_type as runType, e.vendor_trip_status as vendorTripStatus, "
                    + " e.actual_departure as actualDeparture, e.actual_km as actualKM, e.standard_km as standardKM, e.run_status as runStatus, e.origin_hub as originHub, "
                    + " e.dest_hub as destHub, e.payment_status as paymentStatus "
                    + " from Trip_Details e where  1=1  ";

            System.out.println("Query is :" + sql);
            if (!"".equalsIgnoreCase(obj.getVendorTripStatus())) {
                System.out.println("Vendor Trip Status " + obj.getVendorTripStatus());
                sql += " and vendor_trip_status='" + obj.getVendorTripStatus() + "' ";
                System.out.println(sql);
            }
            if (!"".equalsIgnoreCase(obj.getRunStatus())) {
                System.out.println("getRunStatus " + obj.getRunStatus());
                sql += " and run_status='" + obj.getRunStatus() + "' ";
                System.out.println(sql);
            }
            if (!"".equalsIgnoreCase(obj.getPaymentStatus())) {
                System.out.println("getPaymentStatus " + obj.getPaymentStatus());
                sql += " and payment_status='" + obj.getPaymentStatus() + "' ";
                System.out.println(sql);
            }
            System.out.println("after query" + sql);



            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                tripDetail = new TripDetails();
                tripDetail.setId(Integer.parseInt(rs.getString("id")));
                tripDetail.setTripID(rs.getString("tripID"));
                tripDetail.setRoute(rs.getString("route"));
                tripDetail.setRunType(rs.getString("runType"));
                tripDetail.setRunStatus(rs.getString("runStatus"));
                tripDetail.setVendorTripStatus(rs.getString("vendorTripStatus"));
                tripDetail.setActualDeparture(rs.getString("actualDeparture"));
                tripDetail.setActualKM(rs.getDouble("actualKM"));
                tripDetail.setStandardKM(rs.getDouble("standardKM"));
                tripDetail.setOriginHub(rs.getString("originHub"));
                tripDetail.setDestHub(rs.getString("destHub"));
                tripDetail.setPaymentStatus(rs.getString("paymentStatus"));
                TripDetailsList.add(tripDetail);
            }

            System.out.println("list size>> " + TripDetailsList.size());
            data.setMsg("success");
            data.setData(TripDetailsList);

        } catch (Exception e) {
            data.setMsg("Failed");
            // TODO: handle exception
            e.printStackTrace();
        }

        return gson.toJson(data).toString();
    }

    @RequestMapping({"/tripDetailByTripId"})
    @CrossOrigin("*")
    public String getTripsDetailsByTripId(HttpServletRequest request, @RequestBody TripDetails tripObj) {

        DataContainer data = new DataContainer();

        System.out.println("trip id : " + tripObj.getTripID());

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        try {

            tripObj = tripDetailsRepo.findByTripID(tripObj.getTripID());

            data.setData(tripObj);
            data.setMsg("success");

        } catch (Exception e) {
            data.setMsg("error");
            e.printStackTrace();
        }

        return gson.toJson(data).toString();
    }

    @RequestMapping({"/saveTripQuery"})
    @CrossOrigin("*")
    public String saveTripQuery(@RequestBody QueryEntity queryObj) {

        DataContainer data = new DataContainer();

        // System.out.println("trip Query "+queryObj.getTripDetails());
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        try {

            queryObj = queryRepo.save(queryObj);

            data.setData(queryObj);
            data.setMsg("success");

        } catch (Exception e) {
            data.setMsg("error");
            e.printStackTrace();
        }

        return gson.toJson(data).toString();
    }


//
}
