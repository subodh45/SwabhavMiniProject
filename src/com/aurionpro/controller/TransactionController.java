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

import com.aurionpro.entity.TransactionDetails;
import com.aurionpro.model.TransactionDBControl;


@WebServlet("/TransactionController")
public class TransactionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher dispatcher = null;
       

    public TransactionController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		TransactionDBControl transactionDBControl = new TransactionDBControl();
		transactionDBControl.connectToDb();
		
		List<TransactionDetails> transactions = new ArrayList<TransactionDetails>();
		
		transactions = transactionDBControl.getAllTransaction();
		
		request.setAttribute("transactions", transactions);	
		dispatcher = request.getRequestDispatcher("ViewTransaction.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
