package com.aurionpro.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;

public class AdminDBControl {

	private Connection connection;
	private Statement statement=null;
	private PreparedStatement prepareStatement=null ;
	ResultSet resultset=null;
	
	public void connectToDb() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_app","root","root");
			System.out.println("Connection Successfull");
			statement = connection.createStatement();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public ResultSet getAllAdmins()
	{
		try {
			statement = connection.createStatement();
			resultset = statement.executeQuery("select * from admins");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return resultset;
	}
	
	//validate adminName and password 
	
	public boolean adminValidator(String adminname,String password)
	{
		resultset = getAllAdmins();
		
		try {
			while(resultset.next())
			{
			   if(resultset.getString("adminName").equals(adminname))
				   if(resultset.getString("adminPassword").equals(password))
					   return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}
	
	
	public void addAdmin(String username,String password)
	{
		try {
			
			prepareStatement = connection.prepareStatement("insert into admins (adminName ,adminPassword) values (?,?)");
			
			prepareStatement.setString(1,username);
			prepareStatement.setString(2,password);
			prepareStatement.executeUpdate();
			 
			System.out.println("added Successfully.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}
