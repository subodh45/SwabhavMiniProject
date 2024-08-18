package com.aurionpro.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;

import com.aurionpro.entity.Account;
import com.aurionpro.entity.TransactionDetails;

public class TransactionDBControl {

	
	private Connection connection;
	private Statement statement=null;
	private PreparedStatement prepareStatement=null ;
	ResultSet resultset=null;
	Account account = null;
	
	
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
	
	public Account getAccountDetails(int accountNumber)
	{   
		try {
			prepareStatement = connection.prepareStatement("select * from accounts where accountNumber=?");
			prepareStatement.setInt(1,accountNumber);
			resultset = prepareStatement.executeQuery();
			
			if(resultset.next())
			{
				account = new Account(resultset.getInt(1),resultset.getInt(2),resultset.getDouble(3));
				return account;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return account;
	}
	
	public void credit(int accountNumber, int amount,String date , String TransactionType)
	{
		 account = getAccountDetails(accountNumber);
		 double currentBalance = account.getBalance();
		 account.setBalance(currentBalance + amount);
		 double updatedBalance = currentBalance + amount;
		 PreparedStatement pst = null;
		 try {
			prepareStatement = connection.prepareStatement("update accounts set balance =? where accountNumber=?");
			pst = connection.prepareStatement("insert into transactions (senderAccount,transactionType , amount, date) values(?,?,?,?)");
			prepareStatement.setDouble(1, updatedBalance);
			prepareStatement.setInt(2, accountNumber);
			pst.setInt(1,accountNumber);
			pst.setString(2,TransactionType);
			pst.setInt(3, amount);
			pst.setString(4, date);
			
			pst.executeUpdate();
			prepareStatement.executeUpdate();
			
			System.out.println("data updated successfully.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	}
	
	public void debit(int accountNumber, int amount,String date , String TransactionType)
	{
		 account = getAccountDetails(accountNumber);
		
		 PreparedStatement pst = null;
		 
		 try {
			double currentBalance = account.getBalance();
			account.setBalance(currentBalance - amount);
			double updatedBalance = currentBalance - amount;
			prepareStatement = connection.prepareStatement("update accounts set balance =? where accountNumber=?");
			pst = connection.prepareStatement("insert into transactions (senderAccount,transactionType , amount, date) values(?,?,?,?)");
			prepareStatement.setDouble(1, updatedBalance);
			prepareStatement.setInt(2, accountNumber);
			pst.setInt(1,accountNumber);
			pst.setString(2,TransactionType);
			pst.setInt(3, amount);
			pst.setString(4, date);
			
			pst.executeUpdate();
			prepareStatement.executeUpdate();
			
			System.out.println("data updated successfully.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	}

	public void transfer(int accountNumber, double amount, String date, String transactionType, int receiverAccount) {
		
		Account accountsender = getAccountDetails(accountNumber);
		Account accountReceiver= getAccountDetails(receiverAccount);
	
		accountsender.setBalance(accountsender.getBalance()-amount);
		double senderUpdatedAmount = accountsender.getBalance();
		
		accountReceiver.setBalance(accountReceiver.getBalance()+amount);
		double receiverUpdatedAmount = accountReceiver.getBalance();
		
		try {
			connection.setAutoCommit(false);
			
			PreparedStatement pst1 = connection.prepareStatement("update accounts set balance =? where accountNumber=?");
			pst1.setDouble(1,senderUpdatedAmount);
			pst1.setInt(2, accountNumber);
			
			PreparedStatement pst2 = connection.prepareStatement("update accounts set balance =? where accountNumber=?");
			pst2.setDouble(1, receiverUpdatedAmount);
			pst2.setInt(2,receiverAccount);
			
			PreparedStatement pst3 = connection.prepareStatement("insert into transactions (senderAccount,receiverAccount,transactionType , amount, date) values(?,?,?,?,?)");
			pst3.setInt(1, accountNumber);
			pst3.setInt(2, receiverAccount);
			pst3.setString(3,transactionType);
			pst3.setDouble(4, amount);
			pst3.setString(5, date);
			
			int send =pst1.executeUpdate();
			int receive = pst2.executeUpdate();
			int add = pst3.executeUpdate();
			
			 if (send == 1 && receive == 1 ) {
	                
	                connection.commit();
	                System.out.println("Transaction successful! Money transferred.");
	            } else {
	                
	                connection.rollback();
	                System.out.println("Transaction failed! Money not transferred.");
	            }
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	public List<TransactionDetails> getAllTransaction()
	{
		List<TransactionDetails> transactions =new ArrayList<>();
		
		try {
			resultset = statement.executeQuery("select * from transactions order by transactionId desc");
			
			while(resultset.next())
			{
				transactions.add(new TransactionDetails(resultset.getInt(1),resultset.getInt(2),resultset.getInt(3),resultset.getString(4),resultset.getDouble(5),resultset.getString(6)));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return transactions;
		
	}
	
	
	public List<TransactionDetails> getUserTransaction(int accountNumber)
	{
		List<TransactionDetails> transactions =new ArrayList<>();
		
		try {
			 prepareStatement =connection.prepareStatement("select * from transactions where senderAccount=? or receiverAccount=? order by transactionId desc");
			 prepareStatement.setInt(1,accountNumber);
			 prepareStatement.setInt(2,accountNumber);
			 resultset = prepareStatement.executeQuery();
			
			while(resultset.next())
			{
				transactions.add(new TransactionDetails(resultset.getInt(1),resultset.getInt(2),resultset.getInt(3),resultset.getString(4),resultset.getDouble(5),resultset.getString(6)));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return transactions;
		
	}
}
