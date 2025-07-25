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
            display: flex;
            flex-direction: column;
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
            flex: 1;
            display: flex;
            flex-direction: column;
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
        
        /* Logout specific styling */
        .logout-nav {
            color: #ff6b6b !important;
        }
        
        .logout-nav:hover {
            background: rgba(255, 107, 107, 0.1) !important;
            border-left-color: #ff6b6b !important;
            color: #fff !important;
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
        
        /* Header */
        .content-header {
            background: linear-gradient(135deg, #1a1d29, #13151f);
            padding: 30px 40px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .breadcrumb-nav {
            color: #b6b7b9;
            font-size: 14px;
            margin-top: 8px;
        }
        
        .breadcrumb-nav a {
            color: #eb315a;
            text-decoration: none;
        }
        
        .breadcrumb-nav span {
            margin: 0 8px;
        }
        
        /* Content Section */
        .content-section {
            padding: 40px;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .section-title {
            color: #fff;
            font-size: 24px;
            font-weight: 600;
            margin: 0;
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
        
        /* Data Table */
        .data-table {
            background: linear-gradient(135deg, #1a1d29, #13151f);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.1);
            overflow-x: auto;
        }
        
        .table {
            width: 100%;
            color: #b6b7b9;
            border-collapse: collapse;
            margin: 0;
        }
        
        .table thead th {
            background: rgba(235, 49, 90, 0.1);
            color: #fff;
            font-weight: 600;
            padding: 18px 15px;
            text-align: left;
            border: none;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid rgba(235, 49, 90, 0.3);
        }
        
        .table tbody td {
            padding: 15px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            vertical-align: middle;
        }
        
        .table tbody tr {
            transition: all 0.3s ease;
        }
        
        .table tbody tr:hover {
            background: rgba(235, 49, 90, 0.05);
            transform: translateY(-1px);
        }
        
        .employee-id {
            background: linear-gradient(90deg, #eb315a, #c340ca);
            color: white;
            padding: 4px 8px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
        }
        
        /* Action Buttons */
        .action-btn {
            display: inline-flex;
            align-items: center;
            padding: 8px 12px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            margin-right: 8px;
        }
        
        .btn-edit {
            background: rgba(235, 49, 90, 0.15);
            color: #eb315a;
            border: 1px solid rgba(235, 49, 90, 0.3);
        }
        
        .btn-edit:hover {
            background: rgba(235, 49, 90, 0.25);
            color: #fff;
            text-decoration: none;
            transform: translateY(-2px);
        }
        
        .btn-delete {
            background: rgba(255, 71, 87, 0.15);
            color: #ff4757;
            border: 1px solid rgba(255, 71, 87, 0.3);
        }
        
        .btn-delete:hover {
            background: rgba(255, 71, 87, 0.25);
            color: #fff;
            text-decoration: none;
            transform: translateY(-2px);
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .empty-state i {
            font-size: 64px;
            color: #333;
            margin-bottom: 20px;
            display: block;
        }
        
        .empty-state h3 {
            color: #fff;
            font-size: 24px;
            margin-bottom: 10px;
        }
        
        .empty-state p {
            font-size: 16px;
            color: #666;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }
            
            .admin-sidebar {
                transform: translateX(-100%);
            }
            
            .content-section {
                padding: 20px;
            }
            
            .content-header {
                padding: 20px;
            }
        }
        
        /* Table Responsive */
        @media (max-width: 992px) {
            .data-table {
                overflow-x: auto;
            }
            
            .table {
                min-width: 800px;
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
                 <a href="${pageContext.request.contextPath}/admin?action=manage-employees" class="nav-link active">
                     <i class="bi bi-person-badge nav-icon"></i>
                     Manage Employees
                 </a>
             </div>
             <div class="nav-item">
                 <a href="${pageContext.request.contextPath}/admin?action=manage-customers" class="nav-link">
                     <i class="bi bi-people nav-icon"></i>
                     Manage Customers
                 </a>
             </div>
             <div class="nav-item">
                 <a href="${pageContext.request.contextPath}/admin?action=reports" class="nav-link">
                     <i class="bi bi-graph-up nav-icon"></i>
                     Reports
                 </a>
             </div>
             
             <!-- Logout at bottom -->
             <div class="nav-item" style="margin-top: auto; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 20px;">
                 <a href="${pageContext.request.contextPath}/cinema?action=logout" class="nav-link logout-nav">
                     <i class="bi bi-box-arrow-right nav-icon"></i>
                     Logout
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