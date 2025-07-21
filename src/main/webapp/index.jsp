<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    boolean isLoggedIn = (username != null && role != null);
%>
<!DOCTYPE HTML>
<html lang="zxx">
	
<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Moviepoint - Online Movie,Vedio and TV Show HTML Template</title>
		<!-- Favicon Icon -->
		<link rel="icon" type="image/png" href="assets/img/favcion.png" />
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css" media="all" />
		<!-- Slick nav CSS -->
		<link rel="stylesheet" type="text/css" href="assets/css/slicknav.min.css" media="all" />
		<!-- Iconfont CSS -->
		<link rel="stylesheet" type="text/css" href="assets/css/icofont.css" media="all" />
		<!-- Owl carousel CSS -->
		<link rel="stylesheet" type="text/css" href="assets/css/owl.carousel.css">
		<!-- Popup CSS -->
		<link rel="stylesheet" type="text/css" href="assets/css/magnific-popup.css">
		<!-- Main style CSS -->
		<link rel="stylesheet" type="text/css" href="assets/css/style.css" media="all" />
		<!-- Responsive CSS -->
		<link rel="stylesheet" type="text/css" href="assets/css/responsive.css" media="all" />
		<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
	</head>
	<body>
		<!-- Page loader -->
	    <div id="preloader"></div>
		<!-- header section start -->
		<header class="header">
			<div class="container">
				<div class="header-area">
					<div class="logo">
						<a href="/"><img src="assets/img/logo.png" alt="logo" /></a>
					</div>
					<div class="header-right">
						<form action="#">
							<select>
								<option value="Movies">Movies</option>
								<option value="Movies">Movies</option>
								<option value="Movies">Movies</option>
							</select>
							<input type="text"/>
							<button><i class="icofont icofont-search"></i></button>
						</form>
						<ul>
							<% if (isLoggedIn) { %>
								<li><a>Welcome, <%= username %>!</a></li>
								<% if ("admin".equals(role)) { %>
									<li><a href="admin">Admin Panel</a></li>
								<% } else if ("employee".equals(role)) { %>
									<li><a href="employee">Employee Dashboard</a></li>
								<% } %>
								<li><a href="cinema?action=logout">Logout</a></li>
							<% } else { %>
								<li><a href="#">Welcome Guest!</a></li>
								<li><a class="login-popup" href="cinema?action=login">Login</a></li>
							<% } %>
						</ul>
					</div>
					<div class="menu-area">
						<div class="responsive-menu"></div>
					    <div class="mainmenu">
                            <ul id="primary-menu">
                                <li><a class="active" href="/">Home</a></li>
                                <li><a href="movies.html">Movies</a></li>
                                <li><a href="celebrities.html">CelebritiesList</a></li>
                                <li><a href="top-movies.html">Top Movies</a></li>
                                <li><a href="blog.html">News</a></li>
								<li><a href="#">Pages <i class="icofont icofont-simple-down"></i></a>
									<ul>
										<li><a href="blog-details.html">Blog Details</a></li>
										<li><a href="movie-details.html">Movie Details</a></li>
									</ul>
								</li>
                                <li><a class="theme-btn" href="#"><i class="icofont icofont-ticket"></i> Tickets</a></li>
                            </ul>
					    </div>
					</div>
				</div>
			</div>
		</header>
		<div class="login-area">
			<div class="login-box">
				<a href="#"><i class="icofont icofont-close"></i></a>
				
				<!-- Message display area -->
				<div id="auth-message" style="display: none; padding: 10px; margin-bottom: 15px; border-radius: 4px; text-align: center; font-size: 14px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;"></div>
				
				<!-- Login Form -->
				<div id="loginForm">
					<h2>LOGIN</h2>
					<form action="cinema?action=login" method="post">
						<input type="hidden" name="source" value="home" />
						<h6>USERNAME OR EMAIL ADDRESS</h6>
						<input type="text" name="username" required />
						<h6>PASSWORD</h6>
						<input type="password" name="password" required />
						<div class="login-remember">
							<input type="checkbox" name="remember" />
							<span>Remember Me</span>
						</div>
						<div class="login-signup">
							<span onclick="toggleAuthForms()" style="cursor: pointer; color: #008aff;">SIGNUP</span>
						</div>
						<button type="submit" class="theme-btn" style="border: none; background: none; color: inherit; width: 100%; text-align: center;">LOG IN</button>
						<span>Or Via Social</span>
						<div class="login-social">
							<a href="#"><i class="icofont icofont-social-facebook"></i></a>
							<a href="#"><i class="icofont icofont-social-twitter"></i></a>
							<a href="#"><i class="icofont icofont-social-linkedin"></i></a>
							<a href="#"><i class="icofont icofont-social-google-plus"></i></a>
							<a href="#"><i class="icofont icofont-camera"></i></a>
						</div>
					</form>
				</div>

				<!-- Signup Form -->
				<div id="signupForm" style="display: none;">
					<h2>SIGN UP</h2>
					<form action="cinema?action=signup" method="post" onsubmit="return validateSignupForm()">
						<input type="hidden" name="source" value="home" />
						<h6>USERNAME</h6>
						<input type="text" id="signup-username" name="username" required />
						<div class="error-message" id="username-error" style="display: none; color: red; font-size: 12px; margin-top: 5px;"></div>
						<h6>PASSWORD</h6>
						<input type="password" id="signup-password" name="password" required />
						<div class="error-message" id="password-error" style="display: none; color: red; font-size: 12px; margin-top: 5px;"></div>
						<h6>CONFIRM PASSWORD</h6>
						<input type="password" id="signup-confirm-password" name="confirmPassword" required />
						<div class="error-message" id="confirm-password-error" style="display: none; color: red; font-size: 12px; margin-top: 5px;"></div>
						<div class="login-signup">
							<span onclick="toggleAuthForms()" style="cursor: pointer; color: #008aff;">LOGIN</span>
						</div>
						<button type="submit" class="theme-btn" style="border: none; background: none; color: inherit; width: 100%; text-align: center;">SIGN UP</button>
						<span>Or Via Social</span>
						<div class="login-social">
							<a href="#"><i class="icofont icofont-social-facebook"></i></a>
							<a href="#"><i class="icofont icofont-social-twitter"></i></a>
							<a href="#"><i class="icofont icofont-social-linkedin"></i></a>
							<a href="#"><i class="icofont icofont-social-google-plus"></i></a>
							<a href="#"><i class="icofont icofont-camera"></i></a>
						</div>
					</form>
				</div>
				
			</div>
		</div>
		<div class="buy-ticket">
			<div class="container">
				<div class="buy-ticket-area">
					<a href="#"><i class="icofont icofont-close"></i></a>
					<div class="row">
						<div class="col-lg-8">
							<div class="buy-ticket-box">
								<h4>Buy Tickets</h4>
								<h5>Seat</h5>
								<h6>Screen</h6>
								<div class="ticket-box-table">
									<table class="ticket-table-seat">
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
									</table>
									<table>
										<tr>
											<td>1</td>
										</tr>
										<tr>
											<td>2</td>
										</tr>
										<tr>
											<td>3</td>
										</tr>
										<tr>
											<td>4</td>
										</tr>
										<tr>
											<td>5</td>
										</tr>
									</table>
									<table class="ticket-table-seat">
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
										<tr>
											<td class="active">1</td>
											<td class="active">1</td>
											<td class="active">1</td>
											<td class="active">1</td>
											<td class="active">1</td>
											<td class="active">1</td>
											<td class="active">1</td>
										</tr>
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
									</table>
									<table>
										<tr>
											<td>1</td>
										</tr>
										<tr>
											<td>2</td>
										</tr>
										<tr>
											<td>3</td>
										</tr>
										<tr>
											<td>4</td>
										</tr>
										<tr>
											<td>5</td>
										</tr>
									</table>
									<table class="ticket-table-seat">
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
										<tr>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
											<td>1</td>
										</tr>
									</table>
								</div>
								<div class="ticket-box-available">
									<input type="checkbox" />
									<span>Available</span>
									<input type="checkbox" checked />
									<span>Unavailable</span>
									<input type="checkbox" />
									<span>Selected</span>
								</div>
								<a href="#" class="theme-btn">previous</a>
								<a href="#" class="theme-btn">Next</a>
							</div>
						</div>
						<div class="col-lg-3 offset-lg-1">
							<div class="buy-ticket-box mtr-30">
								<h4>Your Information</h4>
								<ul>
									<li>
										<p>Location</p>
										<span>HB Cinema Box Corner</span>
									</li>
									<li>
										<p>TIME</p>
										<span>2018.07.09   20:40</span>
									</li>
									<li>
										<p>Movie name</p>
										<span>Home Alone</span>
									</li>
									<li>
										<p>Ticket number</p>
										<span>2 Adults, 2 Children, 2 Seniors</span>
									</li>
									<li>
										<p>Price</p>
										<span>89$</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div><!-- header section end -->
		<!-- hero area start -->
		<section class="hero-area" id="home">
			<div class="container">
				<div class="hero-area-slider">
					<div class="row hero-area-slide">
						<div class="col-lg-6 col-md-5">
							<div class="hero-area-content">
								<img src="assets/img/thesaart-squid-game-concept-art-thesaart.png" alt="about" />
							</div>
						</div>
						<div class="col-lg-6 col-md-7">
							<div class="hero-area-content pr-50">
								<h2>Squid Game</h2>
								<div class="review">
									<div class="author-review">
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
									</div>
									<h4>180k voters</h4>
								</div>
								<p class="movie-description">
									<span class="description-short">Hundreds of cash-strapped players accept a strange invitation to compete in children's games. Inside, a tempting prize awaits with deadly high stakes...</span>
									<span class="description-full" style="display: none;">Hundreds of cash-strapped players accept a strange invitation to compete in children's games. Inside, a tempting prize awaits with deadly high stakes. A survival game that has a 45.6 billion-won prize at stake. The series revolves around a contest where 456 players, all of whom are in deep financial hardship, risk their lives to play a series of deadly children's games for the chance to win a ₩45.6 billion prize.</span>
									<span class="read-more-btn" onclick="toggleDescription(this)" style="color: #eb315a; cursor: pointer; margin-left: 5px;">Read more</span>
								</p>
								<div class="slide-trailor">
									<a class="theme-btn theme-btn2" href="#" onclick="handleTicketClick(); return false;"><i class="icofont icofont-play"></i> Tickets</a>
								</div>
							</div>
						</div>
					</div>
					<div class="row hero-area-slide">
						<div class="col-lg-6 col-md-5">
							<div class="hero-area-content">
								<img src="assets/img/slide1.png" alt="about" />
							</div>
						</div>
						<div class="col-lg-6 col-md-7">
							<div class="hero-area-content pr-50">
								<h2>Last Avatar</h2>
								<div class="review">
									<div class="author-review">
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
									</div>
									<h4>180k voters</h4>
								</div>
								<p class="movie-description">
									<span class="description-short">A young airbender must master all four elements to save the world from the Fire Nation's tyranny...</span>
									<span class="description-full" style="display: none;">A young airbender must master all four elements to save the world from the Fire Nation's tyranny. Follow Aang and his friends as they journey across the world to defeat the Fire Lord and restore balance to the Avatar world. An epic adventure filled with martial arts, elemental magic, and timeless themes of friendship and courage.</span>
									<span class="read-more-btn" onclick="toggleDescription(this)" style="color: #eb315a; cursor: pointer; margin-left: 5px;">Read more</span>
								</p>
								<div class="slide-trailor">
									<a class="theme-btn theme-btn2" href="#" onclick="handleTicketClick(); return false;"><i class="icofont icofont-play"></i> Tickets</a>
								</div>
							</div>
						</div>
					</div>
					<div class="row hero-area-slide">
						<div class="col-lg-6 col-md-5">
							<div class="hero-area-content">
								<img src="assets/img/slide3.png" alt="about" />
							</div>
						</div>
						<div class="col-lg-6 col-md-7">
							<div class="hero-area-content pr-50">
								<h2>The Deer God</h2>
								<div class="review">
									<div class="author-review">
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
									</div>
									<h4>180k voters</h4>
								</div>
								<p class="movie-description">
									<span class="description-short">A mystical forest deity protects the balance between nature and civilization in this epic fantasy adventure...</span>
									<span class="description-full" style="display: none;">A mystical forest deity protects the balance between nature and civilization in this epic fantasy adventure. When humans threaten the sacred forest, the Deer God must make difficult choices to preserve the harmony between all living things. A visually stunning tale of environmental protection and spiritual awakening.</span>
									<span class="read-more-btn" onclick="toggleDescription(this)" style="color: #eb315a; cursor: pointer; margin-left: 5px;">Read more</span>
								</p>
								<div class="slide-trailor">
									<a class="theme-btn theme-btn2" href="#" onclick="handleTicketClick(); return false;"><i class="icofont icofont-play"></i> Tickets</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="hero-area-thumb">
					<div class="thumb-prev">
						<div class="row hero-area-slide">
							<div class="col-lg-6">
								<div class="hero-area-content">
									<img src="assets/img/slide3.png" alt="about" />
								</div>
							</div>
							<div class="col-lg-6">
								<div class="hero-area-content pr-50">
									<h2>Last Avatar</h2>
									<div class="review">
										<div class="author-review">
											<i class="icofont icofont-star"></i>
											<i class="icofont icofont-star"></i>
											<i class="icofont icofont-star"></i>
											<i class="icofont icofont-star"></i>
											<i class="icofont icofont-star"></i>
										</div>
										<h4>180k voters</h4>
									</div>
									<p class="movie-description">
										<span class="description-short">A young airbender must master all four elements to save the world from the Fire Nation's tyranny...</span>
										<span class="description-full" style="display: none;">A young airbender must master all four elements to save the world from the Fire Nation's tyranny. Follow Aang and his friends as they journey across the world to defeat the Fire Lord and restore balance to the Avatar world. An epic adventure filled with martial arts, elemental magic, and timeless themes of friendship and courage.</span>
										<span class="read-more-btn" onclick="toggleDescription(this)" style="color: #eb315a; cursor: pointer; margin-left: 5px;">Read more</span>
									</p>
									<div class="slide-trailor">
										<a class="theme-btn theme-btn2" href="#" onclick="handleTicketClick(); return false;"><i class="icofont icofont-play"></i> Tickets</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="thumb-next">
						<div class="row hero-area-slide">
							<div class="col-lg-6">
								<div class="hero-area-content">
									<img src="assets/img/slide1.png" alt="about" />
								</div>
							</div>
							<div class="col-lg-6">
								<div class="hero-area-content pr-50">
									<h2>The Deer God</h2>
									<div class="review">
										<div class="author-review">
											<i class="icofont icofont-star"></i>
											<i class="icofont icofont-star"></i>
											<i class="icofont icofont-star"></i>
											<i class="icofont icofont-star"></i>
											<i class="icofont icofont-star"></i>
										</div>
										<h4>180k voters</h4>
									</div>
									<p class="movie-description">
										<span class="description-short">A mystical forest deity protects the balance between nature and civilization in this epic fantasy adventure...</span>
										<span class="description-full" style="display: none;">A mystical forest deity protects the balance between nature and civilization in this epic fantasy adventure. When humans threaten the sacred forest, the Deer God must make difficult choices to preserve the harmony between all living things. A visually stunning tale of environmental protection and spiritual awakening.</span>
										<span class="read-more-btn" onclick="toggleDescription(this)" style="color: #eb315a; cursor: pointer; margin-left: 5px;">Read more</span>
									</p>
									<div class="slide-trailor">
										<a class="theme-btn theme-btn2" href="#" onclick="handleTicketClick(); return false;"><i class="icofont icofont-play"></i> Tickets</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section><!-- hero area end -->
		<!-- portfolio section start -->
		<section class="portfolio-area pt-60">
			<div class="container">
				<div class="row flexbox-center">
					<div class="col-lg-6 text-center text-lg-left">
					    <div class="section-title">
							<h1><i class="icofont icofont-movie"></i> Spotlight This Month</h1>
						</div>
					</div>
					<div class="col-lg-6 text-center text-lg-right">
					    <div class="portfolio-menu">
							<ul>
								<li data-filter="*" class="active">Latest</li>
								<li data-filter=".soon">Comming Soon</li>
								<li data-filter=".top">Top Rated</li>
								<li data-filter=".released">Recently Released</li>
							</ul>
						</div>
					</div>
				</div>
				<hr />
				<div class="row">
					<div class="col-lg-9">
						<div class="row portfolio-item">
							<div class="col-md-4 col-sm-6 soon released">
								<div class="single-portfolio">
									<div class="single-portfolio-img">
										<img src="assets/img/portfolio/portfolio1.png" alt="portfolio" />
										<a href="https://www.youtube.com/watch?v=RZXnugbhw_4" class="popup-youtube">
											<i class="icofont icofont-ui-play"></i>
										</a>
									</div>
									<div class="portfolio-content">
										<h2>Boyz II Men</h2>
										<div class="review">
											<div class="author-review">
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
											</div>
											<h4>180k voters</h4>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4 col-sm-6 top">
								<div class="single-portfolio">
									<div class="single-portfolio-img">
										<img src="assets/img/portfolio/portfolio2.png" alt="portfolio" />
										<a href="https://www.youtube.com/watch?v=RZXnugbhw_4" class="popup-youtube">
											<i class="icofont icofont-ui-play"></i>
										</a>
									</div>
									<div class="portfolio-content">
										<h2>Tale of Revemge</h2>
										<div class="review">
											<div class="author-review">
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
											</div>
											<h4>180k voters</h4>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4 col-sm-6 soon">
								<div class="single-portfolio">
									<div class="single-portfolio-img">
										<img src="assets/img/portfolio/portfolio3.png" alt="portfolio" />
										<a href="https://www.youtube.com/watch?v=RZXnugbhw_4" class="popup-youtube">
											<i class="icofont icofont-ui-play"></i>
										</a>
									</div>
									<div class="portfolio-content">
										<h2>The Lost City of Z</h2>
										<div class="review">
											<div class="author-review">
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
											</div>
											<h4>180k voters</h4>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4 col-sm-6 top released">
								<div class="single-portfolio">
									<div class="single-portfolio-img">
										<img src="assets/img/portfolio/portfolio4.png" alt="portfolio" />
										<a href="https://www.youtube.com/watch?v=RZXnugbhw_4" class="popup-youtube">
											<i class="icofont icofont-ui-play"></i>
										</a>
									</div>
									<div class="portfolio-content">
										<h2>Beast Beauty</h2>
										<div class="review">
											<div class="author-review">
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
											</div>
											<h4>180k voters</h4>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4 col-sm-6 released">
								<div class="single-portfolio">
									<div class="single-portfolio-img">
										<img src="assets/img/portfolio/portfolio5.png" alt="portfolio" />
										<a href="https://www.youtube.com/watch?v=RZXnugbhw_4" class="popup-youtube">
											<i class="icofont icofont-ui-play"></i>
										</a>
									</div>
									<div class="portfolio-content">
										<h2>In The Fade</h2>
										<div class="review">
											<div class="author-review">
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
											</div>
											<h4>180k voters</h4>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4 col-sm-6 soon top">
								<div class="single-portfolio">
									<div class="single-portfolio-img">
										<img src="assets/img/portfolio/portfolio6.png" alt="portfolio" />
										<a href="https://www.youtube.com/watch?v=RZXnugbhw_4" class="popup-youtube">
											<i class="icofont icofont-ui-play"></i>
										</a>
									</div>
									<div class="portfolio-content">
										<h2>Last Hero</h2>
										<div class="review">
											<div class="author-review">
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
												<i class="icofont icofont-star"></i>
											</div>
											<h4>180k voters</h4>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-3 text-center text-lg-left">
					    <div class="portfolio-sidebar">
							<img src="assets/img/sidebar/sidebar1.png" alt="sidebar" />
							<img src="assets/img/sidebar/sidebar2.png" alt="sidebar" />
							<img src="assets/img/sidebar/sidebar3.png" alt="sidebar" />
							<img src="assets/img/sidebar/sidebar4.png" alt="sidebar" />
						</div>
					</div>
				</div>
			</div>
		</section><!-- portfolio section end -->
		<!-- video section start -->
		<section class="video ptb-90">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
					    <div class="section-title pb-20">
							<h1><i class="icofont icofont-film"></i> Trailers & Videos</h1>
						</div>
					</div>
				</div>
				<hr />
				<div class="row">
                    <div class="col-md-9">
						<div class="video-area">
							<img src="assets/img/video/video1.png" alt="video" />
							<a href="https://www.youtube.com/watch?v=RZXnugbhw_4" class="popup-youtube">
								<i class="icofont icofont-ui-play"></i>
							</a>
							<div class="video-text">
								<h2>Angle of Death</h2>
								<div class="review">
									<div class="author-review">
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
										<i class="icofont icofont-star"></i>
									</div>
									<h4>180k voters</h4>
								</div>
							</div>
						</div>
                    </div>
                    <div class="col-md-3">
						<div class="row">
							<div class="col-md-12 col-sm-6">
								<div class="video-area">
									<img src="assets/img/video/video2.png" alt="video" />
									<a href="https://www.youtube.com/watch?v=RZXnugbhw_4" class="popup-youtube">
										<i class="icofont icofont-ui-play"></i>
									</a>
								</div>
							</div>
							<div class="col-md-12 col-sm-6">
								<div class="video-area">
									<img src="assets/img/video/video3.png" alt="video" />
									<a href="https://www.youtube.com/watch?v=RZXnugbhw_4" class="popup-youtube">
										<i class="icofont icofont-ui-play"></i>
									</a>
								</div>
							</div>
						</div>
                    </div>
				</div>
			</div>
		</section><!-- video section end -->
		<!-- news section start -->
		<section class="news">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
					    <div class="section-title pb-20">
							<h1><i class="icofont icofont-coffee-cup"></i> Latest News</h1>
						</div>
					</div>
				</div>
				<hr />
			</div>
			<div class="news-slide-area">
				<div class="news-slider">
					<div class="single-news">
						<div class="news-bg-1"></div>
						<div class="news-date">
							<h2><span>NOV</span> 25</h2>
							<h1>2017</h1>
						</div>
						<div class="news-content">
							<h2>The Witch Queen</h2>
							<p>Witch Queen is a tall woman with a slim build. She has pink hair, which is pulled up under her hat, and teal eyes.</p>
						</div>
						<a href="#">Read More</a>
					</div>
					<div class="single-news">
						<div class="news-bg-2"></div>
						<div class="news-date">
							<h2><span>NOV</span> 25</h2>
							<h1>2017</h1>
						</div>
						<div class="news-content">
							<h2>The Witch Queen</h2>
							<p>Witch Queen is a tall woman with a slim build. She has pink hair, which is pulled up under her hat, and teal eyes.</p>
						</div>
						<a href="#">Read More</a>
					</div>
					<div class="single-news">
						<div class="news-bg-3"></div>
						<div class="news-date">
							<h2><span>NOV</span> 25</h2>
							<h1>2017</h1>
						</div>
						<div class="news-content">
							<h2>The Witch Queen</h2>
							<p>Witch Queen is a tall woman with a slim build. She has pink hair, which is pulled up under her hat, and teal eyes.</p>
						</div>
						<a href="#">Read More</a>
					</div>
				</div>
				<div class="news-thumb">
					<div class="news-next">
						<div class="single-news">
							<div class="news-bg-3"></div>
							<div class="news-date">
								<h2><span>NOV</span> 25</h2>
								<h1>2017</h1>
							</div>
							<div class="news-content">
								<h2>The Witch Queen</h2>
								<p>Witch Queen is a tall woman with a slim build. She has pink hair, which is pulled up under her hat, and teal eyes.</p>
							</div>
							<a href="#">Read More</a>
						</div>
					</div>
					<div class="news-prev">
						<div class="single-news">
							<div class="news-bg-2"></div>
							<div class="news-date">
								<h2><span>NOV</span> 25</h2>
								<h1>2017</h1>
							</div>
							<div class="news-content">
								<h2>The Witch Queen</h2>
								<p>Witch Queen is a tall woman with a slim build. She has pink hair, which is pulled up under her hat, and teal eyes.</p>
							</div>
							<a href="#">Read More</a>
						</div>
					</div>
				</div>
			</div>
		</section><!-- news section end -->
		<!-- footer section start -->
		<footer class="footer">
			<div class="container">
				<div class="row">
                    <div class="col-lg-3 col-sm-6">
						<div class="widget">
							<img src="assets/img/logo.png" alt="about" />
							<p>7th Harley Place, London W1G 8LZ United Kingdom</p>
							<h6><span>Call us: </span>(+880) 111 222 3456</h6>
						</div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
						<div class="widget">
							<h4>Legal</h4>
							<ul>
								<li><a href="#">Terms of Use</a></li>
								<li><a href="#">Privacy Policy</a></li>
								<li><a href="#">Security</a></li>
							</ul>
						</div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
						<div class="widget">
							<h4>Account</h4>
							<ul>
								<li><a href="#">My Account</a></li>
								<li><a href="#">Watchlist</a></li>
								<li><a href="#">Collections</a></li>
								<li><a href="#">User Guide</a></li>
							</ul>
						</div>
                    </div>
                    <div class="col-lg-3 col-sm-6">
						<div class="widget">
							<h4>Newsletter</h4>
							<p>Subscribe to our newsletter system now to get latest news from us.</p>
							<form action="#">
								<input type="text" placeholder="Enter your email.."/>
								<button>SUBSCRIBE NOW</button>
							</form>
						</div>
                    </div>
				</div>
				<hr />
			</div>
			<div class="copyright">
				<div class="container">
					<div class="row">
						<div class="col-lg-6 text-center text-lg-left">
							<div class="copyright-content">
								<p><a target="_blank" href="https://www.templateshub.net">Templates Hub</a></p>
							</div>
						</div>
						<div class="col-lg-6 text-center text-lg-right">
							<div class="copyright-content">
								<a href="#" class="scrollToTop">
									Back to top<i class="icofont icofont-arrow-up"></i>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</footer><!-- footer section end -->
		<!-- jquery main JS -->
		<script src="assets/js/jquery.min.js"></script>
		<!-- Bootstrap JS -->
		<script src="assets/js/bootstrap.min.js"></script>
		<!-- Slick nav JS -->
		<script src="assets/js/jquery.slicknav.min.js"></script>
		<!-- owl carousel JS -->
		<script src="assets/js/owl.carousel.min.js"></script>
		<!-- Popup JS -->
		<script src="assets/js/jquery.magnific-popup.min.js"></script>
		<!-- Isotope JS -->
		<script src="assets/js/isotope.pkgd.min.js"></script>
		<!-- main JS -->
		<script src="assets/js/main.js"></script>
		
		<!-- Custom JavaScript for Auth Forms -->
		<script>
			// Toggle between login and signup forms
			function toggleAuthForms() {
				const loginForm = document.getElementById('loginForm');
				const signupForm = document.getElementById('signupForm');
				
				if (loginForm.style.display === 'none') {
					loginForm.style.display = 'block';
					signupForm.style.display = 'none';
				} else {
					loginForm.style.display = 'none';
					signupForm.style.display = 'block';
				}
				
				// Clear any error messages
				const messageDiv = document.getElementById('auth-message');
				if (messageDiv) {
					messageDiv.style.display = 'none';
				}
				clearAllErrors();
			}
			
			// Validate signup form
			function validateSignupForm() {
				const username = document.getElementById('signup-username').value.trim();
				const password = document.getElementById('signup-password').value.trim();
				const confirmPassword = document.getElementById('signup-confirm-password').value.trim();
				
				let isValid = true;
				
				// Clear previous errors
				clearAllErrors();
				
				// Username validation
				if (username.length < 3) {
					showInputError('signup-username', 'username-error', 'Username must be at least 3 characters long');
					isValid = false;
				}
				
				// Password validation
				if (password.length < 6) {
					showInputError('signup-password', 'password-error', 'Password must be at least 6 characters long');
					isValid = false;
				}
				
				// Confirm password validation
				if (password !== confirmPassword) {
					showInputError('signup-confirm-password', 'confirm-password-error', 'Passwords do not match');
					isValid = false;
				}
				
				if (!isValid) {
					return false;
				}
				
				// Show loading state
				const submitBtn = document.querySelector('#signupForm button[type="submit"]');
				const originalText = submitBtn.textContent;
				submitBtn.textContent = 'Signing up...';
				submitBtn.disabled = true;
				
				// Reset button state after delay (in case of errors)
				setTimeout(function() {
					submitBtn.textContent = originalText;
					submitBtn.disabled = false;
				}, 5000);
				
				return true;
			}
			
			// Show input error
			function showInputError(inputId, errorId, message) {
				const input = document.getElementById(inputId);
				const errorDiv = document.getElementById(errorId);
				
				if (input && errorDiv) {
					input.style.borderColor = 'red';
					errorDiv.textContent = message;
					errorDiv.style.display = 'block';
				}
			}
			
			// Clear input error
			function clearInputError(inputId, errorId) {
				const input = document.getElementById(inputId);
				const errorDiv = document.getElementById(errorId);
				
				if (input && errorDiv) {
					input.style.borderColor = '';
					errorDiv.style.display = 'none';
				}
			}
			
			// Clear all errors
			function clearAllErrors() {
				const errorMessages = document.querySelectorAll('.error-message');
				const inputs = document.querySelectorAll('#signupForm input');
				
				errorMessages.forEach(function(error) {
					error.style.display = 'none';
				});
				
				inputs.forEach(function(input) {
					input.style.borderColor = '';
				});
			}
			
			// Display server errors
			function displayServerError(message) {
				const messageDiv = document.getElementById('auth-message');
				if (messageDiv) {
					messageDiv.textContent = message;
					messageDiv.style.display = 'block';
				}
			}
			
			// Real-time validation
			function validateUsername() {
				const username = document.getElementById('signup-username').value.trim();
				if (username.length > 0 && username.length < 3) {
					showInputError('signup-username', 'username-error', 'Username must be at least 3 characters long');
				} else {
					clearInputError('signup-username', 'username-error');
				}
			}
			
			// Initialize event listeners when page loads
			document.addEventListener('DOMContentLoaded', function() {
				// Check for messages in URL parameters
				const urlParams = new URLSearchParams(window.location.search);
				const message = urlParams.get('message');
				const type = urlParams.get('type');
				
				if (message) {
					const decodedMessage = decodeURIComponent(message);
					
					// Style based on message type
					if (type === 'success') {
						// Success message - show in main message div
						const messageDiv = document.getElementById('auth-message');
						if (messageDiv) {
							messageDiv.textContent = decodedMessage;
							messageDiv.style.color = '#155724';
							messageDiv.style.background = '#d4edda';
							messageDiv.style.border = '1px solid #c3e6cb';
							messageDiv.style.display = 'block';
						}
						// Show login form for successful signup
						document.getElementById('loginForm').style.display = 'block';
						document.getElementById('signupForm').style.display = 'none';
					} else {
						// Error message - show in main message div
						const messageDiv = document.getElementById('auth-message');
						if (messageDiv) {
							messageDiv.textContent = decodedMessage;
							messageDiv.style.color = '#721c24';
							messageDiv.style.background = '#f8d7da';
							messageDiv.style.border = '1px solid #f5c6cb';
							messageDiv.style.display = 'block';
						}
						
						// Show appropriate form based on error type
						if (decodedMessage.includes('registration') || decodedMessage.includes('Registration') ||
						    decodedMessage.includes('confirmation') || decodedMessage.includes('exists')) {
							// Signup errors - show signup form
							document.getElementById('loginForm').style.display = 'none';
							document.getElementById('signupForm').style.display = 'block';
						} else {
							// Login errors - show login form
							document.getElementById('loginForm').style.display = 'block';
							document.getElementById('signupForm').style.display = 'none';
						}
					}
					
					// Auto-open auth popup if there's a message
					document.querySelector('.login-area').classList.add('active');
					
					// Clear URL parameters after displaying message
					if (window.history.replaceState) {
						window.history.replaceState({}, document.title, window.location.pathname);
					}
				}
				
				// Handle login form submission
				const loginForm = document.querySelector('#loginForm form');
				if (loginForm) {
					loginForm.addEventListener('submit', function(e) {
						const username = this.querySelector('input[name="username"]').value.trim();
						const password = this.querySelector('input[name="password"]').value.trim();
						
						if (!username || !password) {
							e.preventDefault();
							const messageDiv = document.getElementById('auth-message');
							messageDiv.textContent = 'Please fill in all information!';
							messageDiv.style.display = 'block';
							return false;
						}
						
						// Show loading state
						const submitBtn = this.querySelector('button[type="submit"]');
						const originalText = submitBtn.textContent;
						submitBtn.textContent = 'Logging in...';
						submitBtn.disabled = true;
						
						// Clear any previous error messages
						const messageDiv = document.getElementById('auth-message');
						if (messageDiv) {
							messageDiv.style.display = 'none';
						}
						
						// Reset button state after a delay (in case of errors)
						setTimeout(function() {
							submitBtn.textContent = originalText;
							submitBtn.disabled = false;
						}, 5000);
					});
				}
				
				// Add real-time validation for signup form
				const signupUsername = document.getElementById('signup-username');
				const signupPassword = document.getElementById('signup-password');
				const signupConfirmPassword = document.getElementById('signup-confirm-password');
				
				if (signupUsername) {
					signupUsername.addEventListener('blur', validateUsername);
					signupUsername.addEventListener('input', function() {
						if (this.value.length >= 3) {
							clearInputError('signup-username', 'username-error');
						}
					});
				}
				
				if (signupPassword && signupConfirmPassword) {
					signupConfirmPassword.addEventListener('blur', function() {
						const password = signupPassword.value.trim();
						const confirmPassword = this.value.trim();
						
						if (confirmPassword && password !== confirmPassword) {
							showInputError('signup-confirm-password', 'confirm-password-error', 'Passwords do not match');
						} else {
							clearInputError('signup-confirm-password', 'confirm-password-error');
						}
					});
				}
			});
			
			// Toggle description function
			function toggleDescription(element) {
				const parent = element.closest('.movie-description');
				const shortDesc = parent.querySelector('.description-short');
				const fullDesc = parent.querySelector('.description-full');
				const readMoreBtn = parent.querySelector('.read-more-btn');
				
				if (shortDesc.style.display === 'none') {
					// Show short description
					shortDesc.style.display = 'inline';
					fullDesc.style.display = 'none';
					readMoreBtn.textContent = 'Read more';
				} else {
					// Show full description
					shortDesc.style.display = 'none';
					fullDesc.style.display = 'inline';
					readMoreBtn.textContent = 'Read less';
				}
			}
			
			// Ticket click handler - FINAL VERSION
			function handleTicketClick() {
				// Check login status
				const isLoggedIn = document.querySelector('.header ul li a[href="cinema?action=logout"]') !== null;
				
				if (isLoggedIn) {
					window.location.href = 'cinema?action=buy-tickets';
				} else {
					// User not logged in - show login popup
					sessionStorage.setItem('redirectAfterLogin', 'cinema?action=buy-tickets');
					
					// Show login popup
					const loginArea = document.querySelector('.login-area');
					if (loginArea) {
						// Clear any existing inline styles first
						loginArea.style.cssText = '';
						loginArea.classList.add('active');
					}
					
					// Ensure login form is shown (hide signup form)
					const loginForm = document.getElementById('loginForm');
					const signupForm = document.getElementById('signupForm');
					if (loginForm) loginForm.style.display = 'block';
					if (signupForm) signupForm.style.display = 'none';
					
					// Show ticket purchase message
					const messageDiv = document.getElementById('auth-message');
					if (messageDiv) {
						messageDiv.innerHTML = '<strong>You need to login to buy movie tickets!</strong>';
						messageDiv.style.cssText = 'display: block; color: #856404; background: #fff3cd; border: 1px solid #ffeaa7; padding: 10px; margin: 10px 0; border-radius: 4px; text-align: center;';
					}
				}
			}
			
			// Check for post-login redirect
			window.addEventListener('load', function() {
				const isUserLoggedIn = document.querySelector('.header ul li a[href="cinema?action=logout"]') !== null;
				if (isUserLoggedIn && sessionStorage.getItem('redirectAfterLogin')) {
					const redirectUrl = sessionStorage.getItem('redirectAfterLogin');
					sessionStorage.removeItem('redirectAfterLogin');
					window.location.href = redirectUrl;
				}
			});
			
			// Add close button handler for login popup
			const loginCloseBtn = document.querySelector('.login-area .login-box > a');
			if (loginCloseBtn) {
				loginCloseBtn.addEventListener('click', function(event) {
					event.preventDefault();
					closeLoginPopup();
				});
			}
			
			// Add close button handler for buy-ticket popup
			const buyTicketCloseBtn = document.querySelector('.buy-ticket .buy-ticket-area > a');
			if (buyTicketCloseBtn) {
				buyTicketCloseBtn.addEventListener('click', function(event) {
					event.preventDefault();
					document.querySelector('.buy-ticket').style.display = 'none';
				});
			}
			
			// Function to close login popup
			function closeLoginPopup() {
				// Hide popup by removing active class
				const loginArea = document.querySelector('.login-area');
				if (loginArea) {
					loginArea.classList.remove('active');
					// Clear any inline styles
					loginArea.style.cssText = '';
				}
				// Keep redirect flag - don't remove it
			}
			
			// Add click outside to close popup (with delay to prevent immediate close)
			document.addEventListener('click', function(event) {
				const loginArea = document.querySelector('.login-area');
				const loginBox = document.querySelector('.login-box');
				
				// Don't close if clicking on ticket buttons
				if (event.target.closest('[onclick*="handleTicketClick"]') || 
					event.target.textContent.toLowerCase().includes('ticket')) {
					return;
				}
				
				if (loginArea && loginArea.classList.contains('active')) {
					// Small delay to prevent immediate close after opening
					setTimeout(function() {
						if (loginArea.classList.contains('active') && !loginBox.contains(event.target)) {
							closeLoginPopup();
						}
					}, 100);
				}
			});
		</script>
	</body>

</html>