package com.example.cinemaapplication.controller;

import com.example.cinemaapplication.repository.Imp.UserRepository;
import com.example.cinemaapplication.model.Customer;
import com.example.cinemaapplication.service.ICustomerService;
import com.example.cinemaapplication.service.ITicketService;
import com.example.cinemaapplication.service.Imp.CustomerServiceImp;
import com.example.cinemaapplication.service.Imp.TicketServiceImp;
import com.example.cinemaapplication.model.TicketDetail;
import com.example.cinemaapplication.model.BookingGroup;
import com.example.cinemaapplication.repository.Imp.TicketRepositoryImp;
import com.example.cinemaapplication.util.BookingGroupUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import com.example.cinemaapplication.model.Ticket;

@WebServlet(name = "CinemaServlet", value = "")
public class CinemaServlet extends HttpServlet {
    private UserRepository userRepository;

    @Override
    public void init() throws ServletException {
        userRepository = new UserRepository();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "login":
                showLoginForm(req, resp);
                break;
            case "signup":
                showSignupForm(req, resp);
                break;
            case "complete-profile":
                showHomePage(req, resp);
                break;
            case "logout":
                logout(req, resp);
                break;
            case "buy-tickets":
                showBuyTicketsPage(req, resp);
                break;
            case "seat-selection":
                showSeatSelection(req, resp);
                break;
            case "my-tickets":
                showMyTickets(req, resp);
                break;
            case "my-tickets-ajax":
                showMyTicketsAjax(req, resp);
                break;

            default:
                showHomePage(req, resp);
                break;
        }
    }

    private void showHomePage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
    
    private void showBuyTicketsPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("cinema?action=login&message=" + 
                java.net.URLEncoder.encode("You need to login to buy tickets!", "UTF-8"));
            return;
        }
        
        req.getRequestDispatcher("tickets/buy-tickets.jsp").forward(req, resp);
    }
    
    private void showSeatSelection(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("cinema?action=login&message=" + 
                java.net.URLEncoder.encode("You need to login to select seats!", "UTF-8"));
            return;
        }
        
        String showtimeIdParam = req.getParameter("showtimeId");
        if (showtimeIdParam == null || showtimeIdParam.isEmpty()) {
            resp.sendRedirect("cinema?action=buy-tickets&error=Invalid showtime");
            return;
        }
        
        try {
            int showtimeId = Integer.parseInt(showtimeIdParam);
            
            // TODO: Fetch showtime data from database using showtimeId
            // For now, we'll use mock data based on the showtimeId
            String movieTitle = "";
            String showtime = "";
            int theaterId = 0;
            int movieId = 0;
            
            // Mock data based on database INSERT statements
            if (showtimeId >= 1 && showtimeId <= 5) {
                // Squid Game - Theater 1
                movieTitle = "Squid Game";
                theaterId = 1;
                movieId = 1;
                switch (showtimeId) {
                    case 1: showtime = "10:00"; break;
                    case 2: showtime = "13:00"; break;
                    case 3: showtime = "16:00"; break;
                    case 4: showtime = "19:00"; break;
                    case 5: showtime = "22:00"; break;
                }
            } else if (showtimeId >= 6 && showtimeId <= 10) {
                // Last Avatar - Theater 2
                movieTitle = "Last Avatar";
                theaterId = 2;
                movieId = 2;
                switch (showtimeId) {
                    case 6: showtime = "09:30"; break;
                    case 7: showtime = "12:30"; break;
                    case 8: showtime = "15:30"; break;
                    case 9: showtime = "18:30"; break;
                    case 10: showtime = "21:30"; break;
                }
            } else if (showtimeId >= 11 && showtimeId <= 15) {
                // The Deer God - Theater 3
                movieTitle = "The Deer God";
                theaterId = 3;
                movieId = 3;
                switch (showtimeId) {
                    case 11: showtime = "11:00"; break;
                    case 12: showtime = "14:00"; break;
                    case 13: showtime = "17:00"; break;
                    case 14: showtime = "20:00"; break;
                    case 15: showtime = "23:00"; break;
                }
            } else {
                resp.sendRedirect("cinema?action=buy-tickets&error=Invalid showtime ID");
                return;
            }
            
            // Get booked seats from database
            ITicketService ticketService = new TicketServiceImp();
            List<Integer> bookedSeatIds = ticketService.getBookedSeatIdsByShowtime(showtimeId);
            
            // Set attributes for seat-selection.jsp
            req.setAttribute("movieId", movieId);
            req.setAttribute("movieTitle", movieTitle);
            req.setAttribute("showtime", showtime);
            req.setAttribute("theaterId", theaterId);
            req.setAttribute("showtimeId", showtimeId);
            req.setAttribute("bookedSeatIds", bookedSeatIds);
            
            req.getRequestDispatcher("tickets/seat-selection.jsp").forward(req, resp);
            
        } catch (NumberFormatException e) {
            resp.sendRedirect("cinema?action=buy-tickets&error=Invalid showtime format");
        }
    }

    private void showMyTickets(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("cinema?action=login&message=" + 
                java.net.URLEncoder.encode("You need to login to view your tickets!", "UTF-8"));
            return;
        }

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        try {
            // Get user ID based on role
            Integer customerId = null;
            Integer employeeId = null;
            
            if ("customer".equals(role)) {
                customerId = userRepository.getUserIdFromUsername(username, role);
            } else if ("employee".equals(role)) {
                employeeId = userRepository.getUserIdFromUsername(username, role);
            } else {
                resp.sendRedirect("cinema?action=login&message=" + 
                    java.net.URLEncoder.encode("Invalid user role!", "UTF-8"));
                return;
            }

            if (customerId == null && employeeId == null) {
                resp.sendRedirect("cinema?action=login&message=" + 
                    java.net.URLEncoder.encode("User not found!", "UTF-8"));
                return;
            }

            // Get ticket details for this user
            TicketRepositoryImp ticketRepository = new TicketRepositoryImp();
            List<TicketDetail> ticketList;
            
            if (customerId != null) {
                ticketList = ticketRepository.getTicketDetailsByCustomerId(customerId);
            } else {
                ticketList = ticketRepository.getTicketDetailsByEmployeeId(employeeId);
            }
            
            // Group tickets by booking time
            List<BookingGroup> bookingGroups = BookingGroupUtil.groupTicketsByBookingTime(ticketList);

            req.setAttribute("ticketList", ticketList);
            req.setAttribute("bookingGroups", bookingGroups);
            req.setAttribute("username", username);
            req.setAttribute("role", role);
            
            req.getRequestDispatcher("my-tickets.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("cinema?message=" + 
                java.net.URLEncoder.encode("Error loading tickets: " + e.getMessage(), "UTF-8"));
        }
    }

    private void showLoginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    private void showSignupForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }


    //  ============================================================================================

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "login":
                processLogin(req, resp);
                break;
            case "signup":
                processSignup(req, resp);
                break;
            case "logout":
                logout(req, resp);
                break;
            case "reset-password":
                processResetPassword(req, resp);
                break;
            case "complete-profile":
                processCompleteProfile(req, resp);
                break;
            case "confirm-booking":
                processConfirmBooking(req, resp);
                break;
            default:
                showHomePage(req, resp);
                break;
        }
    }
    
    private void processLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String source = request.getParameter("source"); // To identify if request came from home-page

        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            String errorMessage = "Please fill in all fields!";
            if ("home".equals(source)) {
                response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            } else {
                request.setAttribute("message", errorMessage);
                showLoginForm(request, response);
            }
            return;
        }

        // Check authentication in database (both admin and user tables)
        String role = userRepository.authenticateUser(username, password);
        if (role != null) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            
            // Redirect to home page after successful login
            response.sendRedirect(request.getContextPath() + "/cinema");
            return;
        }

        // If login fails
        String errorMessage = "Invalid username or password!";
        if ("home".equals(source)) {
            response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
        } else {
            request.setAttribute("message", errorMessage);
            showLoginForm(request, response);
        }
    }

    private void processSignup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String source = request.getParameter("source"); // To identify if request came from home-page

        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty() || 
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            String errorMessage = "Please fill in all fields!";
            if ("home".equals(source)) {
                response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            } else {
                request.setAttribute("message", errorMessage);
                showSignupForm(request, response);
            }
            return;
        }

        if (!password.equals(confirmPassword)) {
            String errorMessage = "Password confirmation does not match!";
            if ("home".equals(source)) {
                response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            } else {
                request.setAttribute("message", errorMessage);
                showSignupForm(request, response);
            }
            return;
        }

        // Check if username already exists
        if (userRepository.isUsernameExists(username)) {
            String errorMessage = "Username already exists!";
            if ("home".equals(source)) {
                response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            } else {
                request.setAttribute("message", errorMessage);
                showSignupForm(request, response);
            }
            return;
        }

        // Store username and password in session temporarily
        HttpSession session = request.getSession();
        session.setAttribute("tempUsername", username);
        session.setAttribute("tempPassword", password);

        // Redirect with flag to show personal info form
        if ("home".equals(source)) {
            response.sendRedirect("cinema?showPersonalInfo=true");
        } else {
            response.sendRedirect("cinema?showPersonalInfo=true");
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        // Redirect to home page after logout
        response.sendRedirect(request.getContextPath() + "/cinema");
    }

    private void processCompleteProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String source = request.getParameter("source");

        // Get temporary credentials from session
        HttpSession session = request.getSession();
        String tempUsername = (String) session.getAttribute("tempUsername");
        String tempPassword = (String) session.getAttribute("tempPassword");

        if (tempUsername == null || tempPassword == null) {
            String errorMessage = "Session expired. Please sign up again.";
            if ("home".equals(source)) {
                response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            } else {
                request.setAttribute("message", errorMessage);
                showSignupForm(request, response);
            }
            return;
        }

        // Validate input
        if (name == null || name.trim().isEmpty() || 
            phone == null || phone.trim().isEmpty() || 
            email == null || email.trim().isEmpty()) {
            String errorMessage = "Please fill in all fields!";
            if ("home".equals(source)) {
                response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            } else {
                request.setAttribute("message", errorMessage);
                showHomePage(request, response);
            }
            return;
        }

        // Server-side validation for personal info
        String validationError = validatePersonalInfo(name, phone, email);
        if (validationError != null) {
            if ("home".equals(source)) {
                response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(validationError, "UTF-8"));
            } else {
                request.setAttribute("message", validationError);
                showHomePage(request, response);
            }
            return;
        }

        try {
            // Create customer record
            Customer customer = new Customer();
            customer.setName(name.trim());
            customer.setPhoneNumber(phone.trim());
            customer.setEmail(email.trim());

            ICustomerService customerService = new CustomerServiceImp();
            boolean customerCreated = customerService.insertCustomer(customer);

            if (customerCreated && customer.getCustomerId() > 0) {
                // Create user account with actual customer_id
                boolean userCreated = userRepository.registerUser(tempUsername, tempPassword, "customer", customer.getCustomerId());

                if (userCreated) {
                    // Clean up session
                    session.removeAttribute("tempUsername");
                    session.removeAttribute("tempPassword");

                    // Set login session
                    session.setAttribute("username", tempUsername);
                    session.setAttribute("role", "customer");

                    String successMessage = "Registration completed successfully! Welcome to our cinema!";
                    if ("home".equals(source)) {
                        response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(successMessage, "UTF-8") + "&type=success");
                    } else {
                        response.sendRedirect("cinema");
                    }
                    return;
                }
            }

            // If we reach here, something failed
            String errorMessage = "Registration failed! Please try again.";
            if ("home".equals(source)) {
                response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            } else {
                request.setAttribute("message", errorMessage);
                showSignupForm(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            String errorMessage = "An error occurred during registration. Please try again.";
            if ("home".equals(source)) {
                response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            } else {
                request.setAttribute("message", errorMessage);
                showSignupForm(request, response);
            }
        }
    }

    private String validatePersonalInfo(String name, String phone, String email) {
        // Validate name
        if (name.length() < 2 || name.length() > 50) {
            return "Full name must be between 2-50 characters";
        }
        if (!name.matches("^[a-zA-Z\\s]+$")) {
            return "Full name cannot contain numbers or special characters";
        }

        // Validate phone
        if (!phone.matches("^[0-9]{10,11}$")) {
            return "Phone number must be 10-11 digits";
        }

        // Validate email
        if (!email.matches("^[a-zA-Z0-9._%+-]+@gmail\\.com$")) {
            return "Email must be a valid @gmail.com address";
        }

        return null; // No validation errors
    }

    private void processResetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");
        
        if (username == null || username.trim().isEmpty() || 
            newPassword == null || newPassword.trim().isEmpty()) {
            response.getWriter().println("<html><body>");
            response.getWriter().println("<h2>Error: Please fill all fields</h2>");
            response.getWriter().println("<a href='?action=reset-password'>Try Again</a>");
            response.getWriter().println("</body></html>");
            return;
        }
        
        boolean success = userRepository.resetPassword(username, newPassword);
        
        if (success) {
            response.getWriter().println("<html><body>");
            response.getWriter().println("<h2>Password reset successful!</h2>");
            response.getWriter().println("<p>You can now login with the new password</p>");
            response.getWriter().println("<a href='?action=login'>Login</a>");
            response.getWriter().println("</body></html>");
        } else {
            response.getWriter().println("<html><body>");
            response.getWriter().println("<h2>Error: Failed to reset password</h2>");
            response.getWriter().println("<p>User not found or database error</p>");
            response.getWriter().println("<a href='?action=reset-password'>Try Again</a>");
            response.getWriter().println("</body></html>");
        }
    }

    private void processConfirmBooking(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("cinema?action=login&message=" + java.net.URLEncoder.encode("You need to login to book tickets!", "UTF-8"));
            return;
        }

        // Get all booking data from form
        String movieId = req.getParameter("movieId");
        String movieTitle = req.getParameter("movieTitle");
        String showtime = req.getParameter("showtime");
        String theaterId = req.getParameter("theaterId");
        String showtimeId = req.getParameter("showtimeId");
        String selectedSeats = req.getParameter("selectedSeats");
        String totalPrice = req.getParameter("totalPrice");

        // Debug: Log all received parameters
        System.out.println("=== BOOKING CONFIRMATION DATA ===");
        System.out.println("MovieId: " + movieId);
        System.out.println("MovieTitle: " + movieTitle);
        System.out.println("Showtime: " + showtime);
        System.out.println("TheaterId: " + theaterId);
        System.out.println("ShowtimeId: " + showtimeId);
        System.out.println("SelectedSeats: " + selectedSeats);
        System.out.println("TotalPrice: " + totalPrice);
        System.out.println("===================================");

        // Validate required data
        if (showtimeId == null || selectedSeats == null || totalPrice == null || 
            selectedSeats.trim().isEmpty() || totalPrice.trim().isEmpty()) {
            resp.sendRedirect("cinema?action=buy-tickets&error=" + 
                java.net.URLEncoder.encode("Missing booking information. Please try again.", "UTF-8"));
            return;
        }

        // Ensure default values for display
        if (movieTitle == null || movieTitle.trim().isEmpty()) {
            movieTitle = "Unknown Movie";
        }
        if (showtime == null || showtime.trim().isEmpty()) {
            showtime = "Unknown Time";
        }

        // Save booking to database
        boolean bookingSaved = saveBookingToDatabase(req, showtimeId, theaterId, selectedSeats);
        if (!bookingSaved) {
            System.err.println("Failed to save booking to database");
            // Continue to payment page anyway for now
        }

        // Forward all data to payment page
        req.setAttribute("movieId", movieId != null ? movieId : "0");
        req.setAttribute("movieTitle", movieTitle);
        req.setAttribute("showtime", showtime);
        req.setAttribute("theaterId", theaterId != null ? theaterId : "0");
        req.setAttribute("showtimeId", showtimeId);
        req.setAttribute("selectedSeats", selectedSeats.trim());
        req.setAttribute("totalPrice", totalPrice.trim());
        
        req.getRequestDispatcher("tickets/payment.jsp").forward(req, resp);
    }
    
    private boolean saveBookingToDatabase(HttpServletRequest req, String showtimeId, String theaterId, String selectedSeats) {
        try {
            HttpSession session = req.getSession(false);
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            
            if (username == null || role == null) {
                System.err.println("No username or role in session");
                return false;
            }
            
            // Get user ID based on role
            Integer customerId = null;
            Integer employeeId = null;
            
            if ("customer".equals(role)) {
                customerId = userRepository.getUserIdFromUsername(username, role);
                if (customerId == null) {
                    System.err.println("Could not find customer ID for username: " + username);
                    return false;
                }
                System.out.println("Found customer ID: " + customerId + " for username: " + username);
            } else if ("employee".equals(role)) {
                employeeId = userRepository.getUserIdFromUsername(username, role);
                if (employeeId == null) {
                    System.err.println("Could not find employee ID for username: " + username);
                    return false;
                }
                System.out.println("Found employee ID: " + employeeId + " for username: " + username);
            } else {
                System.err.println("Invalid role for booking: " + role);
                return false;
            }
            
            // Create tickets using TicketService
            ITicketService ticketService = new TicketServiceImp();
            return ticketService.createTicketsForBooking(
                selectedSeats, 
                Integer.parseInt(showtimeId), 
                Integer.parseInt(theaterId), 
                customerId, 
                employeeId
            );
            
        } catch (Exception e) {
            System.err.println("Error saving booking to database: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private void showMyTicketsAjax(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().write("<div class='no-tickets'><p>Please login to view your tickets.</p></div>");
            return;
        }

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        try {
            // Get user ID based on role
            Integer customerId = null;
            Integer employeeId = null;

            if ("customer".equals(role)) {
                customerId = userRepository.getUserIdFromUsername(username, role);
            } else if ("employee".equals(role)) {
                employeeId = userRepository.getUserIdFromUsername(username, role);
            } else {
                resp.setContentType("text/html;charset=UTF-8");
                resp.getWriter().write("<div class='no-tickets'><p>Invalid user role.</p></div>");
                return;
            }

            if (customerId == null && employeeId == null) {
                resp.setContentType("text/html;charset=UTF-8");
                resp.getWriter().write("<div class='no-tickets'><p>User not found.</p></div>");
                return;
            }

            // Get ticket details for this user
            TicketRepositoryImp ticketRepository = new TicketRepositoryImp();
            List<TicketDetail> ticketList;

            if (customerId != null) {
                ticketList = ticketRepository.getTicketDetailsByCustomerId(customerId);
            } else {
                ticketList = ticketRepository.getTicketDetailsByEmployeeId(employeeId);
            }

            // Group tickets by booking time
            List<BookingGroup> bookingGroups = BookingGroupUtil.groupTicketsByBookingTime(ticketList);

            // Set content type for HTML response
            resp.setContentType("text/html;charset=UTF-8");
            
            // Generate HTML content
            StringBuilder html = new StringBuilder();
            
            if (ticketList.isEmpty()) {
                html.append("<div class='no-tickets'>");
                html.append("<i class='icofont icofont-ticket'></i>");
                html.append("<h3>No Tickets Found</h3>");
                html.append("<p>You haven't booked any tickets yet.</p>");
                html.append("<a href='cinema?action=buy-tickets' class='buy-tickets-btn'>");
                html.append("<i class='icofont icofont-plus-circle'></i> Buy Tickets");
                html.append("</a>");
                html.append("</div>");
            } else {
                // Calculate totals
                int totalTickets = ticketList.size();
                double totalSpent = ticketList.stream().mapToDouble(t -> t.getSeatPrice()).sum();
                int totalBookings = bookingGroups.size();
                
                // Summary section
                html.append("<div class='tickets-summary'>");
                html.append("<div class='stat-card'>");
                html.append("<div class='stat-number'>").append(totalBookings).append("</div>");
                html.append("<div class='stat-label'>Booking Sessions</div>");
                html.append("</div>");
                html.append("<div class='stat-card'>");
                html.append("<div class='stat-number'>").append(totalTickets).append("</div>");
                html.append("<div class='stat-label'>Total Tickets</div>");
                html.append("</div>");
                html.append("<div class='stat-card'>");
                html.append("<div class='stat-number'>").append(String.format("%.0f", totalSpent)).append("</div>");
                html.append("<div class='stat-label'>Total Spent (VND)</div>");
                html.append("</div>");
                html.append("</div>");
                
                // Booking groups
                for (BookingGroup group : bookingGroups) {
                    html.append("<div class='booking-group'>");
                    html.append("<div class='booking-header'>");
                    html.append("<div class='booking-date'>");
                    html.append("Booking on ").append(new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(group.getBookingTime()));
                    html.append("</div>");
                    html.append("<div class='booking-summary'>");
                    html.append("<span class='total-amount'>").append(group.getTotalTickets()).append(" tickets</span>");
                    html.append("</div>");
                    html.append("</div>");
                    
                    html.append("<div class='tickets-list'>");
                    for (TicketDetail ticket : group.getTickets()) {
                        html.append("<div class='ticket-item'>");
                        html.append("<div class='ticket-header'>");
                        html.append("<div class='movie-title'>").append(ticket.getMovieTitle()).append("</div>");
                        html.append("<div class='ticket-id'>Ticket #").append(ticket.getTicketId()).append("</div>");
                        html.append("</div>");
                        html.append("<div class='ticket-details'>");
                        html.append("<div class='detail-item'>");
                        html.append("<div class='detail-label'>Theater</div>");
                        html.append("<div class='detail-value'>").append(ticket.getTheaterName()).append("</div>");
                        html.append("</div>");
                        html.append("<div class='detail-item'>");
                        html.append("<div class='detail-label'>Showtime</div>");
                        html.append("<div class='detail-value'>").append(new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(ticket.getShowtime())).append("</div>");
                        html.append("</div>");
                        html.append("<div class='detail-item'>");
                        html.append("<div class='detail-label'>Seat</div>");
                        html.append("<div class='detail-value'>");
                        html.append("<span class='seat-badge'>").append(ticket.getSeatPosition()).append("</span>");
                        html.append("</div>");
                        html.append("</div>");
                        html.append("<div class='detail-item'>");
                        html.append("<div class='detail-label'>Type</div>");
                        html.append("<div class='detail-value'>").append(ticket.getSeatType()).append("</div>");
                        html.append("</div>");
                        html.append("<div class='detail-item'>");
                        html.append("<div class='detail-label'>Price</div>");
                        html.append("<div class='detail-value'>").append(String.format("%.0f VND", ticket.getSeatPrice())).append("</div>");
                        html.append("</div>");
                        html.append("</div>");
                        html.append("</div>");
                    }
                    html.append("</div>");
                    html.append("</div>");
                }
                
                // Buy more tickets button
                html.append("<div style='text-align: center; margin-top: 30px;'>");
                html.append("<a href='cinema?action=buy-tickets' class='buy-tickets-btn'>");
                html.append("<i class='icofont icofont-plus-circle'></i> Buy More Tickets");
                html.append("</a>");
                html.append("</div>");
            }
            
            resp.getWriter().write(html.toString());

        } catch (Exception e) {
            e.printStackTrace();
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().write("<div class='no-tickets'><p>Error loading tickets: " + e.getMessage() + "</p></div>");
        }
    }
}
