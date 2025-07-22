<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    boolean isLoggedIn = (username != null && role != null);
    
    // Redirect to login if not authenticated
    if (!isLoggedIn) {
        response.sendRedirect("cinema?action=login&message=" + 
            java.net.URLEncoder.encode("You need to login to select seats!", "UTF-8"));
        return;
    }
    
    // Get data from request attributes (set by CinemaServlet)
    Integer movieId = (Integer) request.getAttribute("movieId");
    String movieTitle = (String) request.getAttribute("movieTitle");
    String showtime = (String) request.getAttribute("showtime");
    Integer theaterId = (Integer) request.getAttribute("theaterId");
    Integer showtimeId = (Integer) request.getAttribute("showtimeId");
    java.util.List<Integer> bookedSeatIds = (java.util.List<Integer>) request.getAttribute("bookedSeatIds");
    
    // Redirect back if missing required data
    if (movieId == null || movieTitle == null || showtime == null || theaterId == null || showtimeId == null) {
        response.sendRedirect("cinema?action=buy-tickets&error=Missing showtime data");
        return;
    }
    
    // Calculate seat ID offset based on theater
    // Theater 1: seats 1-60, Theater 2: seats 61-120, Theater 3: seats 121-180
    int seatOffset = (theaterId - 1) * 60;
