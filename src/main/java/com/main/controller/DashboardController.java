package com.main.controller;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.JdbcConnection;
import com.main.db.bpaas.entity.AgreementMaster;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.repo.TripDetailsRepo;
import com.main.serviceManager.ServiceManager;
import java.security.Principal;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@RequestMapping("/dashboardController")
@RestController
public class DashboardController {

    @Value("${dataLimit}")
    public String dataLimit;

    @Autowired
    ServiceManager serviceManager;

    @Autowired
    JdbcConnection dbconnection;

    @Autowired
    TripDetailsRepo tripDetailsRepo;

    @RequestMapping({"getDashboardDetails"})
    @CrossOrigin("*")
    public String getDashBoardDetails(@RequestBody TripDetails reqObj, HttpSession session,
            HttpServletRequest request) {
        //System.out.println("start getting dashboard details");
        DataContainer data = new DataContainer();
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        List<TripDetails> tripList = new ArrayList<TripDetails>();
        TripDetails tripDetails = null;
        try {
            conn = dbconnection.getConnection();
            String sql = "Select e.id as id, e.trip_id as tripId, e.route as route, e.run_type as run,"
                    + " e.vendor_Trip_Status as status , e.payment_status as payment "
                    + "from Trip_Details e where  1=1 ORDER BY id DESC LIMIT " + dataLimit + ";";

            //System.out.println("query >> " + sql);
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                tripDetails = new TripDetails();

                tripDetails.setId(rs.getInt("id"));
                tripDetails.setTripID(rs.getString("tripId"));
                tripDetails.setRoute(rs.getString("route"));
                tripDetails.setRunType(rs.getString("run"));
                tripDetails.setVendorTripStatus(rs.getString("status"));
                tripDetails.setPaymentStatus(rs.getString("payment"));

                tripList.add(tripDetails);
            }
            data.setData(tripList);
            data.setMsg("success");

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            data.setMsg("error");
        } finally {
            try {
                stmt.close();
                rs.close();
                conn.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return gson.toJson(data).toString();
    }

    @RequestMapping("/updateDetailsforNetwork")
    @CrossOrigin("*")
    public void updateDetailsforNetwork(Model model, Principal principal, @RequestBody String agrn) {

        System.out.println("************************Data is ::" + agrn);
     
            JSONObject jsonObject = new JSONObject(agrn);
            String processedon = jsonObject.get("processedOn").toString();
            String tripid = jsonObject.get("tripID").toString();
            String AssigenedTo = jsonObject.get("AssigenedTo").toString();

            System.out.println("processedon" + processedon);
            System.out.println("tripid" + tripid);
            System.out.println("AssigenedTo" + AssigenedTo);

            tripDetailsRepo.updateDetailsByNetwork(AssigenedTo, tripid);

            DataContainer data = new DataContainer();
            data.setMsg("success");
            //  System.out.println("Value of S si :"+s);
       

      
    }
}
