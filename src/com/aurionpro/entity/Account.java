package com.aurionpro.entity;

public class Account {

	private int customerId;
	private int accountnumber;
	private double balance;
	
	public Account( int accountnumber,int customerId, double balance) {
		super();
		this.customerId = customerId;
		this.accountnumber = accountnumber;
		this.balance = balance;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public int getAccountnumber() {
		return accountnumber;
	}

	public void setAccountnumber(int accountnumber) {
		this.accountnumber = accountnumber;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}
	
	
}
