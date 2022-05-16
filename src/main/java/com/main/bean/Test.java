package com.main.bean;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Test {

	public static void main(String[] args) {
       
		Date parsedDate=null;
		try {
				
				parsedDate=new SimpleDateFormat("dd-MMM-yy").parse("14-Apr-22");
				System.out.println("parsedDate.."+parsedDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
    }
}
