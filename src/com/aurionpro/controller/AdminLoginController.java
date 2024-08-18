package com.aurionpro.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.entity.Admin;
import com.aurionpro.model.AdminDBControl;


@WebServlet("/AdminLoginController")
public class AdminLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       Admin admin =null ;
       AdminDBControl adminDBControl = null;
   	private RequestDispatcher dispatcher = null;
  
    public AdminLoginController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		    String adminname = request.getParameter("adminname");
		    String password = request.getParameter("password");
		    adminDBControl = new AdminDBControl();	
		    adminDBControl.connectToDb();
		    
		    
    	    if(adminDBControl.adminValidator(adminname, password))
    	    {    
    	    	HttpSession adminsession = request.getSession();
                adminsession.setAttribute("adminName", adminname);	
    	        dispatcher = request.getRequestDispatcher("AdminHome.jsp");
    	    }
    	    else
    	    	 dispatcher = request.getRequestDispatcher("Home.jsp");
    	    
			 dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
