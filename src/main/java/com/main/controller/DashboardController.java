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
import com.main.db.bpaas.entity.QueryEntity;
import com.main.db.bpaas.entity.TripDetails;
import com.main.db.bpaas.repo.QueryRepo;

import com.main.db.bpaas.repo.TripDetailsRepo;

import com.main.serviceManager.ServiceManager;
import java.security.Principal;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

    @Autowired
    QueryRepo queryRepo;

    @RequestMapping({"getDashboardDetails"})
    @CrossOrigin("*")
    public String getDashBoardDetails(@RequestBody TripDetails reqObj, HttpSession session,
            HttpServletRequest request) {
        DataContainer data = new DataContainer();
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        try {
            List<TripDetails> topTripRecods = tripDetailsRepo.getTopTripRecods(Integer.parseInt(dataLimit));

            data.setData(topTripRecods);
            data.setMsg("success");

        } catch (Exception e) {
            e.printStackTrace();
            data.setMsg("error");
        }

        return gson.toJson(data).toString();
    }

    @RequestMapping("/updateDetailsforNetwork")
    @CrossOrigin("*")
    public String updateDetailsforNetwork(Model model, Principal principal, @RequestBody String agrn) {

        System.out.println("************************Data is ::" + agrn);

        JSONObject jsonObject = new JSONObject(agrn);
        String processedon = jsonObject.get("processedOn").toString();
        String processedBy = jsonObject.getString("processedBy").toString();
        String tripid = jsonObject.get("tripID").toString();
        String AssigenedTo = jsonObject.get("AssigenedTo").toString();
        String LumpSomeCheckBox = "";
        String LumpSomeAmount = jsonObject.getString("LumpSomeAmount").toString();

//fs
//totalFreight
//basicFreight
        String fs = jsonObject.getString("fs").toString();
        String totalFreight = jsonObject.getString("totalFreight").toString();
        String basicFreight = jsonObject.getString("basicFreight").toString();
        String commentsByUSer = jsonObject.getString("commentsby").toString();

///
        System.out.println("fs " + fs
                + "\ntotalFreight " + totalFreight
                + "\nbasicFreight " + basicFreight + ""
                + "\ncommentsByUSer " + commentsByUSer);

        if ("".equalsIgnoreCase(LumpSomeAmount)) {
            LumpSomeCheckBox = "false";
        } else {
            LumpSomeCheckBox = "true";
        }

        if ("".equalsIgnoreCase(LumpSomeAmount)) {
            LumpSomeAmount = "0";
        }

        System.out.println("processedon" + processedon);
        System.out.println("tripid" + tripid);
        System.out.println("processedBy" + processedBy);
        System.out.println("AssigenedTo" + AssigenedTo);
        System.out.println("LumpSomeCheckBox" + LumpSomeCheckBox);
        System.out.println("LumpSomeAmount" + LumpSomeAmount);

        tripDetailsRepo.updateDetailsByNetwork(AssigenedTo, tripid, processedBy, processedon, LumpSomeCheckBox, LumpSomeAmount, "Yet To Be Approved");
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        DataContainer data = new DataContainer();
        data.setMsg("success");
        //  System.out.println("Value of S si :"+s);

        QueryEntity comm = new QueryEntity();
        comm.setRaisedBy(processedBy);
        try {
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            Date date = new Date();
            System.out.println(formatter.format(date));
            comm.setRaisedOn(date);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

//Find ID on the basic of tripid
        TripDetails obj = tripDetailsRepo.findByTripID(tripid);
        int id = (int)obj.getId();

        comm.setReferenceid(tripid);
        comm.setComment(commentsByUSer);
comm.setTripqueryfk(id);

        queryRepo.save(comm);

        return gson.toJson(data).toString();

    }
}
