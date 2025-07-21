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
import java.util.List;
import com.example.cinemaapplication.service.IEmployeeService;
import com.example.cinemaapplication.service.Imp.EmployeeServiceImp;
import com.example.cinemaapplication.service.ICustomerService;
import com.example.cinemaapplication.service.Imp.CustomerServiceImp;
import com.example.cinemaapplication.repository.Imp.UserRepository;

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
        // TODO: Implement reports view
        response.getWriter().println("<h1>Reports - Coming Soon</h1>");
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
