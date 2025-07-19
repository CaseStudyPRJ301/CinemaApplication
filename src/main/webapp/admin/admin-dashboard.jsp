<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 6/8/2025
  Time: 9:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        .logout-btn {
            position: absolute;
            top: 20px;
            right: 30px;
        }
        .add-employee-btn {
            position: absolute;
            top: 20px;
            right: 150px;
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/admin?action=add-employee" class="btn btn-success add-employee-btn">Add Employee</a>
    <a href="${pageContext.request.contextPath}/cinema?action=logout" class="btn btn-danger logout-btn">Logout</a>
    <h1>Admin dashboard</h1>
    <h2>Employee List</h2>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Số điện thoại</th>
            <th>Email</th>
        </tr>
        <c:forEach var="emp" items="${employeeList}">
            <tr>
                <td>${emp.employeeId}</td>
                <td>${emp.name}</td>
                <td>${emp.phone}</td>
                <td>${emp.email}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
