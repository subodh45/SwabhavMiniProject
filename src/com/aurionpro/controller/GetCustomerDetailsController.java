package com.aurionpro.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.entity.Customer;

import com.aurionpro.model.CustomerDBControl;


@WebServlet("/getCustomerDetailsController")
public class GetCustomerDetailsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private CustomerDBControl customerDBControl = null;
 	private RequestDispatcher dispatcher = null;

    public GetCustomerDetailsController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		customerDBControl = new CustomerDBControl();
		customerDBControl.connectToDb();
		
		int customerId = Integer.parseInt(request.getParameter("customerId"));
		
		Customer customer = customerDBControl.getCustomer(customerId);
		
		System.out.println(customer);
			if(customer!=null) {
			request.getSession().setAttribute("customer", customer);
			dispatcher = request.getRequestDispatcher("AddCustomerAccount.jsp");
			}
			else
			{   String message = "Enter Valid CustomerID";
				request.getSession().setAttribute("message", message);
				request.getSession().setMaxInactiveInterval(5);
				dispatcher = request.getRequestDispatcher("AddAccount.jsp");
			}
		
		
		//request.setAttribute("customer", customers);		
		
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
