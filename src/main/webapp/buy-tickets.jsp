<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    boolean isLoggedIn = (username != null && role != null);
    
    // Redirect to login if not authenticated
    if (!isLoggedIn) {
        response.sendRedirect("cinema?action=login&message=" + 
            java.net.URLEncoder.encode("You need to login to buy tickets!", "UTF-8"));
        return;
    }
%>
<!DOCTYPE HTML>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Buy Tickets - Cinema Application</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css" media="all" />
    <!-- Main style CSS -->
    <link rel="stylesheet" type="text/css" href="assets/css/style.css" media="all" />
    
    <style>
        body {
            background: #1a1a1a;
            color: #fff;
            font-family: 'Roboto', sans-serif;
        }
        
        .buy-tickets-container {
            min-height: 100vh;
            padding: 50px 0;
        }
        
        .tickets-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .tickets-header h1 {
            color: #eb315a;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .welcome-user {
            background: linear-gradient(135deg, #eb315a, #ff6b9d);
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .movie-selection {
            background: #2a2a2a;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        
        .movie-card {
            background: #333;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            transition: transform 0.3s;
        }
        
        .movie-card:hover {
            transform: translateY(-5px);
        }
        
        .movie-card h4 {
            color: #eb315a;
            margin-bottom: 15px;
        }
        
        .showtime-btn {
            background: linear-gradient(135deg, #eb315a, #ff6b9d);
            color: white;
            border: none;
            padding: 10px 20px;
            margin: 5px;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .showtime-btn:hover {
            background: linear-gradient(135deg, #d12851, #e55a8a);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(235, 49, 90, 0.3);
            color: white;
            text-decoration: none;
        }
        
        .back-home {
            position: fixed;
            top: 20px;
            left: 20px;
            background: #eb315a;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s;
        }
        
        .back-home:hover {
            background: #d12851;
            color: white;
            text-decoration: none;
        }
        
        .logout-btn {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #666;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/" class="back-home">
        <i class="icofont icofont-arrow-left"></i> Back to Home
    </a>
    
    <a href="${pageContext.request.contextPath}/cinema?action=logout" class="logout-btn">
        Logout
    </a>

    <div class="buy-tickets-container">
        <div class="container">
            <div class="tickets-header">
                <h1><i class="icofont icofont-ticket"></i> Buy Movie Tickets</h1>
                <p>Choose your favorite movie and showtime</p>
            </div>
            
            <div class="welcome-user">
                <h3>🎬 Welcome, <%= username %>!</h3>
                <p>You are logged in as: <strong><%= role %></strong></p>
            </div>
            
            <div class="movie-selection">
                <h2 style="text-align: center; margin-bottom: 30px; color: #eb315a;">
                    <i class="icofont icofont-movie"></i> Phim Đang Chiếu
                </h2>
                
                <!-- Movie 1: Squid Game -->
                <div class="movie-card">
                    <div class="row">
                        <div class="col-md-3">
                            <img src="assets/img/thesaart-squid-game-concept-art-thesaart.png" 
                                 alt="Squid Game" style="width: 100%; border-radius: 10px;">
                        </div>
                        <div class="col-md-9">
                            <h4>Squid Game</h4>
                            <p><strong>Thể loại:</strong> Kinh dị, Hành động</p>
                            <p><strong>Thời lượng:</strong> 120 phút</p>
                            <p><strong>Đánh giá:</strong> 180k voters</p>
                            <p>Hundreds of cash-strapped players accept a strange invitation to compete in children's games...</p>
                            
                            <div style="margin-top: 20px;">
                                <h5 style="color: #eb315a; margin-bottom: 15px;">Suất chiếu hôm nay:</h5>
                                <a href="cinema?action=seat-selection&showtimeId=1" class="showtime-btn">10:00</a>
                                <a href="cinema?action=seat-selection&showtimeId=2" class="showtime-btn">13:00</a>
                                <a href="cinema?action=seat-selection&showtimeId=3" class="showtime-btn">16:00</a>
                                <a href="cinema?action=seat-selection&showtimeId=4" class="showtime-btn">19:00</a>
                                <a href="cinema?action=seat-selection&showtimeId=5" class="showtime-btn">22:00</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Movie 2: Last Avatar -->
                <div class="movie-card">
                    <div class="row">
                        <div class="col-md-3">
                            <img src="assets/img/slide1.png" 
                                 alt="Last Avatar" style="width: 100%; border-radius: 10px;">
                        </div>
                        <div class="col-md-9">
                            <h4>Last Avatar</h4>
                            <p><strong>Thể loại:</strong> Phiêu lưu, Giả tưởng</p>
                            <p><strong>Thời lượng:</strong> 135 phút</p>
                            <p><strong>Đánh giá:</strong> 180k voters</p>
                            <p>A young airbender must master all four elements to save the world from the Fire Nation's tyranny...</p>
                            
                            <div style="margin-top: 20px;">
                                <h5 style="color: #eb315a; margin-bottom: 15px;">Suất chiếu hôm nay:</h5>
                                <a href="cinema?action=seat-selection&showtimeId=6" class="showtime-btn">09:30</a>
                                <a href="cinema?action=seat-selection&showtimeId=7" class="showtime-btn">12:30</a>
                                <a href="cinema?action=seat-selection&showtimeId=8" class="showtime-btn">15:30</a>
                                <a href="cinema?action=seat-selection&showtimeId=9" class="showtime-btn">18:30</a>
                                <a href="cinema?action=seat-selection&showtimeId=10" class="showtime-btn">21:30</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Movie 3: The Deer God -->
                <div class="movie-card">
                    <div class="row">
                        <div class="col-md-3">
                            <div style="width: 100%; height: 200px; background: linear-gradient(135deg, #eb315a, #ff6b9d); 
                                        border-radius: 10px; display: flex; align-items: center; justify-content: center;">
                                <i class="icofont icofont-movie" style="font-size: 4rem; color: white;"></i>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <h4>The Deer God</h4>
                            <p><strong>Thể loại:</strong> Adventure, Fantasy</p>
                            <p><strong>Thời lượng:</strong> 110 phút</p>
                            <p><strong>Đánh giá:</strong> 95k voters</p>
                            <p>A mystical forest deity protects the balance between nature and civilization...</p>
                            
                            <div style="margin-top: 20px;">
                                <h5 style="color: #eb315a; margin-bottom: 15px;">Suất chiếu hôm nay:</h5>
                                <a href="cinema?action=seat-selection&showtimeId=11" class="showtime-btn">11:00</a>
                                <a href="cinema?action=seat-selection&showtimeId=12" class="showtime-btn">14:00</a>
                                <a href="cinema?action=seat-selection&showtimeId=13" class="showtime-btn">17:00</a>
                                <a href="cinema?action=seat-selection&showtimeId=14" class="showtime-btn">20:00</a>
                                <a href="cinema?action=seat-selection&showtimeId=15" class="showtime-btn">23:00</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Selected showtime display -->
            <div id="selected-showtime" style="display: none; background: #eb315a; padding: 20px; border-radius: 10px; text-align: center; margin-top: 20px;">
                <h4 style="color: white; margin-bottom: 15px;">You have selected:</h4>
                <p id="showtime-details" style="color: white; font-size: 1.2rem; margin-bottom: 20px;"></p>
                <button class="showtime-btn" style="background: white; color: #eb315a;" onclick="proceedToSeatSelection()">
                    Tiếp tục chọn ghế <i class="icofont icofont-arrow-right"></i>
                </button>
                <button class="showtime-btn" style="background: transparent; border: 2px solid white;" onclick="cancelSelection()">
                    Hủy chọn
                </button>
            </div>
            
        </div>
    </div>
    
    <script>
        // Auto-scroll to top on load
        window.scrollTo(0, 0);
    </script>
</body>
</html> 