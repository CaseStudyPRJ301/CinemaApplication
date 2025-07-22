<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Details - Admin Dashboard</title>
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
        
        /* Customer Info Card */
        .customer-info-card {
            background: linear-gradient(135deg, #1a1d29, #13151f);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.1);
        }
        
        .customer-header {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
        }
        
        .customer-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #eb315a, #c340ca);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: 600;
            margin-right: 20px;
        }
        
        .customer-details h3 {
            color: #fff;
            font-size: 24px;
            margin-bottom: 5px;
        }
        
        .customer-id-badge {
            background: linear-gradient(90deg, #eb315a, #c340ca);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }
        
        .customer-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .info-item {
            background: rgba(255,255,255,0.05);
            padding: 15px;
            border-radius: 10px;
            border: 1px solid rgba(255,255,255,0.1);
        }
        
        .info-label {
            color: #b6b7b9;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }
        
        .info-value {
            color: #fff;
            font-size: 16px;
            font-weight: 500;
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
        
        .booking-id {
            background: linear-gradient(90deg, #eb315a, #c340ca);
            color: white;
            padding: 4px 8px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .ticket-count {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 10px;
            font-weight: 500;
            margin-left: 5px;
        }
        
        .total-amount {
            color: #fff;
            font-weight: 600;
            font-size: 14px;
        }
        
        .price-info {
            color: #4CAF50;
            font-size: 12px;
        }
        
        .seat-info {
            background: rgba(33, 150, 243, 0.15);
            color: #2196f3;
            padding: 4px 8px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .movie-info {
            background: rgba(76, 175, 80, 0.15);
            color: #4CAF50;
            padding: 4px 8px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 500;
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
        
        /* Back Button */
        .btn-back {
            background: linear-gradient(135deg, #eb315a, #c340ca);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
        }
        
        .btn-back:hover {
            background: linear-gradient(135deg, #d12851, #a835b8);
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
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
            
            .customer-info-grid {
                grid-template-columns: 1fr;
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
                <a href="${pageContext.request.contextPath}/admin?action=manage-employees" class="nav-link">
                    <i class="bi bi-person-badge nav-icon"></i>
                    Manage Employees
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin?action=manage-customers" class="nav-link active">
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
                <h1 style="color: #fff; margin: 0; font-size: 24px;">Customer Details</h1>
                <div class="breadcrumb-nav">
                    <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
                    <span>></span>
                    <a href="${pageContext.request.contextPath}/admin?action=manage-customers">Manage Customers</a>
                    <span>></span>
                    <span>Customer Details</span>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/admin?action=manage-customers" class="btn-back">
                <i class="bi bi-arrow-left"></i> Back to Customers
            </a>
        </div>
        
        <!-- Customer Details Section -->
        <div class="content-section">
            <!-- Customer Information -->
            <div class="customer-info-card">
                <div class="customer-header">
                    <div class="customer-avatar">${customer.name.charAt(0)}</div>
                    <div class="customer-details">
                        <h3>${customer.name}</h3>
                        <span class="customer-id-badge">#${customer.customerId}</span>
                    </div>
                </div>
                
                <div class="customer-info-grid">
                    <div class="info-item">
                        <div class="info-label">Phone Number</div>
                        <div class="info-value">${customer.phoneNumber}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Email Address</div>
                        <div class="info-value">${customer.email}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Member Since</div>
                        <div class="info-value">
                            <fmt:formatDate value="${customer.createdAt}" pattern="MMM dd, yyyy"/>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Total Tickets</div>
                        <div class="info-value">${ticketList.size()}</div>
                    </div>
                </div>
            </div>
            
            <!-- Booking History -->
            <div class="section-header">
                <h2 class="section-title">Booking History</h2>
            </div>
            
            <div class="data-table">
                <c:choose>
                    <c:when test="${not empty bookingGroups}">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Movie</th>
                                    <th>Theater</th>
                                    <th>Seats</th>
                                    <th>Showtime</th>
                                    <th>Booking Date</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="group" items="${bookingGroups}">
                                    <tr>
                                        <td>
                                            <span class="movie-info">${group.movieTitle}</span>
                                        </td>
                                        <td>${group.theaterName}</td>
                                        <td>
                                            <span class="seat-info">${group.seatPositions}</span>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${group.showtime}" pattern="MMM dd, yyyy HH:mm"/>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${group.bookingTime}" pattern="MMM dd, yyyy HH:mm"/>
                                        </td>
                                        <td>
                                            <span class="total-amount">${group.totalTickets} tickets</span>
                                            <br>
                                            <small class="price-info">${group.totalAmount} VND</small>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="bi bi-ticket-perforated"></i>
                            <h3>No Booking History</h3>
                            <p>This customer hasn't made any bookings yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html> 
</html> 