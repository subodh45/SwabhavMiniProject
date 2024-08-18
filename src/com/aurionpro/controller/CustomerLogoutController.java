package com.aurionpro.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/CustomerLogoutController")
public class CustomerLogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private RequestDispatcher dispatcher= null;
 
    public CustomerLogoutController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
	    request.getSession().invalidate();
		
		dispatcher = request.getRequestDispatcher("Home.jsp");  
	        
	    dispatcher.forward(request,response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
