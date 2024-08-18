
package com.aurionpro.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.entity.Account;
import com.aurionpro.model.TransactionDBControl;


@WebServlet("/DebitTransferController")
public class DebitTransferController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher dispatcher=null;
       
    public DebitTransferController() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
		String transactionType = request.getParameter("transactionType");
		String date = request.getParameter("current-date");
		int amount = Integer.parseInt(request.getParameter("amount"));
		
		TransactionDBControl transactionDBControl = new TransactionDBControl();
		transactionDBControl.connectToDb();
		Account account = transactionDBControl.getAccountDetails(accountNumber);
		double currentBalance = account.getBalance();
				
		if(currentBalance<amount)
		{
			System.out.println("Insufficient Balance.");
			request.setAttribute("DebitFailed","Insufficient Balance.");
			dispatcher = request.getRequestDispatcher("Transaction.jsp");
			dispatcher.forward(request,response);
		}
		else
		{
			transactionDBControl.debit(accountNumber, amount, date, transactionType);
			request.setAttribute("DebitSuccess","Amount Debited Succefully.");
			dispatcher = request.getRequestDispatcher("Transaction.jsp");
			
			dispatcher.forward(request,response);
			
		}
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
