package com.aurionpro.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.aurionpro.entity.Account;
import com.aurionpro.entity.Customer;
import com.aurionpro.entity.CustomerDetails;


public class CustomerDBControl {

	private Connection connection =null;
	private Statement statement =null;
	private PreparedStatement prepareStatement=null;
	private ResultSet resultSet = null;
	private Customer customer = null;
	
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
	
	
	public ResultSet FindCustomers()
	{
		try {
			resultSet= statement.executeQuery("select * from accounts a join customers c on a.customerId =c.customerId");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		return resultSet;
	}
	
	public ResultSet FindCustomers2()
	{
		try {
			resultSet= statement.executeQuery("select * from customers");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		return resultSet;
	}
	
	
	public boolean ValidatesCustomers(String email, String password)
	{
	     resultSet = FindCustomers2();
	     
	     try {
			while(resultSet.next())
			 {
				 if(resultSet.getString("emailId").equals(email) && resultSet.getString("CustomerPassword").equals(password))
				 { 
				    return true;
				 }
			 }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
		
	}
	
	
	public boolean addCustomers(String firstName, String lastname, String emailId, String customerPassword) {
	    String checkEmailSql = "SELECT COUNT(*) FROM customers WHERE emailId = ?";
	    String insertSql = "INSERT INTO customers (firstName, lastName, emailId, CustomerPassword) VALUES (?, ?, ?, ?)";
	    
	    try {
	        // Check if email is already registered
	        prepareStatement = connection.prepareStatement(checkEmailSql);
	        prepareStatement.setString(1, emailId);
	        ResultSet resultSet = prepareStatement.executeQuery();
	        
	        resultSet.next();
	        if (resultSet.getInt(1) > 0) {
	            // Email is already registered
	            return false;
	        }
	        
	        // If email is not registered, insert new customer
	        prepareStatement = connection.prepareStatement(insertSql);
	        prepareStatement.setString(1, firstName);
	        prepareStatement.setString(2, lastname);
	        prepareStatement.setString(3, emailId);
	        prepareStatement.setString(4, customerPassword);
	        
	        prepareStatement.executeUpdate();
	        System.out.println("Customer added successfully.");
	        return true;
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	
	public void addCustomers2(String firstName,String lastname,String emailId, String customerPassword)
	{
		String sql ="insert into customers (firstName,lastName,emailId,CustomerPassword) values (?,?,?,?)";
		try {
			prepareStatement = connection.prepareStatement(sql);
			
			prepareStatement.setString(1, firstName);
			prepareStatement.setString(2, lastname);
			prepareStatement.setString(3, emailId);
			prepareStatement.setString(4, customerPassword);
			
			prepareStatement.executeUpdate();
			System.out.println("customer Added Successfully.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			
			e.printStackTrace();
		}
	}
	
	public Customer getCustomer(int customerid) 
	{
		try {
			 prepareStatement = connection.prepareStatement("select * from customers where customerId=?");
			 prepareStatement.setInt(1,customerid);
			 resultSet = prepareStatement.executeQuery();	
			 
			 
			if(resultSet.next())
			{
			customer= new Customer(resultSet.getInt(1),resultSet.getString(2),resultSet.getString(3),resultSet.getString(4),resultSet.getString(5));
			System.out.println("data fetched successfully.");
			}
					
		} catch (Exception e) {
			e.getMessage();
		}
	
		return customer;
	}
	
	public List<CustomerDetails> getAllCustomers()
	{   ResultSet rs=null;
		List<CustomerDetails>customers = new ArrayList<CustomerDetails>();
		 try {
			 rs = statement.executeQuery("select c.customerId ,c.firstName,c.lastName,c.emailId,a.accountNumber,a.balance from customers c left join accounts a on c.customerId = a.customerId order by c.customerId desc;");
			
			while(rs.next())
			{
				
				customers.add(new CustomerDetails(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getInt(5),rs.getDouble(6)));
				System.out.println("data added successfully.");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return customers;
	}
	
	public Customer ValidatesCustomers2(String email, String password, int accountNumber)
	{
	     resultSet = FindCustomers();
	     Customer customer=null;
	     try {
			while(resultSet.next())
			 {
				 if(resultSet.getString("emailId").equals(email) && resultSet.getString("CustomerPassword").equals(password) && resultSet.getInt("accountNumber")== accountNumber)
				 { 
					customer = new Customer(resultSet.getInt(4),resultSet.getString(5),resultSet.getString(6),resultSet.getString(7),resultSet.getString(8)); 
				    return customer;
				 }
			 }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return customer;
		
	}
	
	public CustomerDetails getCustomersDetails2(String email,int accountNumber)
	{   ResultSet rs=null;
		CustomerDetails customerDetails = null;
		 try {   
			 prepareStatement = connection.prepareStatement("select a.customerId ,c.firstName,c.lastName,c.emailId,a.accountNumber,a.balance from accounts a left join customers  c on a.customerId = c.customerId where c.emailId=? && a.accountNumber=?;");
			 prepareStatement.setString(1,email);
			 prepareStatement.setInt(2, accountNumber);
			 rs = prepareStatement.executeQuery();
			 //rs = statement.executeQuery("select a.customerId ,c.firstName,c.lastName,c.emailId,a.accountNumber,a.balance from accounts a left join customers  c on a.customerId = c.customerId where c.emailId=?;");
			
			if(rs.next())
			{
				
				customerDetails = new CustomerDetails(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getInt(5),rs.getDouble(6));
				return customerDetails;
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return customerDetails;
	}
	
	
	public List<Customer> getAllCustomerList()
	{   ResultSet rs=null;
		List<Customer>customers = new ArrayList<Customer>();
		 try {
			 rs = statement.executeQuery("select * from customers;");
			
			while(rs.next())
			{
				
				customers.add(new Customer(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5)));
				System.out.println("data added successfully.");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		return customers;
	}
	
	public void updateCustomerProfile(String newPassword,  String email)
	{
		try {
			prepareStatement = connection.prepareStatement("update customers set CustomerPassword =? where emailId=?");
			prepareStatement.setString(1,newPassword);
			prepareStatement.setString(2, email);
			prepareStatement.executeUpdate();
			System.out.println("updated aaccount successfully.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public List<Account> getCustomerAccounts(int customerId)
	{   ResultSet rs=null;
		List<Account> accounts = new ArrayList<Account>();
		 try {
			  prepareStatement =connection.prepareStatement("select * from accounts where CustomerId=?;");
			  prepareStatement.setInt(1, customerId);
			  rs = prepareStatement.executeQuery();
			 
			while(rs.next())
			{
				accounts.add(new Account(rs.getInt(1),rs.getInt(2),rs.getDouble(3)));
				System.out.println("data added successfully.");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return accounts;
	}
	
	public Customer getCustomersDetails(String email)
	{   ResultSet rs=null;
		Customer customerDetails = null;
		 try {   
			 prepareStatement = connection.prepareStatement("select * from customers where emailId=?;");
			 prepareStatement.setString(1,email);
			 
			 rs = prepareStatement.executeQuery();
			 //rs = statement.executeQuery("select a.customerId ,c.firstName,c.lastName,c.emailId,a.accountNumber,a.balance from accounts a left join customers  c on a.customerId = c.customerId where c.emailId=?;");
			
			if(rs.next())
			{
				
				customerDetails = new Customer(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5));
				return customerDetails;
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return customerDetails;
	}
	
}
