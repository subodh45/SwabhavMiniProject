package com.aurionpro.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.aurionpro.entity.*;
import com.aurionpro.model.*;


@WebServlet("/AccountCreateController")
public class AccountCreateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private AccountsDBControl accountsDBControl = null;   
    RequestDispatcher dispatcher=null;
   
    public AccountCreateController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	    int customerId = Integer.parseInt(request.getParameter("customerId"));	    
	    int accountNumber = (int) (Math.random()*100000);
	    
	    accountsDBControl = new AccountsDBControl();
	    accountsDBControl.connectToDb();
	    accountsDBControl.addAccount(customerId, accountNumber);
	    
	    	String success = "Account Created Successfully";
	        request.setAttribute("success",success);
	        dispatcher = request.getRequestDispatcher("AdminHome.jsp");  
	        
	        dispatcher.forward(request,response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
