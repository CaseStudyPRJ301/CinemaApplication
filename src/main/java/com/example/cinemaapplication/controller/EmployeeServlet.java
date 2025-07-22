package com.example.cinemaapplication.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import com.example.cinemaapplication.model.Customer;
import com.example.cinemaapplication.model.TicketDetail;
import com.example.cinemaapplication.model.BookingGroup;
import com.example.cinemaapplication.service.ICustomerService;
import com.example.cinemaapplication.service.Imp.CustomerServiceImp;
import com.example.cinemaapplication.repository.Imp.TicketRepositoryImp;
import com.example.cinemaapplication.util.BookingGroupUtil;
import java.util.List;

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
            case "manage-customers":
                showCustomerManagement(request, response);
                break;
            case "view-customer":
                showCustomerDetails(request, response);
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
               session.getAttribute("role").equals("employee");
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("employee/employee-dashboard.jsp").forward(request, response);
    }

    private void showCustomerManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ICustomerService customerService = new CustomerServiceImp();
        List<Customer> customerList = customerService.getAllCustomers();
        request.setAttribute("customerList", customerList);
        request.getRequestDispatcher("employee/manage-customers.jsp").forward(request, response);
    }

    private void showCustomerDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerIdParam = request.getParameter("id");
        if (customerIdParam == null) {
            response.sendRedirect("employee?action=manage-customers");
            return;
        }

        try {
            int customerId = Integer.parseInt(customerIdParam);
            ICustomerService customerService = new CustomerServiceImp();
            Customer customer = customerService.getCustomerById(customerId);
            
            if (customer == null) {
                response.sendRedirect("employee?action=manage-customers");
                return;
            }

            // Get ticket details for this customer
            TicketRepositoryImp ticketRepository = new TicketRepositoryImp();
            List<TicketDetail> ticketList = ticketRepository.getTicketDetailsByCustomerId(customerId);
            
            // Group tickets by booking time
            List<BookingGroup> bookingGroups = BookingGroupUtil.groupTicketsByBookingTime(ticketList);

            request.setAttribute("customer", customer);
            request.setAttribute("ticketList", ticketList);
            request.setAttribute("bookingGroups", bookingGroups);
            request.getRequestDispatcher("employee/view-customer.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("employee?action=manage-customers");
        }
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
