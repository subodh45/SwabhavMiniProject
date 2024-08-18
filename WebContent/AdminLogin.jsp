<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Soft light gray background */
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
        .login-container {
            max-width: 400px;
            margin: 80px auto;
            padding: 40px;
            background-color: #ffffff;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1); /* Stronger shadow for more depth */
            border-radius: 10px;
        }
        h1 {
            font-size: 28px;
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-weight: bold;
        }
        .form-label {
            font-size: 16px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 10px;
            display: block;
        }
        
        .form-control {
            width: 100%;
            border-radius: 5px;
            border: 1px solid #ced4da;
            padding: 10px;
            font-size: 16px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-control:focus {
            border-color: #f39c12; /* Gold border on focus */
            box-shadow: 0 0 5px rgba(243, 156, 18, 0.5); /* Subtle glow effect on focus */
        }
        .btn-primary {
            background-color: #f39c12;
            border: none;
            width: 100%;
            padding: 12px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.3s ease;
            margin-top: 20px;
        }
        .btn-primary:hover {
            background-color: #f7c14d; /* Lighter gold on hover */
            transform: translateY(-2px); /* Slight upward movement on hover */
        }
        .form-text {
            font-size: 14px;
            color: #6c757d;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#"  style="text-decoration: none">Aurionpro</a>
    </div>
</nav>

<div class="login-container">
    <h1>Admin Login</h1>
    <form action='AdminLoginController' method='post'>
        <label for="adminname" class="form-label">Admin Name</label>
        <input type='text' id="adminname" name='adminname' class="form-control" required>
        
        <label for="password" class="form-label">Password</label>
        <input type='password' id="password" name='password' class="form-control" required>
        
        <button type="submit" class="btn btn-primary">Login</button>
        
    </form>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
