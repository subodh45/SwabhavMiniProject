<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.aurionpro.entity.*" %>
<%@ page import="com.aurionpro.entity.Account" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Your PassBook</title>
<style>
body {
    background-color: #f8f9fa; /* Light gray background */
}

.navbar {
    background-color: #2c3e50; /* Dark navy background for the navbar */
    padding: 10px 20px; /* Padding for spacing */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
    display: flex; /* Use flexbox for alignment */
    justify-content: space-between; /* Space between the brand and the links */
    align-items: center; /* Center items vertically */
}

.navbar .brand {
    color: #f39c12; /* Gold color for the brand name */
    font-size: 26px; /* Font size similar to admin pages */
    font-weight: bold;
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
    background-color: #2c3e50; /* Dark navy background */
    color: white;
    font-size: 18px; /* Font size similar to admin pages */
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-left: 10px; /* Space between buttons */
}

.navbar .actions input[type="submit"]:hover,
.navbar .actions button:hover {
    background-color: #f39c12; /* Gold color on hover */
}

.container {
    max-width: 900px;
    margin: 50px auto;
    padding: 20px;
    background-color: #ffffff;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}

h1 {
    color: #2c3e50; /* Dark navy color */
    text-align: center;
    margin-bottom: 20px;
}

.search-box {
    width: 100%;
    margin-bottom: 20px;
}

.search-box input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}

.amount-filter {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.amount-filter input {
    width: 48%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

table, th, td {
    border: 1px solid #2c3e50;
    padding: 10px;
    text-align: left;
}

th {
    background-color: #2c3e50;
    color: white;
    font-weight: bold;
}

td {
    background-color: #ecf0f1;
    color: #2c3e50;
}

.form-group {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}

.form-group label {
    font-size: 18px;
    color: #2c3e50; /* Dark navy color for labels */
    margin-bottom: 10px;
    display: block;
}

.form-group select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
    margin-bottom: 10px;
}

.form-group button {
    background-color: #2c3e50; /* Dark navy background */
    color: white;
    font-size: 18px;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    width: 100%; /* Make the button full-width */
}

</style>
</head>
<body>

 <%
        HttpSession sessionss = request.getSession(false);
        Customer customer = (Customer) sessionss.getAttribute("customerDetails");
        List<Account> accounts = (List<Account>) sessionss.getAttribute("accounts");

  %>
  <%
  
    if (sessionss == null || sessionss.getAttribute("user") == null) {
        // No user is logged in, redirect to the login page
        response.sendRedirect("Home.jsp"); // Redirect to the login page
        return; // Stop further processing of the page
    }
%>

<%-- Navbar Section --%>
<div class="navbar">
   <a href="CustomerHome.jsp" style="text-decoration: none" class="brand">Aurionpro</a>
</div>

<%-- Container for the Passbook Details --%>
<div class="container">
    <h1>Transaction List</h1>
    
      <!-- Dropdown to select account number -->
		   <div class="form-group"> 
		    <form action="PassbookController" method="post">         
		        <label for="accountSelect">Select Account:</label>
		        <select id="accountSelect" name="accountNumber" required>
		            <option value="">All Accounts</option>
		            <c:forEach var="account" items="${accounts}">
		                <option value="${account.getAccountnumber()}">${account.getAccountnumber()}</option>
		            </c:forEach>
		        </select>
		        <button type="submit">View Transaction</button>
		    </form>
		</div>
		    
    <%-- Search box for filtering the table by text --%>
    <div class="search-box">
        <input type="text" id="searchInput" placeholder="Search transactions..." onkeyup="filterTable()">
    </div>

    <%-- Amount filter box for filtering the table by amount --%>
    <div class="amount-filter">
        <input type="number" id="minAmountInput" placeholder="Minimum Amount" onkeyup="filterTable()">
        <input type="number" id="maxAmountInput" placeholder="Maximum Amount" onkeyup="filterTable()">
    </div>

    <%-- Table of transactions --%>
    <table id="transactionTable">
        <thead>
            <tr>
                <th>Id</th>
                <th>Account Number</th>
                <th>Receiver Account</th>
                <th>Transaction Type</th>
                <th>Amount</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="transaction" items="${transactions}">
            <tr>
                <td>${transaction.getTransactionId()}</td>
                <td>${transaction.getSenderAccount()}</td>
                <td>${transaction.getReceiverAccount()}</td>
                <td>${transaction.getTransactionType()}</td>
                <td class="amount">${transaction.getAmount()}</td>
                <td>${transaction.getDate()}</td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%-- JSP Code to Handle Logout --%>

<script>
    function filterTable() {
        // Declare variables
        var input, filter, table, tr, td, i, j, txtValue;
        var minAmountInput = document.getElementById('minAmountInput').value;
        var maxAmountInput = document.getElementById('maxAmountInput').value;
        var minAmount = parseFloat(minAmountInput) || 0; // Minimum amount or 0 if empty
        var maxAmount = parseFloat(maxAmountInput) || Infinity; // Maximum amount or Infinity if empty

        input = document.getElementById('searchInput');
        filter = input.value.toLowerCase();
        table = document.getElementById('transactionTable');
        tr = table.getElementsByTagName('tr');

        // Loop through all table rows, and hide those who don't match the search query
        for (i = 1; i < tr.length; i++) { // Start at 1 to skip the header row
            tr[i].style.display = 'none'; // Hide the row by default
            td = tr[i].getElementsByTagName('td');
            var amount = parseFloat(td[4].textContent) || 0; // Get the amount value

            // Check if the amount is within the specified range
            if (amount >= minAmount && amount <= maxAmount) {
                // If amount is in range, check the text filter
                for (j = 0; j < td.length; j++) {
                    if (td[j]) {
                        txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toLowerCase().indexOf(filter) > -1) {
                            tr[i].style.display = ''; // Show the row if it matches
                            break;
                        }
                    }
                }
            }
        }
    }
</script>

</body>
</html>
