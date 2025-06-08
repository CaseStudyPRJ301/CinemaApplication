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
    // TODO: Replace with actual database check
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin123";
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
            default:
                showHomePage(req, resp);
                break;
        }
    }

    private void showHomePage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("view/home-page.jsp").forward(req, resp);
    }

    private void showLoginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("view/login.jsp").forward(req, resp);
    }

    private void showSignupForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("view/login.jsp").forward(req, resp);
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
            default:
                showHomePage(req, resp);
                break;
        }
    }
    
    private void processLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("message", "Vui lòng điền đầy đủ thông tin!");
            showLoginForm(request, response);
            return;
        }

        // Check for admin login
        if (username.equals(ADMIN_USERNAME) && password.equals(ADMIN_PASSWORD)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", "ADMIN");
            response.sendRedirect("admin");
            return;
        }

        // Check user login in database
        String role = userRepository.authenticateUser(username, password);
        if (role != null) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            
            if (role.equals("employee")) {
                response.sendRedirect("employee");
            } else if (role.equals("customer")) {
                response.sendRedirect("customer");
            } else {
                response.sendRedirect("employee"); // fallback
            }
            return;
        }

        // If login fails
        request.setAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng!");
        showLoginForm(request, response);
    }

    private void processSignup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty() || 
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("message", "Vui lòng điền đầy đủ thông tin!");
            showSignupForm(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("message", "Mật khẩu xác nhận không khớp!");
            showSignupForm(request, response);
            return;
        }

        // Check if username already exists
        if (userRepository.isUsernameExists(username)) {
            request.setAttribute("message", "Tên đăng nhập đã tồn tại!");
            showSignupForm(request, response);
            return;
        }

        // TODO: Create customer record first and get customer_id
        // For now, we'll use a dummy customer_id
        int customerId = 1; // This should be the actual customer_id from the Customer table

        // Register user
        if (userRepository.registerUser(username, password, "customer", customerId)) {
            request.setAttribute("message", "Đăng ký thành công!");
            showLoginForm(request, response);
        } else {
            request.setAttribute("message", "Đăng ký thất bại! Vui lòng thử lại.");
            showSignupForm(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("?action=login");
    }
}
