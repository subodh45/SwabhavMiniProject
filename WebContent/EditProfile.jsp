<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer Profile</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f1f4f9;
            font-family: Arial, sans-serif;
        }
        .navbar {
            background-color: #2c3e50;
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar-brand {
            color: #f39c12;
            font-size: 26px;
            font-weight: bold;
            
        }
        .navbar .nav-links {
            display: flex;
            align-items: center;
        }
        .nav-link {
            color: #ecf0f1;
            font-size: 18px;
            margin-left: 15px;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .nav-link:hover {
            color: #f39c12;
        }
        .btn-logout {
            background-color: #2c3e50;
            color: white;
            font-size: 18px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
        }
        .btn-logout:hover {
            background-color: #f39c12;
        }
        .container {
            max-width: 600px;
            margin: 60px auto;
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        h1 {
            font-size: 28px;
            color: #2c3e50;
            margin-bottom: 20px;
            font-weight: bold;
            text-align: center;
        }
        label {
            font-size: 16px;
            color: #34495e;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .error {
            color: red;
            font-size: 14px;
        }
        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #1e2a38;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
            margin-top: 15px;
        }
        button[type="submit"]:hover {
            background-color: #2c3e50;
            transform: translateY(-2px);
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

<% 
    // Redirect if the session is invalid
 /*   if (session.getAttribute("emailSession") == null) {
        response.sendRedirect("Home.jsp");
    } */
%>

<nav class="navbar">
    <a class="navbar-brand" href="CustomerHome.jsp" style="text-decoration: none">Aurionpro</a>
    <div class="nav-links">
       
        <form method="post" style="display:inline;" action="CustomerLogoutController">
            <input type="submit" class="btn-logout" value="Logout" name="logout" />
        </form>
    </div>
</nav>

<div class="container">
    <h1>Edit Profile</h1>
    <form action="UpdateCustomerProfileController" method="post">
        <div class="form-group">
            <label for="firstname">First Name:</label>
            <input type="text" id="firstname" name="firstname" value="<% out.println((String)request.getParameter("firstName")); %>" readonly>
        </div>
        <div class="form-group">
            <label for="lastname">Last Name:</label>
            <input type="text" id="lastname" name="lastname" value="<% out.println((String)request.getParameter("lastName"));%>" readonly>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%out.println((String)request.getParameter("email")); %>" readonly>
        </div>
        <div class="form-group">
            <label for="password">Enter Old Password:</label>
            <input type="password" id="oldPassword" name="oldPassword" required>
        </div>
         <div class="form-group">
            <label for="password">enter new Password:</label>
            <input type="password" id="newPassword" name="newPassword" required>
        </div>
        <div class="error">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
        </div>
        <button type="submit">Update Profile</button>
    </form>
</div>



<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
