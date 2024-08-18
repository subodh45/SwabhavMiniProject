package com.aurionpro.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.CustomerDBControl;


@WebServlet("/UpdateCustomerProfileController")
public class UpdateCustomerProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private CustomerDBControl customerDBControl  =null; 
    private RequestDispatcher dispatcher= null;
    public UpdateCustomerProfileController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String oldPassword= request.getParameter("oldPassword");
		String newPassword= request.getParameter("newPassword");
		
		 customerDBControl = new CustomerDBControl();
		 customerDBControl.connectToDb();
		 
		 if(customerDBControl.ValidatesCustomers(email, oldPassword))
		 {
			 customerDBControl.updateCustomerProfile(newPassword, email);
			 request.setAttribute("successMessage", "Succefully updated  .");
			  dispatcher = request.getRequestDispatcher("CustomerLogin.jsp");  
		 }
		 else
		 {    request.setAttribute("errorMessage", "Wrong old password .");
			  dispatcher = request.getRequestDispatcher("EditProfile.jsp");  	        
		      
		 }
		 dispatcher.forward(request,response); 
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
