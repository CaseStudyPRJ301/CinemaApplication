<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 6/7/2025
  Time: 6:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login & Sign Up</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <!-- VIETNAMESE FONT OVERRIDE - MUST BE LAST -->
    <link rel="stylesheet" href="css/vietnamese-font-override.css">
    
    <style>
        body, html {
            height: 100%;
            margin: 0;
        }

        .auth-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
        }

        .auth-form {
            max-width: 400px;
            width: 100%;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            background-color: #fff;
        }

        .auth-form h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .message {
            color: red;
            font-size: 0.9em;
            text-align: center;
            margin-top: 10px;
        }

        .toggle-form {
            text-align: center;
            margin-top: 15px;
        }

        .toggle-form a {
            color: #0d6efd;
            text-decoration: none;
            cursor: pointer;
        }

        .toggle-form a:hover {
            text-decoration: underline;
        }

        #signupForm {
            display: none;
        }
    </style>
</head>
<body>

<div class="auth-container">
    <div class="auth-form">
        <!-- Login Form -->
        <div id="loginForm">
            <h2>Login</h2>
            <form action="cinema?action=login" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Login</button>
                <div class="text-center mt-3">
                    <a onclick="toggleForms()">Don't have an account? <span style="color: #0d6efd; font-weight: bold;">Sign up</span> now</a>
                </div>
            </form>
        </div>

        <div id="signupForm" class="auth-form" style="display:none;">
            <h2>Sign Up</h2>
            <form action="cinema?action=signup" method="post" onsubmit="return validateSignupForm()">
                <div class="mb-3">
                    <label for="signupUsername" class="form-label">Username</label>
                    <input type="text" class="form-control" id="signupUsername" name="username" required>
                </div>
                <div class="mb-3">
                    <label for="signupPassword" class="form-label">Password</label>
                    <input type="password" class="form-control" id="signupPassword" name="password" required>
                </div>
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Sign Up</button>
                <div class="text-center mt-3">
                    <a onclick="toggleForms()">Already have an account? <span style="color: #0d6efd; font-weight: bold;">Login</span></a>
                </div>
            </form>
        </div>

        <c:if test="${not empty requestScope.message}">
            <p class="message">${requestScope.message}</p>
        </c:if>
    </div>
</div>

<script>
    function toggleForms() {
        const loginForm = document.getElementById('loginForm');
        const signupForm = document.getElementById('signupForm');
        
        if (loginForm.style.display === 'none') {
            loginForm.style.display = 'block';
            signupForm.style.display = 'none';
        } else {
            loginForm.style.display = 'none';
            signupForm.style.display = 'block';
        }
    }

    function validateSignupForm() {
        const password = document.getElementById('signupPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        
        if (password !== confirmPassword) {
            alert('Password confirmation does not match!');
            return false;
        }
        return true;
    }
</script>

</body>
</html>