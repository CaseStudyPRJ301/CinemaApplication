<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 6/8/2025
  Time: 9:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Dashboard</title>
    <style>
        .logout-btn {
            position: absolute;
            top: 20px;
            right: 30px;
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/?action=logout" class="btn btn-danger logout-btn">Đăng xuất</a>
    <h1>Welcome to User Dashboard</h1>
    <p>Đây là trang dành riêng cho khách hàng.</p>
</body>
</html>
