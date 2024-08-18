<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.aurionpro.entity.*" %>
<%@ page import="com.aurionpro.model.*" %>
<%@ page import="com.aurionpro.entity.Account" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Home Page</title>
<style>
body {
    background-color: #f8f9fa;
}

.navbar {
    background-color: #2c3e50;
    padding: 10px 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.navbar .brand {
    color: #f39c12;
    font-size: 26px;
    font-weight: bold;
}

.navbar .links {
    display: flex;
    align-items: center;
}

.navbar .links a {
    color: #ecf0f1;
    font-size: 18px;
    text-decoration: none;
    margin: 0 15px;
}

.navbar .links a:hover {
    color: #f39c12;
}

.navbar .actions {
    display: flex;
    align-items: center;
}

.navbar .actions form {
    margin: 0;
}

.navbar .actions input[type="submit"],
.navbar .actions button {
    background-color: #2c3e50;
    color: white;
    font-size: 18px;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-left: 10px;
}

.navbar .actions input[type="submit"]:hover,
.navbar .actions button:hover {
    background-color: #f39c12;
}

.container {
    max-width: 800px;
    margin-top: 50px;
    margin: 0 auto;
    padding: 20px;
    background-color: #ffffff;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    text-align: center;
}

.container h2 {
    margin-bottom: 20px;
    color: #2c3e50;
}

.container .account-details {
    text-align: left;
    color: #34495e;
    font-size: 18px;
    margin-bottom: 20px;
}

.container .account-details h4 {
    color: #2c3e50;
    font-size: 22px;
    margin-bottom: 10px;
}

.account-list {
    margin-top: 20px;
    text-align: left;
}

.account-list ul {
    list-style-type: none;
    padding: 0;
}

.account-list ul li {
    background-color: #ecf0f1;
    padding: 10px;
    margin-bottom: 10px;
    border-radius: 5px;
    font-size: 18px;
    color: #34495e;
}

.account-list ul li:hover {
    background-color: #f39c12;
    color: white;
}

.button {
    width: 50%;
    height: 50px;
    font-size: 20px;
    border-radius: 5px;
    font-weight: bold;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #1e2a38;
    color: white;
    border: none;
    cursor: pointer;
    margin: 15px auto 0 auto;
    transition: background-color 0.3s, transform 0.3s;
}

.button:hover {
    background-color: #2c3e50;
}
</style>
</head>
<body>

<%
    HttpSession sessionss = request.getSession(false); // Don't create a new session
    if (sessionss == null || sessionss.getAttribute("user") == null) {
        // No user is logged in, redirect to the login page
        response.sendRedirect("Home.jsp"); // Redirect to the login page
        return; // Stop further processing of the page
    }
%>

<div class="navbar">
    <div class="brand">Aurionpro</div>

    <%
        HttpSession sessions = request.getSession(false);
        Customer customer = (Customer) sessions.getAttribute("customerDetails");
        List<Account> accounts = (List<Account>) sessions.getAttribute("accounts");

    %>
    <div class="actions">
         <form action="ViewPassport.jsp" method="post">	        
	        <button >Passbook</button>
         </form>
	    <form action="Transaction.jsp" method="post">
	        <input type="hidden" name="accountNumber" value="">
	        <button >New Transaction</button>
	    </form>
	    
        <form action="EditProfile.jsp" >
            <input type="hidden" name="firstName" value="<% out.print(customer.getFirstName()); %>">
            <input type="hidden" name="lastName" value="<% out.print(customer.getLastName()); %>">
            <input type="hidden" name="email" value="<% out.print(customer.getEmail()); %>">
            <button type="submit" name="editProfile">Edit Profile</button>
        </form>
        <form action="CustomerLogoutController" method="post">
            <input type="submit" value="Logout" name="logout" />
        </form>
    </div>
</div>



<div class="container">
    <h2>Your  Details</h2>
    <div class="account-details">
        <h4>Customer ID: <% out.print(customer.getCustomerId()); %></h4>
        <h4>Name: <% out.print(customer.getFirstName() + " " + customer.getLastName()); %></h4>
        <h4>Email: <% out.print(customer.getEmail()); %></h4>
    </div>

   <div class="account-list">
        <h4>Your Accounts</h4>
        <table border="1" cellpadding="10" cellspacing="0" style="width: 100%; border-collapse: collapse;">
            <thead>
                <tr>
                    <th>Account Number</th>
                    <th>Balance</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Account account : accounts) {
                %>
                <tr>
                    <td><% out.print(account.getAccountnumber()); %></td>
                    <td><% 
                    int accountNum = account.getAccountnumber();
                    AccountsDBControl accountsDBControl = new AccountsDBControl();
                    accountsDBControl.connectToDb();
                    out.print(accountsDBControl.getAccountBalance(accountNum));
                                     
                    %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

<!-- 
    <form action="PassbookController" method="post">
        <input type="hidden" name="accountNumber" value="<%-- out.print(customer.getAccountNumber()); %>">
        <button class="button">Passbook</button>
    </form>
    <form action="Transaction.jsp" method="post">
        <input type="hidden" name="accountNumber" value="<% out.print(customer.getAccountNumber()); --%>">
        <button class="button">New Transaction</button>
    </form>
    
     -->
</div>

</body>
</html>
