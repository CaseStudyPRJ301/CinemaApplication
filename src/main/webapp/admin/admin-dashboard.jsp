<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Cinema Management</title>
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
        
        .welcome-section {
            background: linear-gradient(135deg, #eb315a, #c340ca);
            color: white;
            padding: 30px;
            border-radius: 15px;
            margin: 30px;
            box-shadow: 0 10px 30px rgba(235,49,90,0.3);
        }
        
        .welcome-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .welcome-subtitle {
            font-size: 16px;
            opacity: 0.9;
            margin-bottom: 5px;
        }
        
        .welcome-role {
            font-size: 14px;
            opacity: 0.8;
        }
        
        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            padding: 30px;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #1a1d29 0%, #13151f 100%);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.05);
            transition: transform 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            background: linear-gradient(135deg, #eb315a, #c340ca);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: white;
            margin-bottom: 15px;
        }
        
        .stat-number {
            font-size: 32px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #b6b7b9;
            font-size: 14px;
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
            font-size: 24px;
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
        }
        
        .data-table {
            background: linear-gradient(135deg, #1a1d29 0%, #13151f 100%);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
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
        }
        
        .table td {
            padding: 15px 18px;
            border-color: rgba(255,255,255,0.1);
            border-top: 1px solid rgba(255,255,255,0.1);
        }
        
        .table tbody tr:hover {
            background: rgba(235,49,90,0.1);
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
        
        /* Responsive */
        @media (max-width: 768px) {
            .admin-sidebar {
                width: 100%;
                transform: translateX(-100%);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
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
                 <a href="${pageContext.request.contextPath}/admin" class="nav-link active">
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
                 <a href="${pageContext.request.contextPath}/admin?action=manage-employees" class="nav-link">
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
            <h1 style="color: #fff; margin: 0; font-size: 24px;">Cinema Management System</h1>
                         <a href="${pageContext.request.contextPath}/cinema?action=logout" class="btn-logout">Logout</a>
        </div>
        
                 <!-- Welcome Section -->
         <div class="welcome-section">
             <div class="welcome-title">Welcome Back!</div>
             <div class="welcome-subtitle">Admin Name</div>
             <div class="welcome-role">Role: Admin</div>
         </div>
        
                 <!-- Stats Grid -->
         <div class="stats-grid">
             <div class="stat-card">
                 <div class="stat-icon">
                     <i class="bi bi-people"></i>
                 </div>
                 <div class="stat-number">150</div>
                 <div class="stat-label">Customers</div>
             </div>
             <div class="stat-card">
                 <div class="stat-icon">
                     <i class="bi bi-person-badge"></i>
                 </div>
                 <div class="stat-number">25</div>
                 <div class="stat-label">Employees</div>
             </div>
             <div class="stat-card">
                 <div class="stat-icon">
                     <i class="bi bi-film"></i>
                 </div>
                 <div class="stat-number">320</div>
                 <div class="stat-label">Movies</div>
             </div>
             <div class="stat-card">
                 <div class="stat-icon">
                     <i class="bi bi-ticket-perforated"></i>
                 </div>
                 <div class="stat-number">89</div>
                 <div class="stat-label">Tickets Sold</div>
             </div>
         </div>
        
    </div>
</body>
</html>
