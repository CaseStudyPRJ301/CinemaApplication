<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Employee - Cinema Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: #13151f;
            color: #b6b7b9;
            overflow-x: hidden;
        }
        
        /* Sidebar Styles */
        .admin-sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: linear-gradient(135deg, #1a1d29 0%, #13151f 100%);
            box-shadow: 4px 0 15px rgba(0,0,0,0.3);
            z-index: 1000;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
        }
        
        .sidebar-header {
            padding: 30px 25px 25px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .admin-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #eb315a, #c340ca);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: white;
            font-size: 36px;
            font-weight: 600;
        }
        
        .admin-name {
            color: #fff;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .admin-email {
            color: #b6b7b9;
            font-size: 14px;
            margin-bottom: 8px;
        }
        
        .admin-role {
            background: linear-gradient(90deg, #eb315a, #c340ca);
            color: white;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
        }
        
        /* Navigation Styles */
        .sidebar-nav {
            padding: 20px 0;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        .nav-item {
            margin-bottom: 5px;
        }
        
        .nav-link {
            display: flex;
            align-items: center;
            padding: 15px 25px;
            color: #b6b7b9;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }
        
        .nav-link:hover,
        .nav-link.active {
            background: linear-gradient(90deg, rgba(235,49,90,0.15), transparent);
            border-left-color: #eb315a;
            color: #fff;
            text-decoration: none;
        }
        
        /* Logout specific styling */
        .logout-nav {
            color: #ff6b6b !important;
        }
        
        .logout-nav:hover {
            background: rgba(255, 107, 107, 0.1) !important;
            border-left-color: #ff6b6b !important;
            color: #fff !important;
        }
        
        .nav-icon {
            width: 20px;
            height: 20px;
            margin-right: 15px;
            font-size: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        /* Main Content */
        .main-content {
            margin-left: 280px;
            min-height: 100vh;
            background: #13151f;
        }
        
        /* Header */
        .content-header {
            background: linear-gradient(135deg, #1a1d29, #13151f);
            padding: 30px 40px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .breadcrumb-nav {
            color: #b6b7b9;
            font-size: 14px;
            margin-top: 8px;
        }
        
        .breadcrumb-nav a {
            color: #eb315a;
            text-decoration: none;
        }
        
        .breadcrumb-nav span {
            margin: 0 8px;
        }
        
        /* Form Container */
        .form-container {
            max-width: 1000px;
            margin: 40px auto;
            background: linear-gradient(135deg, #1a1d29, #13151f);
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.1);
        }
        
        .employee-info-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .employee-info-header h3 {
            color: #fff;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
        }
        
        .employee-info-header p {
            color: #b6b7b9;
            font-size: 16px;
        }
        
        /* Server Message */
        .server-message {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            font-weight: 500;
        }
        
        .server-message.error {
            background: rgba(255, 82, 82, 0.1);
            color: #ff5252;
            border-left: 4px solid #ff5252;
        }
        
        .server-message i {
            margin-right: 10px;
            font-size: 18px;
        }
        
        /* Form Styles */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 25px;
        }
        
        .form-group {
            position: relative;
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            color: #fff;
            font-weight: 500;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .required {
            color: #eb315a;
        }
        
        .form-control {
            width: 100%;
            padding: 15px 18px;
            background: rgba(255,255,255,0.05);
            border: 2px solid rgba(255,255,255,0.1);
            border-radius: 10px;
            color: #fff;
            font-size: 16px;
            transition: all 0.3s ease;
            padding-right: 45px;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #eb315a;
            background: rgba(255,255,255,0.08);
            box-shadow: 0 0 0 3px rgba(235, 49, 90, 0.1);
        }
        
        .form-control::placeholder {
            color: #666;
            font-size: 14px;
        }
        
        /* Validation Icons */
        .validation-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            opacity: 0;
            transition: all 0.3s ease;
        }
        
        .validation-icon.success {
            color: #4caf50;
        }
        
        .validation-icon.error {
            color: #f44336;
        }
        
        .form-group.success .validation-icon.success {
            opacity: 1;
        }
        
        .form-group.error .validation-icon.error {
            opacity: 1;
        }
        
        .form-group.success .form-control {
            border-color: #4caf50;
        }
        
        .form-group.error .form-control {
            border-color: #f44336;
        }
        
        /* Error Messages */
        .error-message {
            color: #f44336;
            font-size: 13px;
            margin-top: 8px;
            opacity: 0;
            transform: translateY(-5px);
            transition: all 0.3s ease;
        }
        
        .error-message.show {
            opacity: 1;
            transform: translateY(0);
        }
        
        /* Submit Button */
        .btn-submit {
            background: linear-gradient(135deg, #eb315a, #c340ca);
            color: white;
            padding: 16px 40px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(235, 49, 90, 0.3);
        }
        
        .btn-submit:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }
        
        .btn-submit i {
            margin-right: 8px;
        }
        
        /* Cancel Button */
        .btn-cancel {
            background: transparent;
            color: #b6b7b9;
            padding: 12px 30px;
            border: 2px solid rgba(255,255,255,0.2);
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            margin-right: 15px;
        }
        
        .btn-cancel:hover {
            background: rgba(255,255,255,0.05);
            border-color: rgba(255,255,255,0.3);
            color: #fff;
            text-decoration: none;
        }
        
        .form-buttons {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            margin-top: 40px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .form-container {
                margin: 20px;
                padding: 30px 25px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="admin-sidebar">
        <div class="sidebar-header">
            <div class="admin-avatar">A</div>
            <div class="admin-name">Admin Name</div>
            <div class="admin-email">admin@cinema.com</div>
            <div class="admin-role">Admin</div>
        </div>
        
         <nav class="sidebar-nav">
             <div class="nav-item">
                 <a href="${pageContext.request.contextPath}/cinema" class="nav-link">
                     <i class="bi bi-house nav-icon"></i>
                     Home
                 </a>
             </div>
             <div class="nav-item">
                 <a href="${pageContext.request.contextPath}/admin" class="nav-link">
                     <i class="bi bi-speedometer2 nav-icon"></i>
                     Dashboard
                 </a>
             </div>
             <div class="nav-item">
                 <a href="${pageContext.request.contextPath}/admin?action=manage-employees" class="nav-link active">
                     <i class="bi bi-person-badge nav-icon"></i>
                     Manage Employees
                 </a>
             </div>
             <div class="nav-item">
                 <a href="${pageContext.request.contextPath}/admin?action=manage-customers" class="nav-link">
                     <i class="bi bi-people nav-icon"></i>
                     Manage Customers
                 </a>
             </div>
             <div class="nav-item">
                 <a href="${pageContext.request.contextPath}/admin?action=reports" class="nav-link">
                     <i class="bi bi-graph-up nav-icon"></i>
                     Reports
                 </a>
             </div>
             
             <!-- Logout at bottom -->
             <div class="nav-item" style="margin-top: auto; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 20px;">
                 <a href="${pageContext.request.contextPath}/cinema?action=logout" class="nav-link logout-nav">
                     <i class="bi bi-box-arrow-right nav-icon"></i>
                     Logout
                 </a>
             </div>
         </nav>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="content-header">
            <div>
                <h1 style="color: #fff; margin: 0; font-size: 24px;">Edit Employee</h1>
                <div class="breadcrumb-nav">
                    <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
                    <span>></span>
                    <a href="${pageContext.request.contextPath}/admin?action=manage-employees">Manage Employees</a>
                    <span>></span>
                    <span>Edit Employee</span>
                </div>
            </div>
        </div>
        
        <!-- Form Container -->
        <div class="form-container">
            <div class="employee-info-header">
                <i class="bi bi-pencil-square" style="font-size: 24px; margin-bottom: 10px;"></i>
                <h3>Update Employee Information</h3>
                <p>Modify employee details in the system</p>
            </div>
            
            <!-- Server Message -->
            <c:if test="${not empty message}">
                <div class="server-message error">
                    <i class="bi bi-exclamation-triangle"></i> ${message}
                </div>
            </c:if>
            
            <form id="employeeForm" action="${pageContext.request.contextPath}/admin?action=edit-employee" method="post">
                <input type="hidden" name="id" value="${employee.employeeId}">
                
                <div class="form-row">
                    <div class="form-group" id="name-group">
                        <label for="name" class="form-label">Full Name <span class="required">*</span></label>
                        <input type="text" id="name" name="name" class="form-control" placeholder="Cannot contain numbers and special characters" value="${employee.name}" required>
                        <i class="bi bi-check-circle validation-icon success"></i>
                        <i class="bi bi-x-circle validation-icon error"></i>
                        <div class="error-message" id="name-error"></div>
                    </div>
                    
                    <div class="form-group" id="phone-group">
                        <label for="phone" class="form-label">Phone Number <span class="required">*</span></label>
                        <input type="tel" id="phone" name="phone" class="form-control" placeholder="Must be 10-11 digits (no letters or characters)" value="${employee.phone}" required>
                        <i class="bi bi-check-circle validation-icon success"></i>
                        <i class="bi bi-x-circle validation-icon error"></i>
                        <div class="error-message" id="phone-error"></div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group" id="email-group">
                        <label for="email" class="form-label">Email <span class="required">*</span></label>
                        <input type="email" id="email" name="email" class="form-control" placeholder="Must have @gmail.com" value="${employee.email}" required>
                        <i class="bi bi-check-circle validation-icon success"></i>
                        <i class="bi bi-x-circle validation-icon error"></i>
                        <div class="error-message" id="email-error"></div>
                    </div>
                    
                    <div class="form-group">
                        <!-- Empty div for grid layout -->
                    </div>
                </div>
                
                <div class="form-buttons">
                    <a href="${pageContext.request.contextPath}/admin?action=manage-employees" class="btn-cancel">
                        <i class="bi bi-arrow-left me-2"></i>Back to Employee List
                    </a>
                    <button type="submit" class="btn-submit" id="submitBtn">
                        <i class="bi bi-check-circle me-2"></i>Update Employee
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- JavaScript for Validation -->
    <script>
        // Validation rules
        const validationRules = {
            name: {
                pattern: /^[a-zA-Z\s]+$/,
                minLength: 2,
                maxLength: 50,
                message: "Full name cannot contain numbers and special characters"
            },
            phone: {
                pattern: /^[0-9]+$/,
                minLength: 10,
                maxLength: 11,
                lengthMessage: "Phone number must be 10-11 digits",
                patternMessage: "Phone number cannot be filled with letters and characters"
            },
            email: {
                pattern: /^[a-zA-Z0-9._%+-]+@gmail\.com$/,
                message: "Email must have @gmail.com"
            }
        };
        
        let debounceTimer;
        const form = document.getElementById('employeeForm');
        const submitBtn = document.getElementById('submitBtn');
        
        // Validation function
        function validateField(fieldName, value) {
            const rule = validationRules[fieldName];
            const field = document.getElementById(fieldName);
            const errorElement = document.getElementById(fieldName + '-error');
            const group = document.getElementById(fieldName + '-group');
            
            const trimmedValue = value.trim();
            
            // Remove existing classes
            group.classList.remove('success', 'error');
            hideError(errorElement);
            
            if (trimmedValue === '') {
                return false;
            }
            
            // Special validation for phone
            if (fieldName === 'phone') {
                // First check if contains non-digits
                if (!rule.pattern.test(trimmedValue)) {
                    showError(field, errorElement, rule.patternMessage);
                    return false;
                }
                // Then check length
                if (trimmedValue.length < rule.minLength || trimmedValue.length > rule.maxLength) {
                    showError(field, errorElement, rule.lengthMessage);
                    return false;
                }
            }
            // Validation for name
            else if (fieldName === 'name') {
                if (!rule.pattern.test(trimmedValue)) {
                    showError(field, errorElement, rule.message);
                    return false;
                }
                if (trimmedValue.length < rule.minLength || trimmedValue.length > rule.maxLength) {
                    showError(field, errorElement, `Full name must be between ${rule.minLength}-${rule.maxLength} characters`);
                    return false;
                }
            }
            // Validation for email
            else {
                if (!rule.pattern.test(trimmedValue)) {
                    showError(field, errorElement, rule.message);
                    return false;
                }
            }
            
            // If all validations pass
            if (trimmedValue !== '') {
                showSuccess(field);
                return true;
            }
            
            return false;
        }
        
        function showError(field, errorElement, message) {
            const group = field.closest('.form-group');
            group.classList.add('error');
            group.classList.remove('success');
            errorElement.textContent = message;
            errorElement.classList.add('show');
        }
        
        function showSuccess(field) {
            const group = field.closest('.form-group');
            group.classList.add('success');
            group.classList.remove('error');
        }
        
        function hideError(errorElement) {
            errorElement.classList.remove('show');
            errorElement.textContent = '';
        }
        
        // Real-time validation
        Object.keys(validationRules).forEach(fieldName => {
            const field = document.getElementById(fieldName);
            
            // Debounced input validation
            field.addEventListener('input', function() {
                clearTimeout(debounceTimer);
                debounceTimer = setTimeout(() => {
                    validateField(fieldName, this.value);
                }, 300);
            });
            
            // Immediate validation on blur
            field.addEventListener('blur', function() {
                clearTimeout(debounceTimer);
                validateField(fieldName, this.value);
            });
            
            // Real-time validation on keyup
            field.addEventListener('keyup', function() {
                clearTimeout(debounceTimer);
                debounceTimer = setTimeout(() => {
                    validateField(fieldName, this.value);
                }, 500);
            });
        });
        
        // Form submission
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            let isValid = true;
            Object.keys(validationRules).forEach(fieldName => {
                const field = document.getElementById(fieldName);
                if (!validateField(fieldName, field.value)) {
                    isValid = false;
                }
            });
            
            if (isValid) {
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Updating Employee...';
                this.submit();
            }
        });
        
        // Initial form check and validate existing values
        Object.keys(validationRules).forEach(fieldName => {
            const field = document.getElementById(fieldName);
            if (field.value.trim() !== '') {
                validateField(fieldName, field.value);
            }
        });
    </script>
</body>
</html> 