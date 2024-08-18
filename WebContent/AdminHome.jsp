<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Home</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f1f4f9; /* Light grayish-blue background for a professional look */
            font-family: Arial, sans-serif; /* Clean and modern font */
        }
        .navbar {
            background-color: #2c3e50; /* Dark slate background for the navbar */
            padding: 10px 20px; /* Padding for a cleaner look */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            position: sticky; /* Stick to the top */
            top: 0;
            z-index: 1000; /* Ensure it stays above other content */
            display: flex; /* Use flexbox for alignment */
            justify-content: space-between; /* Space between the brand and the links */
            align-items: center; /* Center items vertically */
        }
        .navbar .navbar-brand {
            color: #f39c12; /* Gold color for the brand name */
            font-size: 26px;
            font-weight: bold;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: color 0.3s ease;
        }
        .navbar .navbar-brand:hover {
            color: #f7c14d; /* Lighter gold on hover */
        }
        .navbar .navbar-nav {
            margin-left: auto; /* Pushes the nav items to the right */
        }
        .navbar .btn-logout {
            background-color: #2c3e50; /* Dark navy background for the button */
            color: white;
            font-weight: bold;
            padding: 6px 16px; /* Padding for a balanced appearance */
            border: none; /* Remove border */
            border-radius: 20px; /* Rounded corners for a modern feel */
            font-size: 18px;
            text-transform: uppercase;
            transition: background-color 0.3s ease, transform 0.3s ease;
            margin-left: 15px; /* Space between the logout button and other items */
        }
        .navbar .btn-logout:hover {
            background-color: #f39c12; /* Gold color on hover */
            transform: translateY(-2px); /* Slight upward movement on hover */
        }
        .container {
            max-width: 700px;
            margin: 60px auto;
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1); /* Stronger shadow for depth */
            border-radius: 10px;
            text-align: center;
        }
        h1 {
            font-size: 28px;
            color: #1e2a38;
            margin-bottom: 20px;
            font-weight: bold;
        }
        h2 {
            color: #28a745; /* Green color for success messages */
            margin-bottom: 20px;
        }
        button {
            background-color: #1e2a38; /* Dark slate background for buttons */
            color: white;
            border: none;
            width: 100%;
            padding: 12px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.3s ease;
            margin-top: 15px;
        }
        button:hover {
            background-color: #2c3e50; /* Slightly lighter shade on hover */
            transform: translateY(-2px); /* Slight upward movement on hover */
        }
        footer {
            margin-top: 50px;
            padding: 20px;
            background-color: #2c3e50; /* Dark slate background for footer */
            color: white;
            text-align: center;
            font-size: 14px;
        }
    </style>
</head>
<body>

<%
/*
    // Redirect to Home if admin is not logged in
    if (session.getAttribute("adminName") != null) {
        
    } else {
    	response.sendRedirect("Home.jsp");
    }
*/
%>

<%
    HttpSession adminsession = request.getSession(false);
    if (adminsession == null || adminsession.getAttribute("adminName") == null) {
        response.sendRedirect("Home.jsp");
        return;
    }
%>

<nav class="navbar">
    <a class="navbar-brand" href="#" style="text-decoration: none;">Aurionpro</a>
    <div class="d-flex ms-auto">
        <form action="AdminLogoutController"  method="post" >
            <button type="submit" class="btn-logout" name="logout">Logout</button>
        </form>
    </div>
</nav>

<div class="container">
    <%
        // Display success message if available
        if (request.getAttribute("success") != null) {
            String message = (String) request.getAttribute("success");
    %>
    <h2><%= message %></h2>
    <%
        }
    %>

    <h1>Welcome to the Admin Portal!</h1>

    <form action="AddCustomer.jsp">
        <button type="submit">Add New Customer</button>
    </form>
    <form action="AddAccount.jsp">
        <button type="submit">Add New Bank Account</button>
    </form>
    <form action="getAllCustomers" method="post">
        <button type="submit">View Customers</button>
    </form>
    <form action="TransactionController" method="post">
        <button type="submit">View Transactions</button>
    </form>
</div>

<footer>
    &copy; 2024 Aurionpro Bank Services. All rights reserved.
</footer>



<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
