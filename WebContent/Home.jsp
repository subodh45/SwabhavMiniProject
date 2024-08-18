<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
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
        .navbar-nav {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%; /* Center align the nav items */
        }
        .nav-link {
            color: #ecf0f1; /* Light gray for the links */
            font-size: 18px;
            margin-left: 20px;
            padding: 8px 20px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .nav-link:hover {
            background-color: #f39c12; /* Gold background on hover */
            color: #2c3e50; /* Navy text color on hover */
            border-radius: 5px; /* Slight rounding for a polished look */
        }
        .nav-item:first-child .nav-link {
            margin-left: 0; /* No margin for the first item */
        }
        .hero-section {
            background-color: #34495e; /* Slightly lighter navy for the hero section */
            color: white;
            padding: 110px 0;
            text-align: center;
            
                    }
        .hero-section h1 {
            font-size: 3rem;
        }
        .hero-section p {
            font-size: 1.25rem;
        }
        .footer {
            background-color: #2c3e50; /* Matching dark navy for the footer */
            color: white;
            padding: 20px 0;
            text-align: center;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand mx-auto" href="#" style="text-decoration: none;">Aurionpro</a> <!-- Centered logo -->
       
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link" href="AdminLogin.jsp" style="text-decoration: none;">Admin Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="CustomerLogin.jsp" style="text-decoration: none;">Customer Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" style="text-decoration: none;">Contact Us</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" style="text-decoration: none;">About Us</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<section class="hero-section">
    <div class="container">
        <h1>Welcome to Aurionpro Bank Services</h1>
        <p>Your one-stop solution for all banking needs.</p>
    </div>
</section>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <!-- Removed button forms and replaced with navbar links -->
        </div>
    </div>
</div>

<footer class="footer">
    <p>&copy; 2024 Aurionpro Bank Services. All rights reserved.</p>
</footer>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
