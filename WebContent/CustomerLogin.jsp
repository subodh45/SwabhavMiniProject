<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login Page</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Light gray background */
            font-family: Arial, sans-serif; /* Clean and modern font */
        }
        .navbar {
            background-color: #2c3e50; /* Dark navy background for the navbar */
            padding: 15px 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Soft shadow for depth */
        }
        .navbar-brand {
            color: #f39c12; /* Gold color for the brand name */
            font-size: 26px;
            font-weight: bold;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: color 0.3s ease;
        }
        .navbar-brand:hover {
            color: #f7c14d; /* Lighter gold on hover */
        }
        .form-container {
            max-width: 400px; /* Max width for the form */
            margin: 5% auto; /* Center form horizontally and add top margin */
            padding: 20px;
            background-color: #ffffff; /* White background for the form */
            border: 2px solid #ced4da; /* Light gray border */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }
        .form-container h1 {
            font-size: 24px;
            color: #343a40; /* Dark gray color for the header */
            margin-bottom: 20px;
        }
        .form-container label {
            font-size: 16px;
            color: #495057; /* Medium gray for labels */
            display: block;
            margin-bottom: 8px;
        }
        .form-container input {
            width: 100%; /* Full width for input fields */
            height: 40px;
            font-size: 16px;
            border-radius: 5px; /* Rounded corners */
            padding-left: 10px;
            border: 1px solid #ced4da; /* Light gray border */
            margin-bottom: 15px; /* Space between inputs */
        }
        .form-container button {
            width: 100%; /* Full width for the button */
            height: 40px;
            font-size: 18px;
            font-weight: bold;
            background-color: #007bff; /* Blue background */
            color: white;
            border: none;
            border-radius: 5px; /* Rounded corners */
            transition: background-color 0.3s ease;
        }
        .form-container button:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#" style="text-decoration: none;">Aurionpro</a>
    </div>
</nav>

<div class="success">
     <% //request.getAttribute("successMessage") != null ? request.getAttribute("errorMessage") : "" %> 
</div>

<div class="form-container">
    <h1>Customer Login</h1>
    <form action="CustomerLoginController" method="post">
        <label for="email">Enter Your Email:</label>
        <input type="email" id="email" name="email" placeholder="test@gmail.com" pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Please enter a valid email" required>
        <label for="password">Password:</label>
       <input type="password" id="password" name="password" placeholder="enter password" required>
     <!--     <label for="accountNumber">accountNumber:</label>  
        <input type="number" id="accountNumber" name="accountNumber" placeholder="eg:92390" min="1" required> -->
        <button type="submit">Login</button>
    </form>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
