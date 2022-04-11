package com.main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.main.bean.DataContainer;
import com.main.db.bpaas.entity.InvoiceGenerationEntity;
import com.main.service.InvoiceServiceImpl;

@RestController
@RequestMapping("/financeController")
public class FinanceController {

	@Autowired
	private InvoiceServiceImpl invoiceServiceImpl;

	@RequestMapping({ "/viewAllInvoiceForFinanceTeam" })
	@CrossOrigin("*")
	public String getAllInvoice(HttpServletRequest request) {

		DataContainer data = new DataContainer();

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		try {
			List<InvoiceGenerationEntity> allInvoice = invoiceServiceImpl.getAllInvoice();

			data.setData(allInvoice);
			data.setMsg("success");

		} catch (Exception e) {
			data.setMsg("error");
			e.printStackTrace();
		}

		return gson.toJson(data).toString();
	}

}
