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
            java.net.URLEncoder.encode("You need to login to access payment!", "UTF-8"));
        return;
    }
%>
<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Payment - Cinema Application</title>
    
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
        
        .payment-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        .payment-card {
            background: linear-gradient(135deg, #1a1a1a, #2d2d2d);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            border: 2px solid #eb315a;
        }
        
        .payment-card h2 {
            color: #eb315a;
            margin-bottom: 25px;
            text-align: center;
        }
        
        .booking-details {
            background: #2d2d2d;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
        }
        
        .booking-details h4 {
            color: #eb315a;
            margin-bottom: 15px;
        }
        
        .booking-details p {
            margin: 8px 0;
            font-size: 1.1rem;
        }
        
        .seat-tag {
            display: inline-block;
            background: #eb315a;
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            margin: 3px;
            font-size: 0.9rem;
        }
        
        .total-amount {
            background: linear-gradient(135deg, #eb315a, #ff6b9d);
            color: white;
            text-align: center;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
        }
        
        .total-amount h3 {
            margin: 0;
            font-size: 2rem;
            font-weight: bold;
        }
        
        .payment-methods {
            margin-bottom: 25px;
        }
        
        .payment-method {
            background: #2d2d2d;
            border: 2px solid #444;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .payment-method:hover, .payment-method.selected {
            border-color: #eb315a;
            background: #3a3a3a;
        }
        
        .payment-method input[type="radio"] {
            margin-right: 10px;
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
        
        .success-message {
            background: linear-gradient(135deg, #4CAF50, #66BB6A);
            color: white;
            text-align: center;
            padding: 30px;
            border-radius: 15px;
            display: none;
        }
        
        .success-message h3 {
            margin-bottom: 15px;
        }
        
        .success-message .ticket-info {
            background: rgba(255,255,255,0.2);
            border-radius: 10px;
            padding: 20px;
            margin: 15px 0;
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <a href="javascript:history.back()" class="back-btn">
            <i class="icofont icofont-arrow-left"></i> Back to Seat Selection
        </a>
        
        <div class="payment-card" id="payment-form">
            <h2><i class="icofont icofont-credit-card"></i> Payment Confirmation</h2>
            
            <div class="booking-details">
                <h4>Booking Details</h4>
                <div id="booking-info">
                    <!-- Will be populated by JavaScript -->
                </div>
            </div>
            
            <div class="total-amount">
                <h3 id="final-total">Total: 0 VNĐ</h3>
            </div>
            
            <div class="payment-methods">
                <h4 style="color: #eb315a; margin-bottom: 15px;">Payment Method</h4>
                
                <div class="payment-method" onclick="selectPaymentMethod('cash')">
                    <input type="radio" name="payment" value="cash" checked>
                    <i class="icofont icofont-money"></i>
                    <strong>Cash Payment</strong>
                    <p style="margin: 5px 0 0 25px; color: #bbb; font-size: 0.9rem;">Pay at the cinema counter</p>
                </div>
                
                <div class="payment-method" onclick="selectPaymentMethod('card')">
                    <input type="radio" name="payment" value="card">
                    <i class="icofont icofont-credit-card"></i>
                    <strong>Credit/Debit Card</strong>
                    <p style="margin: 5px 0 0 25px; color: #bbb; font-size: 0.9rem;">Secure online payment</p>
                </div>
                
                <div class="payment-method" onclick="selectPaymentMethod('mobile')">
                    <input type="radio" name="payment" value="mobile">
                    <i class="icofont icofont-mobile-phone"></i>
                    <strong>Mobile Payment</strong>
                    <p style="margin: 5px 0 0 25px; color: #bbb; font-size: 0.9rem;">MoMo, ZaloPay, etc.</p>
                </div>
            </div>
            
            <button class="confirm-btn" onclick="confirmPayment()">
                Complete Booking <i class="icofont icofont-check"></i>
            </button>
        </div>
        
        <!-- Success Message -->
        <div class="success-message" id="success-message">
            <h3><i class="icofont icofont-check-circled"></i> Booking Confirmed!</h3>
            <p>Your movie tickets have been successfully booked.</p>
            
            <div class="ticket-info" id="ticket-details">
                <!-- Will be populated after successful booking -->
            </div>
            
            <div style="margin-top: 20px;">
                <a href="/" class="back-btn" style="margin-right: 10px;">Back to Home</a>
                <button class="confirm-btn" onclick="printTicket()" style="width: auto; display: inline-block;">
                    Print Ticket <i class="icofont icofont-printer"></i>
                </button>
            </div>
        </div>
    </div>
    
    <!-- JavaScript -->
    <script src="assets/js/jquery.min.js"></script>
    <script>
        let bookingData = null;
        
        document.addEventListener('DOMContentLoaded', function() {
            // Get booking data from request attributes (server-side forward)
            const movieId = '<%= request.getAttribute("movieId") != null ? request.getAttribute("movieId") : "" %>';
            const movieTitle = '<%= request.getAttribute("movieTitle") != null ? request.getAttribute("movieTitle") : "" %>';
            const showtime = '<%= request.getAttribute("showtime") != null ? request.getAttribute("showtime") : "" %>';
            const theaterId = '<%= request.getAttribute("theaterId") != null ? request.getAttribute("theaterId") : "" %>';
            const showtimeId = '<%= request.getAttribute("showtimeId") != null ? request.getAttribute("showtimeId") : "" %>';
            const selectedSeats = '<%= request.getAttribute("selectedSeats") != null ? request.getAttribute("selectedSeats") : "" %>';
            const totalPrice = '<%= request.getAttribute("totalPrice") != null ? request.getAttribute("totalPrice") : "" %>';
            
            console.log('Booking data received:', {
                movieId, movieTitle, showtime, theaterId, showtimeId, selectedSeats, totalPrice
            });
            
            // Debug: Check raw request attributes
            console.log('Raw attributes from server:');
            console.log('movieId attr: "<%= request.getAttribute("movieId") %>"');
            console.log('movieTitle attr: "<%= request.getAttribute("movieTitle") %>"');
            console.log('showtime attr: "<%= request.getAttribute("showtime") %>"');
            console.log('theaterId attr: "<%= request.getAttribute("theaterId") %>"');
            console.log('showtimeId attr: "<%= request.getAttribute("showtimeId") %>"');
            console.log('selectedSeats attr: "<%= request.getAttribute("selectedSeats") %>"');
            console.log('totalPrice attr: "<%= request.getAttribute("totalPrice") %>"');

            
            if (!showtimeId || !selectedSeats || !totalPrice || 
                selectedSeats === 'null' || selectedSeats === '' || totalPrice === '' || totalPrice === '0') {
                console.error('Invalid booking data - showing debug info:', {
                    showtimeId: showtimeId,
                    selectedSeats: selectedSeats,
                    totalPrice: totalPrice,
                    showtimeIdCheck: !showtimeId,
                    selectedSeatsCheck: !selectedSeats,
                    totalPriceCheck: !totalPrice
                });
                alert('No booking data found. Check console for details. Redirecting to movie selection.');
                window.location.href = 'cinema?action=buy-tickets';
                return;
            }
            
            // Parse selected seats string (e.g., "E5,E6" -> array of seats)
            const seatList = selectedSeats.split(',').filter(seat => seat.trim() !== '');
            
            bookingData = {
                movieId: movieId || 'N/A',
                movieTitle: movieTitle || 'Unknown Movie',
                showtime: showtime || 'Unknown Time',
                theaterId: theaterId || '0',
                showtimeId: showtimeId,
                selectedSeats: seatList.map((seat, index) => ({
                    number: seat.trim(),
                    type: determineType(seat.trim()),
                    price: Math.round(parseInt(totalPrice) / seatList.length)
                })),
                totalPrice: parseInt(totalPrice) || 0
            };
            
            console.log('About to call displayBookingInfo with:', bookingData);
            
            // Test: Verify DOM elements exist before calling displayBookingInfo
            console.log('DOM elements check:', {
                bookingInfo: document.getElementById('booking-info') ? 'EXISTS' : 'MISSING',
                finalTotal: document.getElementById('final-total') ? 'EXISTS' : 'MISSING'
            });
            
            displayBookingInfo();
            
            // Test: Verify content was updated
            setTimeout(function() {
                console.log('Final verification - booking info content:');
                console.log(document.getElementById('booking-info').innerHTML);
                console.log('Final total content:', document.getElementById('final-total').textContent);
            }, 100);
        });
        
        function determineType(seatNumber) {
            const row = seatNumber.charAt(0);
            if (['A', 'B', 'C'].includes(row)) return 'Normal';
            if (['D', 'E', 'F', 'G'].includes(row)) return 'VIP';
            if (row === 'H') return 'Couple';
            return 'Normal';
        }
        
        function displayBookingInfo() {
            console.log('displayBookingInfo called with data:', bookingData);
            const bookingInfo = document.getElementById('booking-info');
            const finalTotal = document.getElementById('final-total');
            
            if (!bookingInfo || !finalTotal) {
                console.error('DOM elements not found:', { bookingInfo, finalTotal });
                return;
            }
            
            if (!bookingData) {
                console.error('No booking data available');
                bookingInfo.innerHTML = '<p style="color: #eb315a;">No booking information available</p>';
                finalTotal.textContent = 'Total: 0 VNĐ';
                return;
            }
            
            const seatsHtml = bookingData.selectedSeats.map(seat => 
                '<span class="seat-tag">' + seat.number + '</span>'
            ).join('');
            
            bookingInfo.innerHTML = 
                '<p><strong>Movie:</strong> ' + (bookingData.movieTitle || 'N/A') + '</p>' +
                '<p><strong>Theater:</strong> Theater ' + (bookingData.theaterId || 'N/A') + '</p>' +
                '<p><strong>Showtime:</strong> ' + (bookingData.showtime || 'N/A') + '</p>' +
                '<p><strong>Date:</strong> January 20, 2024</p>' +
                '<p><strong>Selected Seats:</strong><br>' + seatsHtml + '</p>' +
                '<p><strong>Number of Seats:</strong> ' + bookingData.selectedSeats.length + '</p>';
                
            console.log('Updated booking info HTML:', bookingInfo.innerHTML);
            
            // Format price using JavaScript toLocaleString
            const totalText = 'Total: ' + bookingData.totalPrice.toLocaleString() + ' VNĐ';
            console.log('Setting total to:', totalText);
            finalTotal.textContent = totalText;
        }
        
        function selectPaymentMethod(method) {
            // Update radio button
            document.querySelector('input[value="' + method + '"]').checked = true;
            
            // Update visual selection
            document.querySelectorAll('.payment-method').forEach(pm => pm.classList.remove('selected'));
            event.currentTarget.classList.add('selected');
        }
        
        function confirmPayment() {
            const selectedPayment = document.querySelector('input[name="payment"]:checked').value;
            
            // Simulate payment processing
            const confirmBtn = document.querySelector('.confirm-btn');
            confirmBtn.innerHTML = '<i class="icofont icofont-spinner"></i> Processing...';
            confirmBtn.disabled = true;
            
            setTimeout(() => {
                // Hide payment form
                document.getElementById('payment-form').style.display = 'none';
                
                // Show success message
                const successMessage = document.getElementById('success-message');
                const ticketDetails = document.getElementById('ticket-details');
                
                // Generate booking reference
                const bookingRef = 'TIX' + Date.now().toString().slice(-6);
                
                const seatsHtml = bookingData.selectedSeats.map(seat => 
                    '<span class="seat-tag">' + seat.number + '</span>'
                ).join('');
                
                ticketDetails.innerHTML = 
                    '<p><strong>Booking Reference:</strong> ' + bookingRef + '</p>' +
                    '<p><strong>Movie:</strong> ' + bookingData.movieTitle + '</p>' +
                    '<p><strong>Theater:</strong> Theater ' + bookingData.theaterId + '</p>' +
                    '<p><strong>Date & Time:</strong> January 20, 2024 - ' + bookingData.showtime + '</p>' +
                    '<p><strong>Seats:</strong> ' + seatsHtml + '</p>' +
                    '<p><strong>Total Paid:</strong> ' + bookingData.totalPrice.toLocaleString() + ' VNĐ</p>' +
                    '<p><strong>Payment Method:</strong> ' + selectedPayment.charAt(0).toUpperCase() + selectedPayment.slice(1) + '</p>' +
                    '<p style="margin-top: 15px; font-size: 0.9rem; color: #ddd;">' +
                        '<i class="icofont icofont-info-circle"></i> Please arrive 15 minutes before showtime. Bring this confirmation.' +
                    '</p>';
                
                successMessage.style.display = 'block';
                
                // Clear booking data from session storage
                sessionStorage.removeItem('bookingData');
                
            }, 2000);
        }
        
        function printTicket() {
            window.print();
        }

        function goBackToTickets() {
            window.location.href = 'cinema?action=buy-tickets';
        }
    </script>
</body>
</html> 