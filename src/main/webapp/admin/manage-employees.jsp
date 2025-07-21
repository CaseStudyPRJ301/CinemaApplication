<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Employees - Cinema Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: #13151f;
            color: #b6b7b9;
            overflow-x: hidden;
        }
        
        /* Sidebar Styles */
        .admin-sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: linear-gradient(135deg, #1a1d29 0%, #13151f 100%);
            box-shadow: 4px 0 15px rgba(0,0,0,0.3);
            z-index: 1000;
            transition: all 0.3s ease;
        }
        
        .sidebar-header {
            padding: 30px 25px 25px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .admin-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #eb315a, #c340ca);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: white;
            font-size: 36px;
            font-weight: 600;
        }
        
        .admin-name {
            color: #fff;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .admin-email {
            color: #b6b7b9;
            font-size: 14px;
            margin-bottom: 8px;
        }
        
        .admin-role {
            background: linear-gradient(90deg, #eb315a, #c340ca);
            color: white;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
        }
        
        /* Navigation Styles */
        .sidebar-nav {
            padding: 20px 0;
        }
        
        .nav-item {
            margin-bottom: 5px;
        }
        
        .nav-link {
            display: flex;
            align-items: center;
            padding: 15px 25px;
            color: #b6b7b9;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }
        
        .nav-link:hover,
        .nav-link.active {
            background: linear-gradient(90deg, rgba(235,49,90,0.15), transparent);
            border-left-color: #eb315a;
            color: #fff;
            text-decoration: none;
        }
        
        .nav-icon {
            width: 20px;
            height: 20px;
            margin-right: 15px;
            font-size: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        /* Main Content */
        .main-content {
            margin-left: 280px;
            min-height: 100vh;
            background: #13151f;
        }
        
        .content-header {
            background: linear-gradient(135deg, #1a1d29 0%, #13151f 100%);
            padding: 25px 30px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .breadcrumb-nav {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #b6b7b9;
            font-size: 14px;
        }
        
        .breadcrumb-nav a {
            color: #eb315a;
            text-decoration: none;
        }
        
        .breadcrumb-nav a:hover {
            color: #c340ca;
        }
        
        /* Table Styles */
        .content-section {
            padding: 30px;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        
        .section-title {
            font-size: 28px;
            font-weight: 600;
            color: #fff;
        }
        
        .btn-add {
            background: linear-gradient(135deg, #eb315a, #c340ca);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
        }
        
        .btn-add:hover {
            background: linear-gradient(135deg, #d12851, #a835b8);
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(235,49,90,0.4);
        }
        
        .data-table {
            background: linear-gradient(135deg, #1a1d29 0%, #13151f 100%);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.05);
        }
        
        .table {
            color: #b6b7b9;
            margin: 0;
        }
        
        .table th {
            background: linear-gradient(90deg, #eb315a, #c340ca);
            color: white;
            font-weight: 600;
            border: none;
            padding: 18px;
            font-size: 14px;
        }
        
        .table td {
            padding: 15px 18px;
            border-color: rgba(255,255,255,0.1);
            border-top: 1px solid rgba(255,255,255,0.1);
            vertical-align: middle;
        }
        
        .table tbody tr:hover {
            background: rgba(235,49,90,0.1);
        }
        
        .action-btn {
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .btn-edit {
            background: rgba(235,49,90,0.15);
            color: #eb315a;
            border: 1px solid rgba(235,49,90,0.3);
        }
        
        .btn-edit:hover {
            background: #eb315a;
            color: white;
            text-decoration: none;
        }
        
        .btn-delete {
            background: rgba(255,71,87,0.15);
            color: #ff4757;
            border: 1px solid rgba(255,71,87,0.3);
        }
        
        .btn-delete:hover {
            background: #ff4757;
            color: white;
            text-decoration: none;
        }
        
        /* Logout Button */
        .btn-logout {
            background: linear-gradient(135deg, #ff4757, #ff3838);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-logout:hover {
            background: linear-gradient(135deg, #ff3838, #ff2c2c);
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }
        
        .employee-id {
            font-weight: 600;
            color: #eb315a;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #b6b7b9;
        }
        
        .empty-state i {
            font-size: 64px;
            color: #eb315a;
            margin-bottom: 20px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .admin-sidebar {
                width: 100%;
                transform: translateX(-100%);
            }
            
            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="admin-sidebar">
        <div class="sidebar-header">
            <div class="admin-avatar">A</div>
            <div class="admin-name">Admin Name</div>
            <div class="admin-email">admin@cinema.com</div>
            <div class="admin-role">Admin</div>
        </div>
        
        <nav class="sidebar-nav">
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/cinema" class="nav-link">
                    <i class="bi bi-house nav-icon"></i>
                    Home
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin" class="nav-link">
                    <i class="bi bi-speedometer2 nav-icon"></i>
                    Dashboard
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin?action=manage-customers" class="nav-link">
                    <i class="bi bi-people nav-icon"></i>
                    Manage Customers
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin?action=manage-movies" class="nav-link">
                    <i class="bi bi-film nav-icon"></i>
                    Manage Movies
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin?action=manage-theaters" class="nav-link">
                    <i class="bi bi-building nav-icon"></i>
                    Manage Theaters
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin?action=manage-employees" class="nav-link active">
                    <i class="bi bi-person-badge nav-icon"></i>
                    Manage Employees
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin?action=manage-tickets" class="nav-link">
                    <i class="bi bi-ticket-perforated nav-icon"></i>
                    Manage Tickets
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin?action=reports" class="nav-link">
                    <i class="bi bi-graph-up nav-icon"></i>
                    Reports
                </a>
            </div>
        </nav>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="content-header">
            <div>
                <h1 style="color: #fff; margin: 0; font-size: 24px;">Employee Management</h1>
                <div class="breadcrumb-nav">
                    <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
                    <span>></span>
                    <span>Manage Employees</span>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/cinema?action=logout" class="btn-logout">Logout</a>
        </div>
        
        <!-- Employee Management Section -->
        <div class="content-section">
            <div class="section-header">
                <h2 class="section-title">Employee List</h2>
                <a href="${pageContext.request.contextPath}/admin?action=add-employee" class="btn-add">
                    <i class="bi bi-plus-circle me-2"></i>Add New Employee
                </a>
            </div>
            
            <div class="data-table">
                <c:choose>
                    <c:when test="${not empty employeeList}">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Employee Name</th>
                                    <th>Phone Number</th>
                                    <th>Email Address</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="emp" items="${employeeList}">
                                    <tr>
                                        <td>
                                            <span class="employee-id">#${emp.employeeId}</span>
                                        </td>
                                        <td>
                                            <strong style="color: #fff;">${emp.name}</strong>
                                        </td>
                                        <td>${emp.phone}</td>
                                        <td>${emp.email}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin?action=edit-employee&id=${emp.employeeId}" 
                                               class="action-btn btn-edit">
                                               <i class="bi bi-pencil-square"></i> Edit
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin?action=delete-employee&id=${emp.employeeId}" 
                                               class="action-btn btn-delete"
                                               onclick="return confirm('Are you sure you want to delete this employee?')">
                                               <i class="bi bi-trash"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="bi bi-person-x"></i>
                            <h3>No Employees Found</h3>
                            <p>There are no employees in the system yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>