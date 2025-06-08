<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm nhân viên</title>
    <style>
        .form-container {
            max-width: 400px;
            margin: 60px auto;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background: #f9f9f9;
        }
        .form-container h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .btn {
            width: 100%;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Thêm nhân viên</h2>
    <form action="${pageContext.request.contextPath}/admin?action=add-employee" method="post">
        <div class="form-group">
            <label for="name">Tên nhân viên</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="phone">Số điện thoại</label>
            <input type="text" id="phone" name="phone" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="username">Tên đăng nhập</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Mật khẩu</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-success">Thêm nhân viên</button>
    </form>
</div>
</body>
</html> 