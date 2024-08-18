<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recent Transactions</title>
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
        h1 {
            text-align: center;
            margin-top: 20px;
            font-size: 28px;
            color: #2c3e50; /* Dark slate color for the heading */
        }
        .filter-container {
            width: 90%;
            max-width: 1000px;
            margin: 20px auto; /* Centered filter fields */
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .filter-container input[type="text"] {
            width: 32%; /* 3 fields side by side */
            padding: 10px;
            border: 1px solid #2c3e50; /* Border color matching navbar */
            border-radius: 5px;
            font-size: 16px;
            background-color: #ecf0f1; /* Light gray background */
            color: #2c3e50; /* Dark navy text color */
        }
        .filter-container input[type="text"]:focus {
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
    </style>
</head>
<body>

<%
    HttpSession adminsession = request.getSession(false);
    if (adminsession == null || adminsession.getAttribute("adminName") == null) {
        response.sendRedirect("Home.jsp");
        return;
    }
%>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand"  style="text-decoration: none" href="AdminHome.jsp">Aurionpro</a>
    </div>
</nav>

<h1>Recent Transactions</h1>

<div class="filter-container">
    <input type="text" id="searchInput" placeholder="Search transactions..." onkeyup="filterTable()">
    <input type="text" id="minBalance" placeholder="Min Balance" onkeyup="filterTableByBalance()">
    <input type="text" id="maxBalance" placeholder="Max Balance" onkeyup="filterTableByBalance()">
</div>

<table id="transactionTable">
    <thead>
        <tr>
            <th>Id</th>
            <th>Sender Number</th>
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

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function filterTable() {
        var input, filter, table, tr, td, i, j, txtValue;
        input = document.getElementById('searchInput');
        filter = input.value.toLowerCase();
        table = document.getElementById('transactionTable');
        tr = table.getElementsByTagName('tr');

        for (i = 1; i < tr.length; i++) { // Start at 1 to skip the header row
            tr[i].style.display = 'none'; // Hide the row by default
            td = tr[i].getElementsByTagName('td');
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

    function filterTableByBalance() {
        var minBalance, maxBalance, table, tr, td, i, amountValue;
        minBalance = parseFloat(document.getElementById('minAmount').value) || 0;
        maxBalance = parseFloat(document.getElementById('maxAmount').value) || Infinity;
        table = document.getElementById('transactionTable');
        tr = table.getElementsByTagName('tr');

        for (i = 1; i < tr.length; i++) { // Start at 1 to skip the header row
            tr[i].style.display = 'none'; // Hide the row by default
            td = tr[i].getElementsByClassName('amount')[0]; // Assuming the amount is in the 5th column
            if (td) {
                amountValue = parseFloat(td.textContent || td.innerText);
                if (amountValue >= minBalance && amountValue <= maxBalance) {
                    tr[i].style.display = ''; // Show the row if it falls within the range
                }
            }
        }
    }
</script>

</body>
</html>
