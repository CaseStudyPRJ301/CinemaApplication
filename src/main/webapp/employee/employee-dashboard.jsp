<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard - Cinema Management</title>
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
        .employee-sidebar {
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
        
        .employee-avatar {
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
        
        .employee-name {
            color: #fff;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .employee-email {
            color: #b6b7b9;
            font-size: 14px;
            margin-bottom: 8px;
        }
        
        .employee-role {
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
        
        /* Quick Actions */
        .quick-actions {
            padding: 30px;
        }
        
        .section-title {
            font-size: 24px;
            font-weight: 600;
            color: #fff;
            margin-bottom: 20px;
        }
        
        .action-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .action-card {
            background: linear-gradient(135deg, #1a1d29 0%, #13151f 100%);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.05);
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            border-color: rgba(235,49,90,0.3);
            text-decoration: none;
            color: inherit;
        }
        
        .action-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            background: linear-gradient(135deg, #eb315a, #c340ca);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
            margin-bottom: 15px;
        }
        
        .action-title {
            font-size: 18px;
            font-weight: 600;
            color: #fff;
            margin-bottom: 8px;
        }
        
        .action-description {
            color: #b6b7b9;
            font-size: 14px;
            line-height: 1.5;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .employee-sidebar {
                width: 100%;
                transform: translateX(-100%);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .action-cards {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="employee-sidebar">
        <div class="sidebar-header">
            <div class="employee-avatar">E</div>
            <div class="employee-name">Employee Name</div>
            <div class="employee-email">employee@cinema.com</div>
            <div class="employee-role">Employee</div>
        </div>
        
        <nav class="sidebar-nav">
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/cinema" class="nav-link">
                    <i class="bi bi-house nav-icon"></i>
                    Home
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/employee" class="nav-link active">
                    <i class="bi bi-speedometer2 nav-icon"></i>
                    Dashboard
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/employee?action=manage-customers" class="nav-link">
                    <i class="bi bi-people nav-icon"></i>
                    Manage Customers
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
            <h1 style="color: #fff; margin: 0; font-size: 24px;">Employee Dashboard - Cinema Management</h1>
        </div>
        
        <!-- Welcome Section -->
        <div class="welcome-section">
            <div class="welcome-title">Welcome Back!</div>
            <div class="welcome-subtitle">Employee Name</div>
            <div class="welcome-role">Role: Customer Service Employee</div>
        </div>
        
        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="bi bi-people"></i>
                </div>
                <div class="stat-number">150</div>
                <div class="stat-label">Total Customers</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="bi bi-person-check"></i>
                </div>
                <div class="stat-number">45</div>
                <div class="stat-label">Active Customers</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="bi bi-calendar-check"></i>
                </div>
                <div class="stat-number">12</div>
                <div class="stat-label">New This Month</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="bi bi-star"></i>
                </div>
                <div class="stat-number">4.8</div>
                <div class="stat-label">Customer Rating</div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="quick-actions">
            <h2 class="section-title">Quick Actions</h2>
            <div class="action-cards">
                <a href="${pageContext.request.contextPath}/employee?action=manage-customers" class="action-card">
                    <div class="action-icon">
                        <i class="bi bi-people"></i>
                    </div>
                    <div class="action-title">Manage Customers</div>
                    <div class="action-description">View, search, and manage customer information. Handle customer inquiries and support requests.</div>
                </a>
                <a href="${pageContext.request.contextPath}/employee?action=view-customer-history" class="action-card">
                    <div class="action-icon">
                        <i class="bi bi-clock-history"></i>
                    </div>
                    <div class="action-title">Customer History</div>
                    <div class="action-description">View customer booking history, preferences, and past interactions for better service.</div>
                </a>
                <a href="${pageContext.request.contextPath}/employee?action=customer-support" class="action-card">
                    <div class="action-icon">
                        <i class="bi bi-headset"></i>
                    </div>
                    <div class="action-title">Customer Support</div>
                    <div class="action-description">Handle customer complaints, refunds, and provide assistance with booking issues.</div>
                </a>
            </div>
        </div>
    </div>
</body>
</html> 