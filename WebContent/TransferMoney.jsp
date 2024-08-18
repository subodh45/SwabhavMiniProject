<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.aurionpro.entity.*" %>
<%@ page import="com.aurionpro.model.*" %>
<%@ page import="com.aurionpro.entity.Account" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Transfer Money</title>
<style>
body {
    background-color: #f8f9fa; /* Light gray background */
    font-family: Arial, sans-serif;
}

.navbar {
    background-color: #2c3e50; /* Dark navy background */
    padding: 10px 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.navbar .brand {
    color: #f39c12; /* Gold color for the brand name */
    font-size: 26px; /* Font size similar to admin pages */
    font-weight: bold;
}

.navbar a {
    color: #ecf0f1; /* Light gray color for the links */
    font-size: 18px;
    text-decoration: none;
    margin-right: 15px;
}

.navbar a:hover {
    color: #f39c12; /* Gold color on hover */
}

.navbar .actions {
    display: flex;
    align-items: center;
}

.navbar .actions input[type="submit"] {
    background-color: #2c3e50; /* Dark navy background */
    color: white;
    font-size: 18px;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-left: 10px; /* Space between buttons */
}

.navbar .actions input[type="submit"]:hover {
    background-color: #f39c12; /* Gold color on hover */
}

.container {
    max-width: 600px; /* Slightly narrower container for better form layout */
    margin: 50px auto;
    padding: 20px;
    background-color: #ffffff;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}

.container h1 {
    color: #2c3e50; /* Dark navy for headers */
    margin-bottom: 20px;
    font-size: 28px; /* Slightly larger font size for emphasis */
}

.form-group {
    margin-bottom: 20px; /* Space between form elements */
    text-align: left;
}

.form-group label {
    display: block;
    font-size: 18px;
    color: #2c3e50;
    margin-bottom: 5px; /* Space between label and input */
}

.form-group input[type="text"],
.form-group input[type="number"],
.form-group input[type="date"],
.form-group select {
    width: calc(100% - 22px); /* Full width minus padding */
    height: 40px;
    font-size: 18px;
    border: solid #bdc3c7 1px; /* Light gray border */
    border-radius: 5px;
    padding: 5px 10px;
    margin-bottom: 15px;
}

.form-group select {
    background-color: #ffffff; /* White background for dropdown */
    color: #34495e; /* Darker text color */
}


.form-group input[type="text"],
.form-group input[type="number"],
.form-group input[type="date"] {
     width: calc(100% - 22px); /* Full width minus padding */
    height: 40px;
    font-size: 18px;
    border: solid #bdc3c7 1px; /* Light gray border */
    border-radius: 5px;
    padding: 10px; /* Padding inside the input fields */
}

.form-group input[type="number"] {
    -moz-appearance: textfield; /* Remove number input spinners in Firefox */
}

.form-group input[type="number"]::-webkit-inner-spin-button,
.form-group input[type="number"]::-webkit-outer-spin-button {
    -webkit-appearance: none; /* Remove number input spinners in WebKit browsers */
}

.button {
    width: 100%;
    height: 50px;
    font-size: 20px;
    border-radius: 5px;
    font-weight: bold;
    background-color: #2c3e50; /* Dark navy background */
    color: white;
    border: none;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: background-color 0.3s, transform 0.3s;
}

.button:hover {
    background-color: #f39c12; /* Gold color on hover */
    transform: translateY(-2px); /* Slight upward movement on hover */
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
   <a href="CustomerHome.jsp" class="brand">Aurionpro</a>
   <div class="actions">
      
      <!--   <form method="post">
           <input type="submit" value="Logout" name="logout" />
       </form>
       
       -->
   </div>
</div>

<%
        HttpSession sessions = request.getSession(false);
        Customer customer = (Customer) sessions.getAttribute("customerDetails");
        List<Account> accounts = (List<Account>) sessions.getAttribute("accounts");
    %>

<div class="container">
    <%
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String todayDate = sdf.format(new Date());
    %>
        <h1>Transfer Transaction</h1>
        <form action="TransferController" method="post">
            <div class="form-group">
                <label>Transaction Type:</label>
                <input type="text" name="transactionType" value="transfer" readonly>
            </div>
            
            <div class="form-group">
                <label>Account Number:</label>
               <select name="accountNumber" required>
                <option value="" disabled selected>Select Account</option>
                <%
                    for (Account account : accounts) {
                %>
                <option value="<%= account.getAccountnumber() %>">
                    <%= account.getAccountnumber() %> (Balance: <% int accountNum = account.getAccountnumber();
                    AccountsDBControl accountsDBControl = new AccountsDBControl();
                    accountsDBControl.connectToDb();
                    out.print(accountsDBControl.getAccountBalance(accountNum)); %>)
                </option>
                <%
                    }
                %>
            </select>
            </div>
            
            <div class="form-group">
                <label>Date:</label>
                <input type="date" id="current-date" name="current-date" value="<%= todayDate %>" readonly>
            </div>
            <div class="form-group">
                <label>Enter Amount to be Transferred:</label>
                <input type="number" name="amount" min="1" required>
            </div>
            <div class="form-group">
                <label>Receiver Account Number:</label>
                <input type="number" name="receiverAccount" min="1" placeholder="e.g., 46039" required>
            </div>
            <button class="button">Transfer</button>
        </form>
   
</div>

</body>
</html>
