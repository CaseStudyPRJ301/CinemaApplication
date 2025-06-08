package com.example.cinemaapplication.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import com.example.cinemaapplication.repository.Imp.EmployeeRepositoryImp;
import com.example.cinemaapplication.model.Employee;
import java.util.List;
import com.example.cinemaapplication.service.IEmployeeService;
import com.example.cinemaapplication.service.Imp.EmployeeServiceImp;
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
            response.sendRedirect("?action=login");
            return;
        }

        switch (action) {
            case "add-employee":
                showAddEmployeeForm(request, response);
                break;
            case "manage-employees":
                showEmployeeManagement(request, response);
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
            response.sendRedirect("?action=login");
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
               session.getAttribute("role").equals("ADMIN");
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        IEmployeeService employeeService = new EmployeeServiceImp();
        List<Employee> employeeList = employeeService.getAllEmployees();
        request.setAttribute("employeeList", employeeList);
        request.getRequestDispatcher("view/admin/admin-dashboard.jsp").forward(request, response);
    }

    private void showEmployeeManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement employee management view
        request.getRequestDispatcher("view/admin/employee-management.jsp").forward(request, response);
    }

    private void showUserManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement user management view
        request.getRequestDispatcher("view/admin/user-management.jsp").forward(request, response);
    }

    private void showAddEmployeeForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("view/admin/add-employee-form.jsp").forward(request, response);
    }

    private void editEmployee(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement edit employee logic
        response.sendRedirect("admin?action=manage-employees");
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
        response.sendRedirect("?action=login");
    }

    private void handleAddEmployee(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Employee employee = new Employee();
        employee.setName(name);
        employee.setPhone(phone);
        employee.setEmail(email);
        IEmployeeService employeeService = new EmployeeServiceImp();
        boolean empSuccess = employeeService.insertEmployee(employee);

        int employeeId = -1;
        if (empSuccess) {
            java.util.List<Employee> all = employeeService.getAllEmployees();
            if (!all.isEmpty()) {
                employeeId = all.get(all.size() - 1).getEmployeeId();
            }
        }

        // Thêm user cho nhân viên
        boolean userSuccess = false;
        if (empSuccess && employeeId != -1) {
            UserRepository userRepo = new UserRepository();
            userSuccess = userRepo.registerUser(username, password, "employee", employeeId);
        }

        if (empSuccess && userSuccess) {
            response.sendRedirect("admin?action=dashboard");
        } else {
            request.setAttribute("message", "Thêm nhân viên thất bại hoặc tên đăng nhập đã tồn tại!");
            showAddEmployeeForm(request, response);
        }
    }
}
