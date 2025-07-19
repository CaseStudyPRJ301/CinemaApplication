<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Employee Dashboard</title>
    <style>
        .logout-btn {
            position: absolute;
            top: 20px;
            right: 30px;
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/cinema?action=logout" class="btn btn-danger logout-btn">Logout</a>
    <h1>Welcome to Employee Dashboard</h1>
    <p>This is a page for employees only.</p>
</body>
</html> 