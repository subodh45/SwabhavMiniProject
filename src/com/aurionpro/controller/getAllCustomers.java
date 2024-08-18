package com.aurionpro.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.CustomerDBControl;
import com.aurionpro.entity.*;


@WebServlet("/getAllCustomers")
public class getAllCustomers extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private CustomerDBControl customerDBControl =null;
    RequestDispatcher dispatcher =null;

    public getAllCustomers() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		customerDBControl = new CustomerDBControl();
		customerDBControl.connectToDb();
		
		List<CustomerDetails>customers = new ArrayList<CustomerDetails>();
		
		customers = customerDBControl.getAllCustomers();
		
		request.setAttribute("customers", customers);		
		dispatcher = request.getRequestDispatcher("CustomersList.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
