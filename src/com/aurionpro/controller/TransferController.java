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

@WebServlet("/TransferController")
public class TransferController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher dispatcher=null;   

    public TransferController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
		String transactionType = request.getParameter("transactionType");
		String date = request.getParameter("current-date");
		int amount = Integer.parseInt(request.getParameter("amount"));
		int receiverAccount = Integer.parseInt(request.getParameter("receiverAccount"));
		
		//System.out.println("receiver "+ receiverAccount + " "+ transactionType+" "+ accountNumber +" "+ amount + " "+ date );

		if(accountNumber != receiverAccount)
		{
		TransactionDBControl transactionDBControl = new TransactionDBControl();
		transactionDBControl.connectToDb();
		
		Account account1 = transactionDBControl.getAccountDetails(receiverAccount);
		
		if(account1!=null)
		{   System.out.print("got receiver account ");
		   
			Account account2 = transactionDBControl.getAccountDetails(accountNumber);
			
			if(account2!=null)
			{
			double balance = account2.getBalance();
			
			if(balance >= amount)
			{
				transactionDBControl.transfer(accountNumber, amount, date, transactionType,receiverAccount);
				
				request.setAttribute("TransferSuccess","Transfer Completed Successfully.");
				dispatcher = request.getRequestDispatcher("Transaction.jsp");
				
				dispatcher.forward(request,response);
			}
			else
			{
				request.setAttribute("TransferFailed","Insufficient  Balance.");
				dispatcher = request.getRequestDispatcher("Transaction.jsp");
				
				dispatcher.forward(request,response);
			}
			}
			else
			{
				request.setAttribute("TransferFailed","Invalid sender account number.");
				dispatcher = request.getRequestDispatcher("Transaction.jsp");
				
				dispatcher.forward(request,response);	
			}
		}
		else
		{
			
			request.setAttribute("TransferFailed","Invalid receiver Account Number.");
			dispatcher = request.getRequestDispatcher("Transaction.jsp");
			
			dispatcher.forward(request,response);
		}
		}
		else
		{
			request.setAttribute("TransferFailed"," receiver Account Number Can not be Same as Sender Amount .");
			dispatcher = request.getRequestDispatcher("Transaction.jsp");
			
			dispatcher.forward(request,response);
		}
		//response.getWriter().print(receiverAccount);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
