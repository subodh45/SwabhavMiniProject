package com.aurionpro.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.TransactionDBControl;


@WebServlet("/CreditTransferController")
public class CreditTransferController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher dispatcher=null;
       
    public CreditTransferController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
		String transactionType = request.getParameter("transactionType");
		String date = request.getParameter("current-date");
		int amount = Integer.parseInt(request.getParameter("amount"));
		
		TransactionDBControl transactionDBControl = new TransactionDBControl();
		transactionDBControl.connectToDb();
		transactionDBControl.credit(accountNumber, amount,date, transactionType);
		
		request.setAttribute("CreditSuccess","Amount Credited Succefully.");
		dispatcher = request.getRequestDispatcher("Transaction.jsp");
		
		dispatcher.forward(request,response);
		
		//response.getWriter().print("following i get "+ accountNumber + " "+ transactionType + " ");
		//response.getWriter().print(date +" "+ amount);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
