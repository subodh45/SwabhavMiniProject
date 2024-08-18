<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.aurionpro.entity.*" %>
<%@ page import="com.aurionpro.model.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get Customer details</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
<style>
    body {
        background-color: #f1f4f9; /* Light grayish-blue background */
        font-family: Arial, sans-serif; /* Clean and modern font */
    }
    .navbar {
        background-color: #2c3e50; /* Dark slate background */
        padding: 10px 20px; /* Padding for a cleaner look */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        position: sticky; /* Stick to the top */
        top: 0;
        z-index: 1000; /* Stay above other content */
    }
    .navbar-brand {
        color: #f39c12; /* Gold color for the brand name */
        font-size: 22px;
        font-weight: bold;
        letter-spacing: 1px;
        text-transform: uppercase;
        transition: color 0.3s ease;
    }
    .navbar-brand:hover {
        color: #f7c14d; /* Lighter gold on hover */
    }
    .container {
        max-width: 600px;
        margin: 60px auto;
        padding: 30px;
        background-color: #ffffff;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1); /* Stronger shadow for depth */
        border-radius: 10px;
    }
    h1 {
        font-size: 24px;
        color: #1e2a38;
        margin-bottom: 20px;
        font-weight: bold;
        text-align: center;
    }
    input[type="number"] {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    button {
        background-color: #1e2a38; /* Dark slate background for buttons */
        color: white;
        border: none;
        width: 100%;
        padding: 12px;
        font-size: 16px;
        font-weight: bold;
        border-radius: 5px;
        transition: background-color 0.3s ease, transform 0.3s ease;
    }
    button:hover {
        background-color: #2c3e50; /* Slightly lighter shade on hover */
        transform: translateY(-2px); /* Slight upward movement on hover */
    }
</style>
</head>
<body>

<%
/*
if(session.getAttribute("adminName")!= null) {
    String adminName= (String)session.getAttribute("adminName");
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

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="AdminHome.jsp" style="text-decoration: none">Aurionpro</a>
    </div>
</nav>

<div class="container">
    <h1>Get customer Details.</h1>
    <%
        if(session.getAttribute("message")!=null) {
            String message = (String)session.getAttribute("message");
            out.print("<p class='text-success'>" + message + "</p>");
        }
    %>
    <form action="getCustomerDetailsController" method="post">
        <label for="customerId">Enter Customer ID:</label>
        <input type="number" id="customerId" name="customerId" required>
        <button type="submit">Search</button>
    </form>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
