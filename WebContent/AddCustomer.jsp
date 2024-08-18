<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Customer Page</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Light background for better readability */
            font-family: Arial, sans-serif; /* Clean and modern font */
        }
        .navbar {
            background-color: #343a40; /* Dark background for navbar */
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .navbar-brand {
           color: #f39c12; /* Gold color for the brand name */
            font-size: 22px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for form container */
            border-radius: 10px;
        }
        h1 {
            font-size: 26px;
            color: #343a40; /* Dark color for heading */
            margin-bottom: 20px;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ced4da;
            border-radius: 5px;
            box-sizing: border-box;
        }
        button.primary {
            background-color: #007bff; /* Primary blue background for button */
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 18px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            cursor: pointer;
            width: 100%;
        }
        button.primary:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
    </style>
</head>
<body>

<%
  /*  if(session.getAttribute("adminName") != null) {
        String adminName = (String) session.getAttribute("adminName");
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
        <a class="navbar-brand" href="AdminHome.jsp" Style="text-decoration:none;">Aurionpro</a>
    </div>
</nav>

<div class="form-container">
    <h1>Add Customer</h1>
    
     <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
        <div class="alert alert-danger" style="color: red;">
            <%= errorMessage %>
        </div>
    <% } %>
    
   <form action="AddCustomerController" method="post">
    <label for="firstName">First Name:</label>
    <input type="text" id="firstName" name="firstName" placeholder="Enter first name" 
           pattern="^[a-zA-Z]+$" title="Enter alphabet characters only" required>

    <label for="lastName">Last Name:</label>
    <input type="text" id="lastName" name="lastName" placeholder="Enter last name" 
           pattern="^[a-zA-Z]+$" title="Enter alphabet characters only" required>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" placeholder="eg:subodhmagar@gmail.com" 
           pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Enter a valid email address" required>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" placeholder="Enter password" 
           pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$"
           title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 or more characters" required>

    <button class="primary" type="submit">Create Customer</button>
</form>
   
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
