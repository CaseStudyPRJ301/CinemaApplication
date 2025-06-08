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
    <a href="${pageContext.request.contextPath}/?action=logout" class="btn btn-danger logout-btn">Đăng xuất</a>
    <h1>Welcome to Employee Dashboard</h1>
    <p>Đây là trang dành riêng cho nhân viên.</p>
</body>
</html> 