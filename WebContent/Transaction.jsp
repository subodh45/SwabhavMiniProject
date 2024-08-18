<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Transaction Page</title>
<style>
body {
    background-color: #ecf0f1; /* Light gray background */
    font-family: Arial, sans-serif; /* Modern, clean font */
    margin: 0;
    padding: 0;
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

.navbar a {
    color: #ecf0f1; /* Light gray color for the links */
    font-size: 18px; /* Consistent font size */
    text-decoration: none; /* Remove underline */
    margin-right: 15px; /* Space between links */
}

.navbar a:hover {
    color: #f39c12; /* Gold color on hover */
}

.navbar .actions {
    display: flex;
    align-items: center;
}

.navbar .actions input[type="submit"],
.navbar .actions button {
    background-color: #2c3e50; /* Dark navy background */
    color: white;
    font-size: 18px; /* Consistent font size */
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
    max-width: 800px;
    margin: 50px auto; /* Center align the container */
    padding: 20px;
    background-color: #ffffff;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    text-align: center;
}

.container h1 {
    color: #2c3e50; /* Dark navy for headers */
    margin-bottom: 20px;
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
    background-color: #1e2a38; /* Dark slate background */
    color: white;
    border: none;
    cursor: pointer;
    margin: 15px auto;
    transition: background-color 0.3s, transform 0.3s;
}

.button:hover {
    background-color: #2c3e50; /* Slightly lighter shade on hover */
}

.message-success {
    color: #27ae60; /* Green for success messages */
    font-size: 18px;
}

.message-error {
    color: #e74c3c; /* Red for error messages */
    font-size: 18px;
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
         <form action="ViewPassport.jsp" method="post" >	        
	        <button  >Passbook</button>
         </form>
       <form action="CustomerLogoutController" method="post">
            <input type="submit" value="Logout" name="logout" />
        </form>
   </div>
</div>

<div class="container">
    <% if(request.getAttribute("CreditSuccess") != null) { 
        String message = (String) request.getAttribute("CreditSuccess"); %>
        <h3 class="message-success"><%= message %></h3>
    <% } %>

    <% if(request.getAttribute("DebitSuccess") != null) {
        String message = (String) request.getAttribute("DebitSuccess"); %>
        <h3 class="message-success"><%= message %></h3>
    <% } %>

    <% if(request.getAttribute("DebitFailed") != null) {
        String message = (String) request.getAttribute("DebitFailed"); %>
        <h3 class="message-error"><%= message %></h3>
    <% } %>
    
      <% if(request.getAttribute("TransferSuccess") != null) {
        String message = (String) request.getAttribute("TransferSuccess"); %>
        <h3 class="message-success"><%= message %></h3>
    <% } %>
    
      <% if(request.getAttribute("TransferFailed") != null) {
        String message = (String) request.getAttribute("TransferFailed"); %>
        <h3 class="message-error"><%= message %></h3>
    <% } %>

    
   
        <h1>Select Transaction:</h1>
        <form action="CreditMoney.jsp" method="post">
            <input type="hidden" name="accountNumber" value="">
            <button class="button">Credit Money</button>
        </form>

        <form action="DebitMoney.jsp" method="post">
            <input type="hidden" name="accountNumber" >
            <button class="button">Debit Money</button>
        </form>

        <form action="TransferMoney.jsp" method="post">
            <input type="hidden" name="accountNumber" >
            <button class="button">Transfer Money</button>
        </form>
</div>

</body>
</html>