%>
<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Seat Selection - Cinema Application</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css" media="all" />
    <!-- Iconfont CSS -->
    <link rel="stylesheet" type="text/css" href="assets/css/icofont.css" media="all" />
    <!-- Main style CSS -->
    <link rel="stylesheet" type="text/css" href="assets/css/style.css" media="all" />
    
    <style>
        body {
            background: #03090e;
            color: #ffffff;
            font-family: 'Poppins', sans-serif;
        }
        
        .seat-selection-container {
            max-width: 1600px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        .movie-info {
            background: linear-gradient(135deg, #1a1a1a, #2d2d2d);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            border: 2px solid #eb315a;
        }
        
        .movie-info h2 {
            color: #eb315a;
            margin-bottom: 15px;
        }
        
        .movie-info p {
            margin: 5px 0;
            font-size: 1.1rem;
        }
        
        .theater-container {
            background: #1a1a1a;
            border-radius: 20px;
            padding: 50px 40px;
            margin-bottom: 30px;
            border: 1px solid #333;
        }
        
        .screen {
            width: 800px;
            height: 8px;
            background: linear-gradient(135deg, #eb315a, #ff6b9d);
            border-radius: 20px;
            margin: 0 auto 40px;
            position: relative;
        }
        .screen-label {
            position: absolute;
            top: -30px;
            left: 50%;
            transform: translateX(-50%);
            color: #eb315a;
            font-weight: bold;
            font-size: 1.2rem;
            letter-spacing: 3px;
        }
        .seat-row {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px; /* Khoảng cách dọc bằng khoảng cách ngang */
            gap: 50px; /* Tăng khoảng cách giữa các nhóm để phù hợp với màn hình rộng hơn */
        }
        
        .seat-row:last-child {
            margin-bottom: 0; /* Hàng cuối không có margin-bottom */
        }
        .side-group {
            display: flex;
            gap: 12px;
        }
        .center-group {
            display: flex;
            gap: 12px;
        }
        .seat {
            width: 50px;
            height: 50px;
            border-radius: 4px;
            margin: 0;
            font-size: 1.2rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .couple-row {
            margin-top: 12px; /* Giữ khoảng cách đều với các hàng ghế thường */
        }
        
        .couple-group {
            display: flex;
            gap: 12px; /* Khoảng cách giữa các couple seats bằng với khoảng cách giữa ghế đơn */
        }
        
        .row-label {
            width: 30px;
            text-align: center;
            font-weight: bold;
            color: #eb315a;
            font-size: 1.1rem;
            margin-right: 6px;
        }
        
        /* Normal seats - 3 hàng đầu */
        .seat.normal {
            background: #2d2d2d;
            border-color: #4CAF50;
            color: #4CAF50;
        }
        
        .seat.normal:hover {
            background: #4CAF50;
            color: white;
            transform: scale(1.1);
        }
        
        .seat.normal.selected {
            background: #4CAF50;
            color: white;
            border-color: #66BB6A;
        }
        
        /* VIP seats - 4 hàng giữa */
        .seat.vip {
            background: #2d2d2d;
            border-color: #FF9800;
            color: #FF9800;
        }
        
        .seat.vip:hover {
            background: #FF9800;
            color: white;
            transform: scale(1.1);
        }
        
        .seat.vip.selected {
            background: #FF9800;
            color: white;
            border-color: #FFB74D;
        }
        
        /* Couple seats - hàng cuối */
        .seat.couple {
            width: 112px; /* Dài bằng 2 ghế đơn + khoảng cách (50px + 12px + 50px = 112px) */
            background: #2d2d2d;
            border-color: #E91E63;
            color: #E91E63;
        }
        
        .seat.couple:hover {
            background: #E91E63;
            color: white;
            transform: scale(1.05);
        }
        
        .seat.couple.selected {
            background: #E91E63;
            color: white;
            border-color: #F06292;
        }
        
        /* Sold/Booked seats */
        .seat.booked {
            background: #666 !important;
            border-color: #888 !important;
            color: transparent !important; /* Ẩn số */
            cursor: not-allowed !important;
            position: relative;
        }
        
        .seat.booked:hover {
            transform: none !important;
        }
        
        /* Dấu X cho ghế đã đặt */
        .seat.booked::after {
            content: "❌";
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 1.5rem;
            color: #eb315a;
            z-index: 10;
        }
        
        .legend {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin: 30px 0;
            flex-wrap: wrap;
        }
        
        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .legend-seat {
            width: 20px;
            height: 20px;
            border-radius: 4px;
            border: 2px solid;
        }
        
        .summary-container {
            background: linear-gradient(135deg, #1a1a1a, #2d2d2d);
            border-radius: 15px;
            padding: 25px;
            border: 2px solid #eb315a;
        }
        
        .selected-seats {
            margin-bottom: 20px;
        }
        
        .seat-tag {
            display: inline-block;
            background: #eb315a;
            color: white !important;
            padding: 5px 12px;
            border-radius: 20px;
            margin: 3px;
            font-size: 0.9rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            border: none;
            min-width: 35px;
            text-align: center;
            vertical-align: middle;
        }
        
        .total-price {
            font-size: 1.8rem;
            font-weight: bold;
            color: #eb315a;
            text-align: center;
            margin: 20px 0;
        }
        
        .confirm-btn {
            background: linear-gradient(135deg, #eb315a, #ff6b9d);
            border: none;
            color: white;
            padding: 15px 40px;
            font-size: 1.2rem;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .confirm-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(235, 49, 90, 0.3);
        }
        
        .confirm-btn:disabled {
            background: #666;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .back-btn {
            background: transparent;
            border: 2px solid #eb315a;
            color: #eb315a;
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-block;
            margin-bottom: 20px;
        }
        
        .back-btn:hover {
            background: #eb315a;
            color: white;
            text-decoration: none;
        }
        
        .gap {
            width: 30px;
        }
    </style>
</head>
<body>
    <div class="seat-selection-container">
        <a href="cinema?action=buy-tickets" class="back-btn">
            <i class="icofont icofont-arrow-left"></i> Back to Movie Selection
        </a>
        
        <div class="movie-info">
            <div class="row">
                <div class="col-md-8">
                    <h2><i class="icofont icofont-movie"></i> <%= movieTitle %></h2>
                    <p><strong>Theater:</strong> Theater <%= theaterId %></p>
                    <p><strong>Showtime:</strong> <%= showtime %></p>
                    <p><strong>Date:</strong> January 20, 2024</p>
                </div>
                <div class="col-md-4 text-right">
                    <h4>Welcome, <%= username %>!</h4>
                    <p>Role: <%= role %></p>
                </div>
            </div>
        </div>
        
        <div class="theater-container">
            <div class="screen">
                <span class="screen-label">SCREEN</span>
            </div>
            
            <div class="seat-map">
                <!-- Các hàng A-G với 3 nhóm ghế -->
                <div class="seat-row">
                    <div class="row-label">A</div>
                    <div class="side-group">
                        <div class="seat normal" data-seat-id="<%= seatOffset + 1 %>" data-seat-position="A1" data-price="50000">1</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 2 %>" data-seat-position="A2" data-price="50000">2</div>
                    </div>
                    <div class="center-group">
                        <div class="seat normal" data-seat-id="<%= seatOffset + 3 %>" data-seat-position="A3" data-price="50000">3</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 4 %>" data-seat-position="A4" data-price="50000">4</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 5 %>" data-seat-position="A5" data-price="50000">5</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 6 %>" data-seat-position="A6" data-price="50000">6</div>
                    </div>
                    <div class="side-group">
                        <div class="seat normal" data-seat-id="<%= seatOffset + 7 %>" data-seat-position="A7" data-price="50000">7</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 8 %>" data-seat-position="A8" data-price="50000">8</div>
                    </div>
                </div>
                <div class="seat-row">
                    <div class="row-label">B</div>
                    <div class="side-group">
                        <div class="seat normal" data-seat-id="<%= seatOffset + 9 %>" data-seat-position="B1" data-price="50000">1</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 10 %>" data-seat-position="B2" data-price="50000">2</div>
                    </div>
                    <div class="center-group">
                        <div class="seat normal" data-seat-id="<%= seatOffset + 11 %>" data-seat-position="B3" data-price="50000">3</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 12 %>" data-seat-position="B4" data-price="50000">4</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 13 %>" data-seat-position="B5" data-price="50000">5</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 14 %>" data-seat-position="B6" data-price="50000">6</div>
                    </div>
                    <div class="side-group">
                        <div class="seat normal" data-seat-id="<%= seatOffset + 15 %>" data-seat-position="B7" data-price="50000">7</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 16 %>" data-seat-position="B8" data-price="50000">8</div>
                    </div>
                </div>
                <div class="seat-row">
                    <div class="row-label">C</div>
                    <div class="side-group">
                        <div class="seat normal" data-seat-id="<%= seatOffset + 17 %>" data-seat-position="C1" data-price="50000">1</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 18 %>" data-seat-position="C2" data-price="50000">2</div>
                    </div>
                    <div class="center-group">
                        <div class="seat normal" data-seat-id="<%= seatOffset + 19 %>" data-seat-position="C3" data-price="50000">3</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 20 %>" data-seat-position="C4" data-price="50000">4</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 21 %>" data-seat-position="C5" data-price="50000">5</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 22 %>" data-seat-position="C6" data-price="50000">6</div>
                    </div>
                    <div class="side-group">
                        <div class="seat normal" data-seat-id="<%= seatOffset + 23 %>" data-seat-position="C7" data-price="50000">7</div>
                        <div class="seat normal" data-seat-id="<%= seatOffset + 24 %>" data-seat-position="C8" data-price="50000">8</div>
                    </div>
                </div>
                <div class="seat-row">
                    <div class="row-label">D</div>
                    <div class="side-group">
                        <div class="seat vip" data-seat-id="<%= seatOffset + 25 %>" data-seat-position="D1" data-price="75000">1</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 26 %>" data-seat-position="D2" data-price="75000">2</div>
                    </div>
                    <div class="center-group">
                        <div class="seat vip" data-seat-id="<%= seatOffset + 27 %>" data-seat-position="D3" data-price="75000">3</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 28 %>" data-seat-position="D4" data-price="75000">4</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 29 %>" data-seat-position="D5" data-price="75000">5</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 30 %>" data-seat-position="D6" data-price="75000">6</div>
                    </div>
                    <div class="side-group">
                        <div class="seat vip" data-seat-id="<%= seatOffset + 31 %>" data-seat-position="D7" data-price="75000">7</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 32 %>" data-seat-position="D8" data-price="75000">8</div>
                    </div>
                </div>
                <div class="seat-row">
                    <div class="row-label">E</div>
                    <div class="side-group">
                        <div class="seat vip" data-seat-id="<%= seatOffset + 33 %>" data-seat-position="E1" data-price="75000">1</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 34 %>" data-seat-position="E2" data-price="75000">2</div>
                    </div>
                    <div class="center-group">
                        <div class="seat vip" data-seat-id="<%= seatOffset + 35 %>" data-seat-position="E3" data-price="75000">3</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 36 %>" data-seat-position="E4" data-price="75000">4</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 37 %>" data-seat-position="E5" data-price="75000">5</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 38 %>" data-seat-position="E6" data-price="75000">6</div>
                    </div>
                    <div class="side-group">
                        <div class="seat vip" data-seat-id="<%= seatOffset + 39 %>" data-seat-position="E7" data-price="75000">7</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 40 %>" data-seat-position="E8" data-price="75000">8</div>
                    </div>
                </div>
                <div class="seat-row">
                    <div class="row-label">F</div>
                    <div class="side-group">
                        <div class="seat vip" data-seat-id="<%= seatOffset + 41 %>" data-seat-position="F1" data-price="75000">1</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 42 %>" data-seat-position="F2" data-price="75000">2</div>
                    </div>
                    <div class="center-group">
                        <div class="seat vip" data-seat-id="<%= seatOffset + 43 %>" data-seat-position="F3" data-price="75000">3</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 44 %>" data-seat-position="F4" data-price="75000">4</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 45 %>" data-seat-position="F5" data-price="75000">5</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 46 %>" data-seat-position="F6" data-price="75000">6</div>
                    </div>
                    <div class="side-group">
                        <div class="seat vip" data-seat-id="<%= seatOffset + 47 %>" data-seat-position="F7" data-price="75000">7</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 48 %>" data-seat-position="F8" data-price="75000">8</div>
                    </div>
                </div>
                <div class="seat-row">
                    <div class="row-label">G</div>
                    <div class="side-group">
                        <div class="seat vip" data-seat-id="<%= seatOffset + 49 %>" data-seat-position="G1" data-price="75000">1</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 50 %>" data-seat-position="G2" data-price="75000">2</div>
                    </div>
                    <div class="center-group">
                        <div class="seat vip" data-seat-id="<%= seatOffset + 51 %>" data-seat-position="G3" data-price="75000">3</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 52 %>" data-seat-position="G4" data-price="75000">4</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 53 %>" data-seat-position="G5" data-price="75000">5</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 54 %>" data-seat-position="G6" data-price="75000">6</div>
                    </div>
                    <div class="side-group">
                        <div class="seat vip" data-seat-id="<%= seatOffset + 55 %>" data-seat-position="G7" data-price="75000">7</div>
                        <div class="seat vip" data-seat-id="<%= seatOffset + 56 %>" data-seat-position="G8" data-price="75000">8</div>
                    </div>
                </div>
                <!-- Hàng H (couple) tách biệt phía dưới -->
                <div class="seat-row couple-row">
                    <div class="row-label">H</div>
                    <div class="couple-group">
                        <div class="seat couple" data-seat-id="<%= seatOffset + 57 %>" data-seat-position="H1" data-price="140000">1-2</div>
                        <div class="seat couple" data-seat-id="<%= seatOffset + 58 %>" data-seat-position="H2" data-price="140000">3-4</div>
                        <div class="seat couple" data-seat-id="<%= seatOffset + 59 %>" data-seat-position="H3" data-price="140000">5-6</div>
                        <div class="seat couple" data-seat-id="<%= seatOffset + 60 %>" data-seat-position="H4" data-price="140000">7-8</div>
                    </div>
                </div>
            </div>
            
            <!-- Legend -->
            <div class="legend">
                <div class="legend-item">
                    <div class="legend-seat" style="background: #4CAF50; border-color: #4CAF50;"></div>
                    <span>Normal - 50,000 VNĐ</span>
                </div>
                <div class="legend-item">
                    <div class="legend-seat" style="background: #FF9800; border-color: #FF9800;"></div>
                    <span>VIP - 75,000 VNĐ</span>
                </div>
                <div class="legend-item">
                    <div class="legend-seat" style="background: #E91E63; border-color: #E91E63; width: 40px;"></div>
                    <span>Couple - 140,000 VNĐ</span>
                </div>
                <div class="legend-item">
                    <div class="legend-seat" style="background: #666; border-color: #888;"></div>
                    <span>Booked</span>
                </div>
            </div>
        </div>
        
        <!-- Hidden data for JavaScript -->
        <input type="hidden" id="bookedSeatsData" value="<%
            if (bookedSeatIds != null && !bookedSeatIds.isEmpty()) {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < bookedSeatIds.size(); i++) {
                    if (i > 0) sb.append(",");
                    sb.append(bookedSeatIds.get(i));
                }
                out.print(sb.toString());
            }
        %>" />
        
        <!-- Summary -->
        <div class="summary-container">
            <h3><i class="icofont icofont-ticket"></i> Booking Summary</h3>
            <div class="selected-seats">
                <strong>Selected Seats:</strong>
                <div id="selected-seats-display">
                    <span style="color: #888; font-style: italic;">No seats selected</span>
                </div>
            </div>
            <div class="total-price" id="total-price">Total: 0 VNĐ</div>
            

            <button class="confirm-btn" id="confirm-btn" disabled onclick="confirmBooking()">
                Confirm Booking <i class="icofont icofont-arrow-right"></i>
            </button>
            

            <form id="booking-form" action="cinema" method="post" style="display:none;">
                <input type="hidden" name="action" value="confirm-booking">
                <input type="hidden" name="movieId" value="<%= movieId != null ? movieId.toString() : "" %>">
                <input type="hidden" name="movieTitle" value="<%= movieTitle != null ? movieTitle : "" %>">
                <input type="hidden" name="showtime" value="<%= showtime != null ? showtime : "" %>">
                <input type="hidden" name="theaterId" value="<%= theaterId != null ? theaterId.toString() : "" %>">
                <input type="hidden" name="showtimeId" value="<%= showtimeId != null ? showtimeId.toString() : "" %>">
                <input type="hidden" id="selectedSeatsInput" name="selectedSeats">
                <input type="hidden" id="totalPriceInput" name="totalPrice">
            </form>
        </div>
    </div>
    
    <!-- JavaScript -->
    <script src="../assets/js/jquery.min.js"></script>

    <script>
        let selectedSeats = [];
        let totalPrice = 0;
        
        // Get booked seats from server (database)
        const bookedSeatsData = document.getElementById('bookedSeatsData').value;
        const bookedSeats = bookedSeatsData ? bookedSeatsData.split(',').map(id => parseInt(id.trim())) : [];
        console.log('Booked seats loaded from database:', bookedSeats);
        
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page loaded, initializing seat selection...');
            console.log('Total booked seats from database:', bookedSeats.length);
            
            // Debug: Check if elements exist
            console.log('Summary elements:', {
                seatsDisplay: document.getElementById('selected-seats-display'),
                totalPriceDisplay: document.getElementById('total-price'),
                confirmBtn: document.getElementById('confirm-btn')
            });
            
            // Mark booked seats as unavailable
            console.log('Marking ' + bookedSeats.length + ' booked seats as unavailable:', bookedSeats);
            bookedSeats.forEach(seatId => {
                const seatElement = document.querySelector('[data-seat-id="' + seatId + '"]');
                if (seatElement) {
                    seatElement.classList.add('booked');
                    // Không cần thêm text nữa vì CSS sẽ handle dấu X
                    console.log('Marked seat ID ' + seatId + ' as booked (' + seatElement.getAttribute('data-seat-position') + ')');
                } else {
                    console.warn('Could not find seat element with ID: ' + seatId);
                }
            });
            
            // Add click handlers to all seats
            const availableSeats = document.querySelectorAll('.seat:not(.booked)');
            console.log('Adding click handlers to ' + availableSeats.length + ' available seats');
            
            availableSeats.forEach((seat, index) => {
                seat.addEventListener('click', function() {
                    console.log('Seat clicked: ' + this.getAttribute('data-seat-position'));
                    toggleSeat(this);
                });
                
                // Debug: Check first few seats data
                if (index < 3) {
                    console.log('Seat ' + index + ':', {
                        id: seat.getAttribute('data-seat-id'),
                        position: seat.getAttribute('data-seat-position'),
                        price: seat.getAttribute('data-price')
                    });
                }
            });
            
            // Initialize summary display
            console.log('Initializing summary...');
            updateSummary();
            
            // Debug: Add a test function to window
            window.testSeatSelection = function() {
                console.log('Test function called');
                const firstSeat = document.querySelector('.seat:not(.booked)');
                if (firstSeat) {
                    console.log('Simulating click on first available seat');
                    toggleSeat(firstSeat);
                } else {
                    console.log('No available seats found');
                }
            };
            
            console.log('Seat selection initialized. Type testSeatSelection() to test manually.');
            
            console.log('Seat selection system ready!');
        });
        
        function toggleSeat(seatElement) {
            const seatId = parseInt(seatElement.getAttribute('data-seat-id'));
            const seatPosition = seatElement.getAttribute('data-seat-position');
            const seatPrice = parseInt(seatElement.getAttribute('data-price'));
            const seatType = seatElement.classList.contains('normal') ? 'Normal' : 
                          seatElement.classList.contains('vip') ? 'VIP' : 'Couple';
            
            console.log('Toggling seat:', { seatId, seatPosition, seatPrice, seatType });
            
            if (seatElement.classList.contains('selected')) {
                // Deselect seat
                seatElement.classList.remove('selected');
                selectedSeats = selectedSeats.filter(s => s.seatId !== seatId);
                totalPrice -= seatPrice;
                console.log('Deselected seat, new total:', totalPrice);
            } else {
                // Select seat
                seatElement.classList.add('selected');
                selectedSeats.push({
                    seatId: seatId,
                    position: seatPosition,
                    price: seatPrice,
                    type: seatType
                });
                totalPrice += seatPrice;
                console.log('Selected seat, new total:', totalPrice);
            }
            
            console.log('Current selected seats:', selectedSeats);
            updateSummary();
        }
        
        function updateSummary() {
            const seatsDisplay = document.getElementById('selected-seats-display');
            const totalPriceDisplay = document.getElementById('total-price');
            const confirmBtn = document.getElementById('confirm-btn');
            
            console.log('Updating summary with:', { selectedSeats, totalPrice });
            
            if (selectedSeats.length === 0) {
                seatsDisplay.innerHTML = '<span style="color: #888; font-style: italic;">No seats selected</span>';
                totalPriceDisplay.textContent = 'Total: 0 VNĐ';
                confirmBtn.disabled = true;
                console.log('No seats selected, summary cleared');
            } else {
                const seatNames = selectedSeats.map(seat => seat.position);
                const seatTags = selectedSeats.map(seat => 
                    '<span class="seat-tag">' + seat.position + '</span>'
                ).join('');
                
                seatsDisplay.innerHTML = seatTags;
                totalPriceDisplay.textContent = 'Total: ' + totalPrice.toLocaleString() + ' VNĐ';
                confirmBtn.disabled = false;
                
                console.log('Summary updated:', {
                    seatNames: seatNames,
                    totalFormatted: 'Total: ' + totalPrice.toLocaleString() + ' VNĐ',
                    seatTags: seatTags
                });
            }
        }
        
        function confirmBooking() {
            if (selectedSeats.length === 0) {
                alert('Please select at least one seat!');
                return;
            }
            
            // Lấy danh sách tên ghế (A1, B2, ...)
            const seatNames = selectedSeats.map(seat => seat.position);
            
            // Fill form data
            document.getElementById('selectedSeatsInput').value = seatNames.join(',');
            document.getElementById('totalPriceInput').value = totalPrice;
            
            console.log('Submitting booking with:', {
                selectedSeats: seatNames.join(','),
                totalPrice: totalPrice,
                movieId: '<%= movieId != null ? movieId.toString() : "" %>',
                movieTitle: '<%= movieTitle != null ? movieTitle : "" %>',
                showtime: '<%= showtime != null ? showtime : "" %>',
                theaterId: '<%= theaterId != null ? theaterId.toString() : "" %>',
                showtimeId: '<%= showtimeId != null ? showtimeId.toString() : "" %>'
            });
            
            // Debug: Also log form values being submitted
            console.log('Form data being submitted:');
            console.log('movieId:', document.querySelector('input[name="movieId"]').value);
            console.log('movieTitle:', document.querySelector('input[name="movieTitle"]').value);
            console.log('showtime:', document.querySelector('input[name="showtime"]').value);
            console.log('theaterId:', document.querySelector('input[name="theaterId"]').value);
            console.log('showtimeId:', document.querySelector('input[name="showtimeId"]').value);
            console.log('selectedSeats:', document.getElementById('selectedSeatsInput').value);
            console.log('totalPrice:', document.getElementById('totalPriceInput').value);
            
            document.getElementById('booking-form').submit();
        }
    </script>
</body>
</html> 