package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	
	
	private static final String URL = "jdbc:mysql://localhost:3306/VTJNW04_25";
    private static final String USER = "root";
    private static final String PASS = "root";

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }

}
