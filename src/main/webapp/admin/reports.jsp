<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - Cinema Management</title>
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
            border-radius: 0 25px 25px 0;
            margin-right: 20px;
        }
        
        .nav-link:hover {
            background: linear-gradient(90deg, rgba(235,49,90,0.1), rgba(195,64,202,0.1));
            color: #eb315a;
            text-decoration: none;
        }
        
        .nav-link.active {
            background: linear-gradient(90deg, #eb315a, #c340ca);
            color: white;
        }
        
        .nav-icon {
            margin-right: 12px;
            font-size: 18px;
        }
        
        /* Main Content */
        .main-content {
            margin-left: 280px;
            padding: 30px;
            min-height: 100vh;
        }
        
        .content-header {
            margin-bottom: 30px;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #1a1d29 0%, #13151f 100%);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.1);
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
        
        /* Report Sections */
        .report-section {
            background: linear-gradient(135deg, #1a1d29 0%, #13151f 100%);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.1);
        }
        
        .section-title {
            font-size: 24px;
            font-weight: 600;
            color: #fff;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }
        
        .section-title i {
            margin-right: 10px;
            color: #eb315a;
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
        
        /* Summary Cards */
        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .summary-card {
            background: linear-gradient(135deg, #2a2d39 0%, #1a1d29 100%);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            border: 1px solid rgba(255,255,255,0.1);
        }
        
        .summary-number {
            font-size: 28px;
            font-weight: 700;
            color: #eb315a;
            margin-bottom: 5px;
        }
        
        .summary-label {
            color: #b6b7b9;
            font-size: 14px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .admin-sidebar {
                transform: translateX(-100%);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .summary-grid {
                grid-template-columns: repeat(2, 1fr);
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
                <a href="${pageContext.request.contextPath}/admin?action=manage-employees" class="nav-link">
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
                <a href="${pageContext.request.contextPath}/admin?action=reports" class="nav-link active">
                    <i class="bi bi-graph-up nav-icon"></i>
                    Reports
                </a>
            </div>
            
            <!-- Logout at bottom -->
            <div class="nav-item" style="margin-top: auto; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 20px;">
                <a href="${pageContext.request.contextPath}/cinema?action=logout" class="nav-link">
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
            <h1 style="color: #fff; margin: 0; font-size: 28px;">📊 Cinema Reports & Analytics</h1>
            <p style="color: #b6b7b9; margin-top: 5px;">Comprehensive overview of cinema performance and statistics</p>
        </div>
        
        <!-- Key Statistics -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="bi bi-ticket-perforated"></i>
                </div>
                <div class="stat-number">${totalTickets}</div>
                <div class="stat-label">Total Tickets Sold</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="bi bi-currency-dollar"></i>
                </div>
                <div class="stat-number">
                    <fmt:formatNumber value="${totalRevenue}" pattern="#,##0" />
                </div>
                <div class="stat-label">Total Revenue (VND)</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="bi bi-people"></i>
                </div>
                <div class="stat-number">${totalCustomers}</div>
                <div class="stat-label">Total Customers</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="bi bi-film"></i>
                </div>
                <div class="stat-number">${totalMovies}</div>
                <div class="stat-label">Total Movies</div>
            </div>
        </div>
        
        <!-- Recent Bookings -->
        <div class="report-section">
            <h2 class="section-title">
                <i class="bi bi-clock-history"></i>
                Recent Bookings
            </h2>
            <div class="data-table">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Customer</th>
                            <th>Movie</th>
                            <th>Theater</th>
                            <th>Showtime</th>
                            <th>Seats</th>
                            <th>Total Amount</th>
                            <th>Booking Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${recentBookings}">
                            <tr>
                                <td>#${booking.bookingId}</td>
                                <td>${booking.customerName}</td>
                                <td>${booking.movieTitle}</td>
                                <td>${booking.theaterName}</td>
                                <td>
                                    <fmt:formatDate value="${booking.showtime}" pattern="dd/MM/yyyy HH:mm" />
                                </td>
                                <td>${booking.seats}</td>
                                <td>
                                    <fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0" /> VND
                                </td>
                                <td>
                                    <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy HH:mm" />
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- Bootstrap JS -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
</body>
</html> 