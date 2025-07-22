<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    boolean isLoggedIn = (username != null && role != null);
    
    // Redirect to login if not authenticated
    if (!isLoggedIn) {
        response.sendRedirect("cinema?action=login&message=" + 
            java.net.URLEncoder.encode("You need to login to view your tickets!", "UTF-8"));
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Tickets - Cinema Application</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
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
        
        .my-tickets-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .page-header h1 {
            color: #eb315a;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .page-header p {
            color: #b6b7b9;
            font-size: 1.1rem;
        }
        
        .user-info {
            background: linear-gradient(135deg, #1a1d29 0%, #13151f 100%);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            border: 2px solid #eb315a;
        }
        
        .user-info h3 {
            color: #eb315a;
            margin-bottom: 15px;
        }
        
        .user-info p {
            margin: 5px 0;
            font-size: 1.1rem;
        }
        
        .role-badge {
            background: linear-gradient(90deg, #eb315a, #c340ca);
            color: white;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
        }
        
        .tickets-summary {
            background: #1a1d29;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            border: 1px solid #333;
        }
        
        .summary-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .stat-card {
            background: #2a2d3a;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            border: 1px solid #444;
        }
        
        .stat-number {
            color: #eb315a;
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #b6b7b9;
            font-size: 0.9rem;
        }
        
        .booking-groups {
            margin-top: 30px;
        }
        
        .booking-group {
            background: #1a1d29;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            border: 1px solid #333;
        }
        
        .group-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #333;
        }
        
        .group-title {
            color: #eb315a;
            font-size: 1.3rem;
            font-weight: 600;
        }
        
        .group-date {
            color: #b6b7b9;
            font-size: 1rem;
        }
        
        .group-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .summary-item {
            background: #2a2d3a;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }
        
        .summary-label {
            color: #b6b7b9;
            font-size: 0.8rem;
            margin-bottom: 5px;
        }
        
        .summary-value {
            color: #fff;
            font-size: 1.1rem;
            font-weight: 600;
        }
        
        .tickets-list {
            display: grid;
            gap: 15px;
        }
        
        .ticket-item {
            background: #2a2d3a;
            border-radius: 10px;
            padding: 20px;
            border: 1px solid #444;
            transition: all 0.3s ease;
        }
        
        .ticket-item:hover {
            border-color: #eb315a;
            transform: translateY(-2px);
        }
        
        .ticket-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .movie-title {
            color: #eb315a;
            font-size: 1.2rem;
            font-weight: 600;
        }
        
        .ticket-id {
            color: #b6b7b9;
            font-size: 0.9rem;
        }
        
        .ticket-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 15px;
        }
        
        .detail-item {
            text-align: center;
        }
        
        .detail-label {
            color: #b6b7b9;
            font-size: 0.8rem;
            margin-bottom: 5px;
        }
        
        .detail-value {
            color: #fff;
            font-size: 1rem;
            font-weight: 500;
        }
        
        .seat-badge {
            background: #eb315a;
            color: white;
            padding: 4px 8px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .price-badge {
            background: linear-gradient(90deg, #28a745, #20c997);
            color: white;
            padding: 4px 8px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .no-tickets {
            text-align: center;
            padding: 50px 20px;
            background: #1a1d29;
            border-radius: 15px;
            border: 1px solid #333;
        }
        
        .no-tickets i {
            font-size: 4rem;
            color: #eb315a;
            margin-bottom: 20px;
        }
        
        .no-tickets h3 {
            color: #eb315a;
            margin-bottom: 10px;
        }
        
        .no-tickets p {
            color: #b6b7b9;
            margin-bottom: 20px;
        }
        
        .back-btn {
            background: #eb315a;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s;
            display: inline-block;
        }
        
        .back-btn:hover {
            background: #d12851;
            color: white;
            text-decoration: none;
        }
        
        .buy-tickets-btn {
            background: linear-gradient(90deg, #eb315a, #c340ca);
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s;
            display: inline-block;
            margin-left: 10px;
        }
        
        .buy-tickets-btn:hover {
            background: linear-gradient(90deg, #d12851, #b23bb8);
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="my-tickets-container">
        <div class="page-header">
            <h1><i class="icofont icofont-ticket"></i> My Tickets</h1>
            <p>View your booking history and ticket details</p>
        </div>
        
        <div class="user-info">
            <h3><i class="bi bi-person-circle"></i> User Information</h3>
            <p><strong>Username:</strong> ${username}</p>
            <p><strong>Role:</strong> <span class="role-badge">${role}</span></p>
        </div>
        
        <c:choose>
            <c:when test="${empty bookingGroups}">
                <div class="no-tickets">
                    <i class="bi bi-ticket-perforated"></i>
                    <h3>No Tickets Found</h3>
                    <p>You haven't booked any tickets yet. Start your movie journey today!</p>
                    <a href="cinema?action=buy-tickets" class="buy-tickets-btn">
                        <i class="bi bi-plus-circle"></i> Buy Tickets
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="tickets-summary">
                    <h3><i class="bi bi-bar-chart"></i> Summary</h3>
                    <div class="summary-stats">
                        <div class="stat-card">
                            <div class="stat-number">${bookingGroups.size()}</div>
                            <div class="stat-label">Booking Sessions</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">${ticketList.size()}</div>
                            <div class="stat-label">Total Tickets</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">
                                <c:set var="totalSpent" value="0" />
                                <c:forEach var="ticket" items="${ticketList}">
                                    <c:set var="totalSpent" value="${totalSpent + ticket.price}" />
                                </c:forEach>
                                <fmt:formatNumber value="${totalSpent}" pattern="#,##0" />
                            </div>
                            <div class="stat-label">Total Spent (VND)</div>
                        </div>
                    </div>
                </div>
                
                <div class="booking-groups">
                    <h3><i class="bi bi-calendar-event"></i> Booking History</h3>
                    
                    <c:forEach var="group" items="${bookingGroups}">
                        <div class="booking-group">
                            <div class="group-header">
                                <div class="group-title">
                                    <i class="bi bi-calendar-check"></i> 
                                    Booking Session
                                </div>
                                <div class="group-date">
                                    <fmt:formatDate value="${group.bookingTime}" pattern="dd/MM/yyyy HH:mm" />
                                </div>
                            </div>
                            
                            <div class="group-summary">
                                <div class="summary-item">
                                    <div class="summary-label">Total Tickets</div>
                                    <div class="summary-value">${group.totalTickets}</div>
                                </div>
                                <div class="summary-item">
                                    <div class="summary-label">Total Amount</div>
                                    <div class="summary-value">
                                        <fmt:formatNumber value="${group.totalAmount}" pattern="#,##0" /> VND
                                    </div>
                                </div>
                                <div class="summary-item">
                                    <div class="summary-label">Movies</div>
                                    <div class="summary-value">${group.movieCount}</div>
                                </div>
                            </div>
                            
                            <div class="tickets-list">
                                <c:forEach var="ticket" items="${group.tickets}">
                                    <div class="ticket-item">
                                        <div class="ticket-header">
                                            <div class="movie-title">${ticket.movieTitle}</div>
                                            <div class="ticket-id">Ticket #${ticket.ticketId}</div>
                                        </div>
                                        
                                        <div class="ticket-details">
                                            <div class="detail-item">
                                                <div class="detail-label">Theater</div>
                                                <div class="detail-value">${ticket.theaterName}</div>
                                            </div>
                                            <div class="detail-item">
                                                <div class="detail-label">Showtime</div>
                                                <div class="detail-value">
                                                    <fmt:formatDate value="${ticket.showTime}" pattern="dd/MM/yyyy HH:mm" />
                                                </div>
                                            </div>
                                            <div class="detail-item">
                                                <div class="detail-label">Seat</div>
                                                <div class="detail-value">
                                                    <span class="seat-badge">${ticket.seatPosition}</span>
                                                </div>
                                            </div>
                                            <div class="detail-item">
                                                <div class="detail-label">Type</div>
                                                <div class="detail-value">${ticket.seatType}</div>
                                            </div>
                                            <div class="detail-item">
                                                <div class="detail-label">Price</div>
                                                <div class="detail-value">
                                                    <span class="price-badge">
                                                        <fmt:formatNumber value="${ticket.price}" pattern="#,##0" /> VND
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        
        <div style="text-align: center; margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/" class="back-btn">
                <i class="bi bi-house"></i> Back to Home
            </a>
            <a href="cinema?action=buy-tickets" class="buy-tickets-btn">
                <i class="bi bi-plus-circle"></i> Buy More Tickets
            </a>
        </div>
    </div>
</body>
</html> 