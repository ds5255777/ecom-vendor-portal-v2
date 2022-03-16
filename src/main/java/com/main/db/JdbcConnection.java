package com.main.db;

import java.sql.Connection;
import java.sql.DriverManager;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class JdbcConnection {

    @Value("${spring.datasource.jdbcUrl}")
    public String url;

    @Value("${driver}")
    public String driver;

    @Value("${spring.datasource.username}")
    public String dbusername;

    @Value("${spring.datasource.password}")
    public String password;

    public Connection getConnection() {
        /*System.out.println("url >> " + url);
		System.out.println("url >> " + dbusername);*/
        System.out.println("********************Printing details for JDBC connection*******************");
        System.out.println("url " + url
                + "driver " + driver
                + "dbusername " + dbusername
                + "password  " + password);
        Connection con = null;
        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, dbusername, password);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }

}
