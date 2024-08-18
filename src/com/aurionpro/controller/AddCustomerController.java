package com.aurionpro.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.CustomerDBControl;


@WebServlet("/AddCustomerController")
public class AddCustomerController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private CustomerDBControl customerDBControl = null;
    private RequestDispatcher dispatcher = null;

    public AddCustomerController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String firstName = request.getParameter("firstName");
        String lastName  = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        customerDBControl = new CustomerDBControl();
        customerDBControl.connectToDb();
        
        boolean isCustomerAdded = customerDBControl.addCustomers(firstName, lastName, email, password);
        
        if (isCustomerAdded) {
            // If customer added successfully, redirect to admin home page
            dispatcher = request.getRequestDispatcher("AdminHome.jsp");
        } else {
            // If email is already registered, set an error message
            request.setAttribute("errorMessage", "Email is already registered.");
            dispatcher = request.getRequestDispatcher("AddCustomer.jsp");
        }
        
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}





