<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer List</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f1f4f9; /* Light background for a clean look */
            font-family: Arial, sans-serif; /* Modern font */
            margin: 0;
            padding: 0;
            color: #333; /* Dark text for readability */
        }
        .navbar {
            background-color: #2c3e50; /* Dark slate background for the navbar */
            padding: 8px 16px; /* Slim padding for a slim navbar */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
        }
        .navbar-brand {
            color: #f39c12; /* Gold color for the brand name */
            font-size: 22px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: color 0.3s ease;
        }
        .navbar-brand:hover {
            color: #f7c14d; /* Lighter gold on hover */
        }
        .navbar-nav {
            margin-left: auto; /* Pushes the nav items to the right */
        }
        h1 {
            text-align: center;
            margin-top: 20px;
            font-size: 28px;
            color: #2c3e50; /* Dark slate color for the heading */
        }
        .filter-container {
            width: 90%;
            max-width: 1000px;
            margin: 20px auto; /* Centered filters */
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
        }
        .filter-container input {
            width: 48%;
            padding: 10px;
            border: 1px solid #2c3e50; /* Border color matching navbar */
            border-radius: 5px;
            font-size: 16px;
            background-color: #ecf0f1; /* Light gray background */
            color: #2c3e50; /* Dark navy text color */
        }
        .filter-container input:focus {
            outline: none;
            border-color: #f39c12; /* Gold border on focus */
            box-shadow: 0 0 5px rgba(243, 156, 18, 0.5); /* Gold shadow on focus */
        }
        table {
            width: 90%;
            max-width: 1000px;
            margin: 20px auto; /* Centered table */
            border-collapse: collapse; /* Remove spacing between cells */
            background-color: #fff; /* White background for the table */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            border-radius: 8px; /* Rounded corners for the table */
        }
        th, td {
            padding: 12px 15px; /* Padding for cells */
            text-align: left; /* Align text to the left */
            border-bottom: 1px solid #ddd; /* Light gray border for rows */
        }
        th {
            background-color: #2c3e50; /* Dark background for headers */
            color: white; /* White text for headers */
            font-weight: bold;
            border-bottom: 2px solid #fff; /* White bottom border for headers */
        }
        tr:nth-child(even) {
            background-color: #f9f9f9; /* Alternating row colors for readability */
        }
        tr:hover {
            background-color: #f1f4f9; /* Light highlight on row hover */
        }
        
         .btn-generate {
        background-color: #2c3e50; /* Dark slate background matching navbar */
        color: white; /* White text color */
        border: none; /* Remove default border */
        padding: 10px 20px; /* Add padding for a larger button */
        font-size: 16px; /* Font size matching input fields */
        border-radius: 5px; /* Rounded corners */
        cursor: pointer; /* Pointer cursor on hover */
        transition: background-color 0.3s ease, box-shadow 0.3s ease; /* Smooth transition */
    }

    .btn-generate:hover {
        background-color: #f39c12; /* Gold color on hover */
        box-shadow: 0 4px 8px rgba(243, 156, 18, 0.4); /* Subtle shadow on hover */
    }
    </style>
</head>
<body>

<%
    // Redirect to Home if admin is not logged in
 /*   if (session.getAttribute("adminName") == null) {
        response.sendRedirect("Home.jsp");
    } else {
        String adminName = (String) session.getAttribute("adminName");
        */
%>

<%
    HttpSession adminsession = request.getSession(false);
    if (adminsession == null || adminsession.getAttribute("adminName") == null) {
        response.sendRedirect("Home.jsp");
        return;
    }
%>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="AdminHome.jsp" style="text-decoration: none">Aurionpro</a>
    </div>
</nav>

<h1>Customer List</h1>

<div class="filter-container">
    <input type="text" id="searchInput" placeholder="Search customers..." onkeyup="filterTable()">
    <div class="amount-filter">
        <input type="number" id="minBalanceInput" placeholder="Minimum Balance" onkeyup="filterTable()">
        <input type="number" id="maxBalanceInput" placeholder="Maximum Balance" onkeyup="filterTable()">
    </div>
</div>

<table id="customerTable">
    <thead>
        <tr>
            <th>Id</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Account Number</th>
            <th>Balance</th>
            <th>Generate Account</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="customer" items="${customers}">
            <tr>
                <td>${customer.getCustomerId()}</td>
                <td>${customer.getFirstName()}</td>
                <td>${customer.getLastName()}</td>
                <td>${customer.getEmail()}</td>
                <td>${customer.getAccountNumber()}</td>
                <td class="balance">${customer.getBalance()}</td>
                <td>  
                   <form action="getCustomerDetailsController" method="post">
         
                      <input type="hidden" id="customerId" name="customerId" value="${customer.getCustomerId()}" required>
                       <button type="submit" class="btn btn-generate">Generate Account</button>
                   </form>
                 </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<%
  //  }
%>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function filterTable() {
        var searchInput, filter, table, tr, td, i, j, txtValue;
        var minBalanceInput = document.getElementById('minBalanceInput').value;
        var maxBalanceInput = document.getElementById('maxBalanceInput').value;
        var minBalance = parseFloat(minBalanceInput) || 0; // Minimum balance or 0 if empty
        var maxBalance = parseFloat(maxBalanceInput) || Infinity; // Maximum balance or Infinity if empty

        searchInput = document.getElementById('searchInput');
        filter = searchInput.value.toLowerCase();
        table = document.getElementById('customerTable');
        tr = table.getElementsByTagName('tr');

        for (i = 1; i < tr.length; i++) { // Start at 1 to skip the header row
            tr[i].style.display = 'none'; // Hide the row by default
            td = tr[i].getElementsByTagName('td');
            var balance = parseFloat(td[5].textContent) || 0; // Get the balance value

            if (balance >= minBalance && balance <= maxBalance) {
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
