package com.example.cinemaapplication.controller;

import com.example.cinemaapplication.repository.Imp.UserRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

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
            case "logout":
                logout(req, resp);
                break;
            case "buy-tickets":
                showBuyTicketsPage(req, resp);
                break;
            case "seat-selection":
                showSeatSelection(req, resp);
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
        
        req.getRequestDispatcher("buy-tickets.jsp").forward(req, resp);
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
            
            // Set attributes for seat-selection.jsp
            req.setAttribute("movieId", movieId);
            req.setAttribute("movieTitle", movieTitle);
            req.setAttribute("showtime", showtime);
            req.setAttribute("theaterId", theaterId);
            req.setAttribute("showtimeId", showtimeId);
            
            req.getRequestDispatcher("seat-selection.jsp").forward(req, resp);
            
        } catch (NumberFormatException e) {
            resp.sendRedirect("cinema?action=buy-tickets&error=Invalid showtime format");
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

        // TODO: Create customer record first and get customer_id
        // For now, we'll use a dummy customer_id
        int customerId = 1; // This should be the actual customer_id from the Customer table

        // Register user
        if (userRepository.registerUser(username, password, "customer", customerId)) {
            String successMessage = "Registration successful! Please log in.";
            if ("home".equals(source)) {
                // Redirect back to home page with success message
                response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(successMessage, "UTF-8") + "&type=success");
            } else {
                request.setAttribute("message", successMessage);
                showLoginForm(request, response);
            }
        } else {
            String errorMessage = "Registration failed! Please try again.";
            if ("home".equals(source)) {
                response.sendRedirect("cinema?message=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            } else {
                request.setAttribute("message", errorMessage);
                showSignupForm(request, response);
            }
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

        String showtimeId = req.getParameter("showtimeId");
        String selectedSeats = req.getParameter("selectedSeats");
        String totalPrice = req.getParameter("totalPrice");

        // TODO: Lưu thông tin vé vào database ở đây

        // Chuyển hướng sang trang xác nhận/thông báo thành công (hoặc trang payment)
        req.setAttribute("selectedSeats", selectedSeats);
        req.setAttribute("totalPrice", totalPrice);
        req.setAttribute("showtimeId", showtimeId);
        req.getRequestDispatcher("payment.jsp").forward(req, resp);
    }

}
