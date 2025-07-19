package com.example.cinemaapplication.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        // Check authentication first
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        if (session == null || role == null || !role.equals("employee")) {
            response.sendRedirect("cinema?action=login");
            return;
        }

        switch (action) {
            case "dashboard":
                showDashboard(request, response);
                break;
            case "profile":
                showProfile(request, response);
                break;
            case "tickets":
                showTickets(request, response);
                break;
            case "movies":
                showMovies(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        // Check authentication first
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        if (session == null || role == null || !role.equals("employee")) {
            response.sendRedirect("cinema?action=login");
            return;
        }

        switch (action) {
            case "update-profile":
                updateProfile(request, response);
                break;
            case "book-ticket":
                bookTicket(request, response);
                break;
            case "cancel-ticket":
                cancelTicket(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }

    private boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && 
               session.getAttribute("role") != null && 
               (session.getAttribute("role").equals("EMPLOYEE") || 
                session.getAttribute("role").equals("USER"));
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("employee/employee-dashboard.jsp").forward(request, response);
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement profile view
        request.getRequestDispatcher("user/profile.jsp").forward(request, response);
    }

    private void showTickets(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement tickets view
        request.getRequestDispatcher("user/tickets.jsp").forward(request, response);
    }

    private void showMovies(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement movies view
        request.getRequestDispatcher("user/movies.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement profile update logic
        response.sendRedirect("employee?action=profile");
    }

    private void bookTicket(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement ticket booking logic
        response.sendRedirect("employee?action=tickets");
    }

    private void cancelTicket(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement ticket cancellation logic
        response.sendRedirect("employee?action=tickets");
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("cinema?action=login");
    }
}
