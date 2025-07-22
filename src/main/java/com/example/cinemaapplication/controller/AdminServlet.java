package com.example.cinemaapplication.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import com.example.cinemaapplication.model.Employee;
import com.example.cinemaapplication.model.Customer;
import com.example.cinemaapplication.model.TicketDetail;
import com.example.cinemaapplication.model.BookingGroup;
import com.example.cinemaapplication.model.MovieStats;
import com.example.cinemaapplication.model.BookingStats;
import com.example.cinemaapplication.model.TheaterStats;
import java.util.ArrayList;
import java.util.List;
import com.example.cinemaapplication.service.IEmployeeService;
import com.example.cinemaapplication.service.Imp.EmployeeServiceImp;
import com.example.cinemaapplication.service.ICustomerService;
import com.example.cinemaapplication.service.Imp.CustomerServiceImp;
import com.example.cinemaapplication.repository.Imp.UserRepository;
import com.example.cinemaapplication.repository.Imp.TicketRepositoryImp;
import com.example.cinemaapplication.util.BookingGroupUtil;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        // Check authentication first
        if (!isAuthenticated(request)) {
            response.sendRedirect("cinema?action=login");
            return;
        }

        switch (action) {
            case "add-employee":
                showAddEmployeeForm(request, response);
                break;
            case "edit-employee":
                showEditEmployeeForm(request, response);
                break;
            case "manage-employees":
                showEmployeeManagement(request, response);
                break;
            case "manage-customers":
                showCustomerManagement(request, response);
                break;
            case "view-customer":
                showCustomerDetails(request, response);
                break;
            case "manage-movies":
                showMovieManagement(request, response);
                break;
            case "manage-theaters":
                showTheaterManagement(request, response);
                break;
            case "manage-tickets":
                showTicketManagement(request, response);
                break;
            case "reports":
                showReports(request, response);
                break;
            case "manage-users":
                showUserManagement(request, response);
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
        if (!isAuthenticated(request)) {
            response.sendRedirect("cinema?action=login");
            return;
        }

        switch (action) {
            case "add-employee":
                handleAddEmployee(request, response);
                break;
            case "edit-employee":
                editEmployee(request, response);
                break;
            case "delete-employee":
                deleteEmployee(request, response);
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
               session.getAttribute("role").equals("admin");
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Dashboard now only shows summary stats, no detailed employee list
        request.getRequestDispatcher("admin/admin-dashboard.jsp").forward(request, response);
    }

    private void showEmployeeManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        IEmployeeService employeeService = new EmployeeServiceImp();
        List<Employee> employeeList = employeeService.getAllEmployees();
        request.setAttribute("employeeList", employeeList);
        request.getRequestDispatcher("admin/manage-employees.jsp").forward(request, response);
    }

    private void showCustomerManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ICustomerService customerService = new CustomerServiceImp();
        List<Customer> customerList = customerService.getAllCustomers();
        request.setAttribute("customerList", customerList);
        request.getRequestDispatcher("admin/manage-customers.jsp").forward(request, response);
    }

    private void showCustomerDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerIdParam = request.getParameter("id");
        if (customerIdParam == null) {
            response.sendRedirect("admin?action=manage-customers");
            return;
        }

        try {
            int customerId = Integer.parseInt(customerIdParam);
            ICustomerService customerService = new CustomerServiceImp();
            Customer customer = customerService.getCustomerById(customerId);
            
            if (customer == null) {
                response.sendRedirect("admin?action=manage-customers");
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
            request.getRequestDispatcher("admin/view-customer.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("admin?action=manage-customers");
        }
    }

    private void showMovieManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement movie management view
        response.getWriter().println("<h1>Movie Management - Coming Soon</h1>");
    }

    private void showTheaterManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement theater management view
        response.getWriter().println("<h1>Theater Management - Coming Soon</h1>");
    }

    private void showTicketManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement ticket management view
        response.getWriter().println("<h1>Ticket Management - Coming Soon</h1>");
    }

    private void showReports(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get ticket repository
            TicketRepositoryImp ticketRepository = new TicketRepositoryImp();
            
            // Get all ticket details for statistics
            List<TicketDetail> allTickets = ticketRepository.getAllTicketDetails();
            
            // Calculate total statistics
            int totalTickets = allTickets.size();
            double totalRevenue = allTickets.stream().mapToDouble(t -> t.getSeatPrice()).sum();
            double averageTicketPrice = totalTickets > 0 ? totalRevenue / totalTickets : 0;
            
            // Get customer count (you might need to implement this)
            ICustomerService customerService = new CustomerServiceImp();
            int totalCustomers = customerService.getAllCustomers().size();
            
            // Get movie count (you might need to implement this)
            int totalMovies = 3; // Hardcoded for now, should get from database
            
            // Calculate revenue by period (simplified - you can enhance this)
            double todayRevenue = totalRevenue * 0.1; // 10% of total for demo
            double weekRevenue = totalRevenue * 0.3;  // 30% of total for demo
            double monthRevenue = totalRevenue * 0.7; // 70% of total for demo
            
            // Create top movies data (simplified - you can enhance this)
            List<MovieStats> topMovies = new ArrayList<>();
            topMovies.add(new MovieStats("Squid Game", 1250, 225000000, 4.8));
            topMovies.add(new MovieStats("Last Avatar", 980, 176400000, 4.6));
            topMovies.add(new MovieStats("The Deer God", 750, 135000000, 4.4));
            
            // Create recent bookings data (simplified - you can enhance this)
            List<BookingStats> recentBookings = new ArrayList<>();
            if (!allTickets.isEmpty()) {
                // Group tickets by booking time and create booking stats
                List<BookingGroup> bookingGroups = BookingGroupUtil.groupTicketsByBookingTime(allTickets);
                for (int i = 0; i < Math.min(5, bookingGroups.size()); i++) {
                    BookingGroup group = bookingGroups.get(i);
                    if (!group.getTickets().isEmpty()) {
                        TicketDetail firstTicket = group.getTickets().get(0);
                        double totalAmount = group.getTickets().stream().mapToDouble(t -> t.getSeatPrice()).sum();
                        String seats = group.getTickets().stream()
                            .map(t -> t.getSeatPosition())
                            .collect(java.util.stream.Collectors.joining(", "));
                        
                        recentBookings.add(new BookingStats(
                            "BK" + String.format("%03d", i + 1),
                            "Customer " + (i + 1),
                            firstTicket.getMovieTitle(),
                            firstTicket.getTheaterName(),
                            firstTicket.getShowtime(),
                            seats,
                            totalAmount,
                            group.getBookingTime()
                        ));
                    }
                }
            }
            
            // Create theater stats (simplified - you can enhance this)
            List<TheaterStats> theaterStats = new ArrayList<>();
            theaterStats.add(new TheaterStats("Theater 1", 50, 800, 144000000, 75.5));
            theaterStats.add(new TheaterStats("Theater 2", 45, 650, 117000000, 68.2));
            theaterStats.add(new TheaterStats("Theater 3", 40, 500, 90000000, 62.8));
            
            // Set attributes for JSP
            request.setAttribute("totalTickets", totalTickets);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalMovies", totalMovies);
            request.setAttribute("todayRevenue", todayRevenue);
            request.setAttribute("weekRevenue", weekRevenue);
            request.setAttribute("monthRevenue", monthRevenue);
            request.setAttribute("averageTicketPrice", averageTicketPrice);
            request.setAttribute("topMovies", topMovies);
            request.setAttribute("recentBookings", recentBookings);
            request.setAttribute("theaterStats", theaterStats);
            
            // Forward to reports JSP
            request.getRequestDispatcher("admin/reports.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h1>Error loading reports: " + e.getMessage() + "</h1>");
        }
    }

    private void showUserManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement user management view
        response.getWriter().println("<h1>User Management - Coming Soon</h1>");
    }

    private void showAddEmployeeForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("admin/add-employee-form.jsp").forward(request, response);
    }

    private void showEditEmployeeForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int employeeId = Integer.parseInt(idParam);
                IEmployeeService employeeService = new EmployeeServiceImp();
                Employee employee = employeeService.getEmployeeById(employeeId);
                if (employee != null) {
                    request.setAttribute("employee", employee);
                    request.getRequestDispatcher("admin/edit-employee-form.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid ID format
            }
        }
        // If employee not found or invalid ID, redirect back to employee management
        response.sendRedirect("admin?action=manage-employees");
    }

    private void editEmployee(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("admin?action=manage-employees");
            return;
        }

        try {
            int employeeId = Integer.parseInt(idParam);
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");

            // Server-side validation for edit
            String errorMessage = validateEmployeeDataForEdit(name, phone, email, employeeId);
            if (errorMessage != null) {
                // Re-populate employee data for form display
                Employee employee = new Employee(employeeId, name, phone, email);
                request.setAttribute("employee", employee);
                request.setAttribute("message", errorMessage);
                request.getRequestDispatcher("admin/edit-employee-form.jsp").forward(request, response);
                return;
            }

            Employee employee = new Employee(employeeId, name, phone, email);
            IEmployeeService employeeService = new EmployeeServiceImp();
            boolean success = employeeService.updateEmployee(employee);

            if (success) {
                response.sendRedirect("admin?action=manage-employees");
            } else {
                request.setAttribute("employee", employee);
                request.setAttribute("message", "Failed to update employee!");
                request.getRequestDispatcher("admin/edit-employee-form.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("admin?action=manage-employees");
        }
    }

    private void deleteEmployee(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement delete employee logic
        response.sendRedirect("admin?action=manage-employees");
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("cinema?action=login");
    }

    private void handleAddEmployee(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Server-side validation
        String errorMessage = validateEmployeeData(name, phone, email, username, password);
        if (errorMessage != null) {
            request.setAttribute("message", errorMessage);
            showAddEmployeeForm(request, response);
            return;
        }

        Employee employee = new Employee();
        employee.setName(name);
        employee.setPhone(phone);
        employee.setEmail(email);
        IEmployeeService employeeService = new EmployeeServiceImp();
        boolean empSuccess = employeeService.insertEmployee(employee);

        // Thêm user cho nhân viên
        boolean userSuccess = false;
        if (empSuccess && employee.getEmployeeId() > 0) {
            UserRepository userRepo = new UserRepository();
            userSuccess = userRepo.registerUser(username, password, "employee", employee.getEmployeeId());
        }

        if (empSuccess && userSuccess) {
            response.sendRedirect("admin?action=manage-employees");
        } else {
            request.setAttribute("message", "Failed to add employee or username already exists!");
            showAddEmployeeForm(request, response);
        }
    }

    private String validateEmployeeData(String name, String phone, String email, String username, String password) {
        // Validate name
        if (name == null || name.trim().isEmpty()) {
            return "Employee name is required";
        }
        if (!name.matches("^[a-zA-Z\\s]+$")) {
            return "Full name cannot contain numbers and special characters";
        }
        if (name.trim().length() < 2 || name.trim().length() > 50) {
            return "Employee name must be between 2-50 characters";
        }

        // Validate phone
        if (phone == null || phone.trim().isEmpty()) {
            return "Phone number is required";
        }
        if (!phone.matches("^[0-9]+$")) {
            return "Phone number cannot be filled with letters and characters";
        }
        if (phone.length() < 10 || phone.length() > 11) {
            return "Phone number must be 10-11 digits";
        }

        // Validate email
        if (email == null || email.trim().isEmpty()) {
            return "Email is required";
        }
        if (!email.matches("^[a-zA-Z0-9._%+-]+@gmail\\.com$")) {
            return "Email must have @gmail.com";
        }

        // Validate username
        if (username == null || username.trim().isEmpty()) {
            return "Username is required";
        }
        if (!username.matches("^[a-zA-Z0-9_]{3,20}$")) {
            return "Username must be 3-20 characters (letters, numbers, underscore only)";
        }

        // Validate password
        if (password == null || password.trim().isEmpty()) {
            return "Password is required";
        }
        if (password.length() < 6) {
            return "Password must be at least 6 characters long";
        }

        // Check duplicate email and phone
        IEmployeeService employeeService = new EmployeeServiceImp();
        if (employeeService.emailExists(email)) {
            return "Email address is already registered in the system";
        }
        if (employeeService.phoneExists(phone)) {
            return "Phone number is already registered in the system";
        }

        // Check duplicate username
        UserRepository userRepo = new UserRepository();
        if (userRepo.isUsernameExists(username)) {
            return "Username is already taken. Please choose another username";
        }

        return null;
    }

    private String validateEmployeeDataForEdit(String name, String phone, String email, int employeeId) {
        // Validate name
        if (name == null || name.trim().isEmpty()) {
            return "Employee name is required";
        }
        if (!name.matches("^[a-zA-Z\\s]+$")) {
            return "Full name cannot contain numbers and special characters";
        }
        if (name.trim().length() < 2 || name.trim().length() > 50) {
            return "Employee name must be between 2-50 characters";
        }

        // Validate phone
        if (phone == null || phone.trim().isEmpty()) {
            return "Phone number is required";
        }
        if (!phone.matches("^[0-9]+$")) {
            return "Phone number cannot be filled with letters and characters";
        }
        if (phone.length() < 10 || phone.length() > 11) {
            return "Phone number must be 10-11 digits";
        }

        // Validate email
        if (email == null || email.trim().isEmpty()) {
            return "Email is required";
        }
        if (!email.matches("^[a-zA-Z0-9._%+-]+@gmail\\.com$")) {
            return "Email must have @gmail.com";
        }

        // Check duplicate email and phone for other employees
        IEmployeeService employeeService = new EmployeeServiceImp();
        if (employeeService.emailExistsForOtherEmployee(email, employeeId)) {
            return "Email address is already registered by another employee";
        }
        if (employeeService.phoneExistsForOtherEmployee(phone, employeeId)) {
            return "Phone number is already registered by another employee";
        }

        return null;
    }
}
