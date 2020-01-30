package com.wjh.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {
	
	public DB(){
		
	}
	
	public static Connection conn = null;
	
	public static void connDB(){
		String driver = "com.mysql.jdbc.Driver";
		String db = "jdbc:mysql://localhost:3306/board_db";
		String id = "root";
		String pw = "1234";
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(db, id, pw);
//			System.out.println("SUCCESS_DB Connection");
		} catch (ClassNotFoundException e) {
			System.out.println("ERR_Driver Loading : "+e.getMessage());
		} catch (SQLException e) {
			System.out.println("ERR_DB Connection : "+e.getMessage());
		}
	}

}
