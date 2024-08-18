package com.aurionpro.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.entity.Account;
import com.aurionpro.entity.Customer;
import com.aurionpro.entity.CustomerDetails;
import com.aurionpro.model.CustomerDBControl;


@WebServlet("/CustomerLoginController")
public class CustomerLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CustomerDBControl customerDBControl=null;
	RequestDispatcher dispatcher = null;

    public CustomerLoginController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email= request.getParameter("email");
		String password = request.getParameter("password");
		
		
		customerDBControl=new CustomerDBControl();
		customerDBControl.connectToDb();
		 
		//Customer customer =customerDBControl.ValidatesCustomers(email, password);
		//Customer customer =customerDBControl.ValidatesCustomers2(email, password,accountNumber);
		customerDBControl.ValidatesCustomers(email, password);
		Customer customerDetails = customerDBControl.getCustomersDetails(email);
		
		if(customerDBControl.ValidatesCustomers(email, password))
		{   
			Customer customer = customerDBControl.getCustomersDetails(email);
			int customerId= customer.getCustomerId();	
			List<Account>accounts = customerDBControl.getCustomerAccounts(customerId);
			
		
			HttpSession sessionss = request.getSession();
             sessionss.setAttribute("user", email);
             sessionss.setAttribute("customerDetails", customerDetails);
             sessionss.setAttribute("accounts", accounts);
			//request.setAttribute("customerDetails", customerDetails);
			dispatcher=request.getRequestDispatcher("CustomerHome.jsp");	
		}
		else
		{
			
			dispatcher=request.getRequestDispatcher("Home.jsp");
		}
		
		dispatcher.forward(request,response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
