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
            max-width: 1200px;
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
            padding: 40px 30px;
            margin-bottom: 30px;
            border: 1px solid #333;
        }
        
        .screen {
            background: linear-gradient(135deg, #eb315a, #ff6b9d);
            height: 8px;
            border-radius: 20px;
            margin: 0 auto 40px;
            width: 70%;
            position: relative;
        }
        
        .screen::before {
            content: "SCREEN";
            position: absolute;
            top: -30px;
            left: 50%;
            transform: translateX(-50%);
            color: #eb315a;
            font-weight: bold;
            font-size: 1.2rem;
            letter-spacing: 3px;
        }
        
        .seat-map {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }
        
        .seat-row {
            display: flex;
            gap: 8px;
            align-items: center;
        }
        
        .row-label {
            width: 30px;
            text-align: center;
            font-weight: bold;
            color: #eb315a;
            font-size: 1.1rem;
        }
        
        .seat {
            width: 35px;
            height: 35px;
            border: 2px solid;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
            font-weight: bold;
            user-select: none;
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
            width: 75px; /* Dài bằng 2 ghế đơn + khoảng cách */
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
            color: #888 !important;
            cursor: not-allowed !important;
        }
        
        .seat.booked:hover {
            transform: none !important;
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
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            margin: 5px;
            font-size: 0.9rem;
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
            <div class="screen"></div>
            
            <div class="seat-map">
                <!-- Row A: Normal seats -->
                <div class="seat-row">
                    <div class="row-label">A</div>
                    <div class="seat normal" data-seat-id="<%= seatOffset + 1 %>" data-seat-position="A1" data-price="50000">1</div>
                    <div class="seat normal" data-seat-id="<%= seatOffset + 2 %>" data-seat-position="A2" data-price="50000">2</div>
                    <div class="seat normal" data-seat-id="<%= seatOffset + 3 %>" data-seat-position="A3" data-price="50000">3</div>
                    <div class="seat normal" data-seat-id="<%= seatOffset + 4 %>" data-seat-position="A4" data-price="50000">4</div>
                    <div class="gap"></div>
                    <div class="seat normal" data-seat-id="<%= seatOffset + 5 %>" data-seat-position="A5" data-price="50000">5</div>
                    <div class="seat normal" data-seat-id="<%= seatOffset + 6 %>" data-seat-position="A6" data-price="50000">6</div>
                    <div class="seat normal" data-seat-id="<%= seatOffset + 7 %>" data-seat-position="A7" data-price="50000">7</div>
                    <div class="seat normal" data-seat-id="<%= seatOffset + 8 %>" data-seat-position="A8" data-price="50000">8</div>
                </div>
                
                <!-- Row B: Normal seats -->
                <div class="seat-row">
                    <div class="row-label">B</div>
                    <div class="seat normal" data-seat-id="9" data-seat-position="B1" data-price="50000">1</div>
                    <div class="seat normal" data-seat-id="10" data-seat-position="B2" data-price="50000">2</div>
                    <div class="seat normal" data-seat-id="11" data-seat-position="B3" data-price="50000">3</div>
                    <div class="seat normal" data-seat-id="12" data-seat-position="B4" data-price="50000">4</div>
                    <div class="gap"></div>
                    <div class="seat normal" data-seat-id="13" data-seat-position="B5" data-price="50000">5</div>
                    <div class="seat normal" data-seat-id="14" data-seat-position="B6" data-price="50000">6</div>
                    <div class="seat normal" data-seat-id="15" data-seat-position="B7" data-price="50000">7</div>
                    <div class="seat normal" data-seat-id="16" data-seat-position="B8" data-price="50000">8</div>
                </div>
                
                <!-- Row C: Normal seats -->
                <div class="seat-row">
                    <div class="row-label">C</div>
                    <div class="seat normal" data-seat-id="17" data-seat-position="C1" data-price="50000">1</div>
                    <div class="seat normal" data-seat-id="18" data-seat-position="C2" data-price="50000">2</div>
                    <div class="seat normal" data-seat-id="19" data-seat-position="C3" data-price="50000">3</div>
                    <div class="seat normal" data-seat-id="20" data-seat-position="C4" data-price="50000">4</div>
                    <div class="gap"></div>
                    <div class="seat normal" data-seat-id="21" data-seat-position="C5" data-price="50000">5</div>
                    <div class="seat normal" data-seat-id="22" data-seat-position="C6" data-price="50000">6</div>
                    <div class="seat normal" data-seat-id="23" data-seat-position="C7" data-price="50000">7</div>
                    <div class="seat normal" data-seat-id="24" data-seat-position="C8" data-price="50000">8</div>
                </div>
                
                <div style="height: 20px;"></div>
                
                <!-- Row D: VIP seats -->
                <div class="seat-row">
                    <div class="row-label">D</div>
                    <div class="seat vip" data-seat-id="25" data-seat-position="D1" data-price="75000">1</div>
                    <div class="seat vip" data-seat-id="26" data-seat-position="D2" data-price="75000">2</div>
                    <div class="seat vip" data-seat-id="27" data-seat-position="D3" data-price="75000">3</div>
                    <div class="seat vip" data-seat-id="28" data-seat-position="D4" data-price="75000">4</div>
                    <div class="gap"></div>
                    <div class="seat vip" data-seat-id="29" data-seat-position="D5" data-price="75000">5</div>
                    <div class="seat vip" data-seat-id="30" data-seat-position="D6" data-price="75000">6</div>
                    <div class="seat vip" data-seat-id="31" data-seat-position="D7" data-price="75000">7</div>
                    <div class="seat vip" data-seat-id="32" data-seat-position="D8" data-price="75000">8</div>
                </div>
                
                <!-- Row E: VIP seats -->
                <div class="seat-row">
                    <div class="row-label">E</div>
                    <div class="seat vip" data-seat-id="33" data-seat-position="E1" data-price="75000">1</div>
                    <div class="seat vip" data-seat-id="34" data-seat-position="E2" data-price="75000">2</div>
                    <div class="seat vip" data-seat-id="35" data-seat-position="E3" data-price="75000">3</div>
                    <div class="seat vip" data-seat-id="36" data-seat-position="E4" data-price="75000">4</div>
                    <div class="gap"></div>
                    <div class="seat vip" data-seat-id="37" data-seat-position="E5" data-price="75000">5</div>
                    <div class="seat vip" data-seat-id="38" data-seat-position="E6" data-price="75000">6</div>
                    <div class="seat vip" data-seat-id="39" data-seat-position="E7" data-price="75000">7</div>
                    <div class="seat vip" data-seat-id="40" data-seat-position="E8" data-price="75000">8</div>
                </div>
                
                <!-- Row F: VIP seats -->
                <div class="seat-row">
                    <div class="row-label">F</div>
                    <div class="seat vip" data-seat-id="41" data-seat-position="F1" data-price="75000">1</div>
                    <div class="seat vip" data-seat-id="42" data-seat-position="F2" data-price="75000">2</div>
                    <div class="seat vip" data-seat-id="43" data-seat-position="F3" data-price="75000">3</div>
                    <div class="seat vip" data-seat-id="44" data-seat-position="F4" data-price="75000">4</div>
                    <div class="gap"></div>
                    <div class="seat vip" data-seat-id="45" data-seat-position="F5" data-price="75000">5</div>
                    <div class="seat vip" data-seat-id="46" data-seat-position="F6" data-price="75000">6</div>
                    <div class="seat vip" data-seat-id="47" data-seat-position="F7" data-price="75000">7</div>
                    <div class="seat vip" data-seat-id="48" data-seat-position="F8" data-price="75000">8</div>
                </div>
                
                <!-- Row G: VIP seats -->
                <div class="seat-row">
                    <div class="row-label">G</div>
                    <div class="seat vip" data-seat-id="49" data-seat-position="G1" data-price="75000">1</div>
                    <div class="seat vip" data-seat-id="50" data-seat-position="G2" data-price="75000">2</div>
                    <div class="seat vip" data-seat-id="51" data-seat-position="G3" data-price="75000">3</div>
                    <div class="seat vip" data-seat-id="52" data-seat-position="G4" data-price="75000">4</div>
                    <div class="gap"></div>
                    <div class="seat vip" data-seat-id="53" data-seat-position="G5" data-price="75000">5</div>
                    <div class="seat vip" data-seat-id="54" data-seat-position="G6" data-price="75000">6</div>
                    <div class="seat vip" data-seat-id="55" data-seat-position="G7" data-price="75000">7</div>
                    <div class="seat vip" data-seat-id="56" data-seat-position="G8" data-price="75000">8</div>
                </div>
                
                <div style="height: 30px;"></div>
                
                <!-- Row H: Couple seats -->
                <div class="seat-row">
                    <div class="row-label">H</div>
                    <div class="seat couple" data-seat-id="57" data-seat-position="H1" data-price="140000">1-2</div>
                    <div class="gap"></div>
                    <div class="seat couple" data-seat-id="58" data-seat-position="H2" data-price="140000">3-4</div>
                    <div class="gap"></div>
                    <div class="seat couple" data-seat-id="59" data-seat-position="H3" data-price="140000">5-6</div>
                    <div class="gap"></div>
                    <div class="seat couple" data-seat-id="60" data-seat-position="H4" data-price="140000">7-8</div>
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
        </div>
    </div>
    
    <!-- JavaScript -->
    <script src="assets/js/jquery.min.js"></script>
    <script>
        let selectedSeats = [];
        let totalPrice = 0;
        
        // Sample booked seats - TODO: Load from database based on showtimeId
        const bookedSeats = [3, 21, 28, 51, 58]; // Example booked seat IDs
        
        document.addEventListener('DOMContentLoaded', function() {
            // Mark booked seats as unavailable
            bookedSeats.forEach(seatId => {
                const seatElement = document.querySelector(`[data-seat-id="${seatId}"]`);
                if (seatElement) {
                    seatElement.classList.add('booked');
                    const currentText = seatElement.textContent;
                    seatElement.textContent = currentText + ' ❌';
                }
            });
            
            // Add click handlers to all seats
            document.querySelectorAll('.seat:not(.booked)').forEach(seat => {
                seat.addEventListener('click', function() {
                    toggleSeat(this);
                });
            });
        });
        
        function toggleSeat(seatElement) {
            const seatId = parseInt(seatElement.getAttribute('data-seat-id'));
            const seatPosition = seatElement.getAttribute('data-seat-position');
            const seatPrice = parseInt(seatElement.getAttribute('data-price'));
            const seatType = seatElement.classList.contains('normal') ? 'Normal' : 
                          seatElement.classList.contains('vip') ? 'VIP' : 'Couple';
            
            if (seatElement.classList.contains('selected')) {
                // Deselect seat
                seatElement.classList.remove('selected');
                selectedSeats = selectedSeats.filter(s => s.seatId !== seatId);
                totalPrice -= seatPrice;
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
            }
            
            updateSummary();
        }
        
        function updateSummary() {
            const seatsDisplay = document.getElementById('selected-seats-display');
            const totalPriceDisplay = document.getElementById('total-price');
            const confirmBtn = document.getElementById('confirm-btn');
            
            if (selectedSeats.length === 0) {
                seatsDisplay.innerHTML = '<span style="color: #888; font-style: italic;">No seats selected</span>';
                totalPriceDisplay.textContent = 'Total: 0 VNĐ';
                confirmBtn.disabled = true;
            } else {
                seatsDisplay.innerHTML = selectedSeats.map(seat => 
                    `<span class="seat-tag">${seat.position} (${seat.type})</span>`
                ).join('');
                totalPriceDisplay.textContent = `Total: ${totalPrice.toLocaleString()} VNĐ`;
                confirmBtn.disabled = false;
            }
        }
        
        function confirmBooking() {
            if (selectedSeats.length === 0) {
                alert('Please select at least one seat!');
                return;
            }
            
            const bookingData = {
                movieId: <%= movieId %>,
                movieTitle: '<%= movieTitle %>',
                theaterId: <%= theaterId %>,
                showtimeId: <%= showtimeId %>,
                showtime: '<%= showtime %>',
                selectedSeats: selectedSeats,
                totalPrice: totalPrice
            };
            
            // Store booking data for payment page
            sessionStorage.setItem('bookingData', JSON.stringify(bookingData));
            
            // Redirect to payment page (to be created)
            window.location.href = 'payment.jsp';
        }
    </script>
</body>
</html> 