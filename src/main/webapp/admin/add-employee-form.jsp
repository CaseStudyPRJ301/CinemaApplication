<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Employee - Cinema Management</title>
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
        
        .content-header {
            background: linear-gradient(135deg, #1a1d29 0%, #13151f 100%);
            padding: 25px 30px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .breadcrumb-nav {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #b6b7b9;
            font-size: 14px;
        }
        
        .breadcrumb-nav a {
            color: #eb315a;
            text-decoration: none;
        }
        
        .breadcrumb-nav a:hover {
            color: #c340ca;
        }
        
        /* Form Container */
        .form-container {
            max-width: 800px;
            margin: 40px auto;
            background: linear-gradient(135deg, #1a1d29 0%, #13151f 100%);
            border-radius: 15px;
            padding: 50px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.05);
        }
        
        .form-title {
            text-align: center;
            margin-bottom: 30px;
            color: #fff;
            font-size: 28px;
            font-weight: 600;
        }
        
        .form-subtitle {
            text-align: center;
            margin-bottom: 40px;
            color: #b6b7b9;
            font-size: 16px;
        }
        
        .employee-info-header {
            background: linear-gradient(135deg, #eb315a, #c340ca);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .employee-info-header h3 {
            font-size: 20px;
            font-weight: 600;
            margin: 0;
        }
        
        .employee-info-header p {
            margin: 5px 0 0;
            opacity: 0.9;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 25px;
        }
        
                 .form-group {
             margin-bottom: 25px;
             position: relative;
         }
         
         .validation-icon {
             position: absolute;
             right: 15px;
             top: 38px;
             font-size: 16px;
             opacity: 0;
             transition: all 0.3s ease;
             pointer-events: none;
             z-index: 10;
         }
         
         .form-group.has-success .validation-icon.success {
             opacity: 1;
             color: #2ed573;
         }
         
         .form-group.has-error .validation-icon.error {
             opacity: 1;
             color: #ff4757;
         }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: #fff;
            font-weight: 500;
            font-size: 14px;
        }
        
        .form-label .required {
            color: #eb315a;
            margin-left: 3px;
        }
        
                 .form-control {
             width: 100%;
             padding: 12px 45px 12px 15px;
             background: rgba(255,255,255,0.05);
             border: 1px solid rgba(255,255,255,0.1);
             border-radius: 8px;
             color: #fff;
             font-size: 14px;
             transition: all 0.3s ease;
             position: relative;
         }
         
         .form-control::placeholder {
             color: rgba(255,255,255,0.4);
             transition: all 0.3s ease;
         }
         
         .form-control:focus::placeholder {
             color: rgba(255,255,255,0.2);
         }
        
        .form-control:focus {
            outline: none;
            border-color: #eb315a;
            background: rgba(255,255,255,0.08);
            box-shadow: 0 0 0 3px rgba(235,49,90,0.1);
        }
        
        .form-control.error {
            border-color: #ff4757;
            background: rgba(255,71,87,0.1);
        }
        
                 .form-control.success {
             border-color: #2ed573;
             background: rgba(46,213,115,0.1);
             box-shadow: 0 0 0 3px rgba(46,213,115,0.1);
         }
         
         .form-control:focus.success {
             border-color: #2ed573;
             box-shadow: 0 0 0 3px rgba(46,213,115,0.2);
         }
         
         .form-control:focus.error {
             border-color: #ff4757;
             box-shadow: 0 0 0 3px rgba(255,71,87,0.2);
         }
        
                 .error-message {
             color: #ff4757;
             font-size: 12px;
             margin-top: 5px;
             display: none;
             font-weight: 500;
             opacity: 0;
             transform: translateY(-10px);
             transition: all 0.3s ease;
         }
         
         .error-message.show {
             display: block;
             opacity: 1;
             transform: translateY(0);
         }
        
        
        
        /* Buttons */
        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, #eb315a, #c340ca);
            color: white;
            padding: 14px 28px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
        }
        
        .btn-submit:hover:not(:disabled) {
            background: linear-gradient(135deg, #d12851, #a835b8);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(235,49,90,0.4);
        }
        
        .btn-submit:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }
        
        .btn-cancel {
            width: 100%;
            background: transparent;
            color: #b6b7b9;
            padding: 12px 28px;
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .btn-cancel:hover {
            border-color: #eb315a;
            color: #eb315a;
            text-decoration: none;
        }
        
        /* Logout Button */
        .btn-logout {
            background: linear-gradient(135deg, #ff4757, #ff3838);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-logout:hover {
            background: linear-gradient(135deg, #ff3838, #ff2c2c);
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }
        
        /* Server Message */
        .server-message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .server-message.error {
            background: rgba(255,71,87,0.15);
            color: #ff4757;
            border: 1px solid rgba(255,71,87,0.3);
        }
        
        .server-message.success {
            background: rgba(46,213,115,0.15);
            color: #2ed573;
            border: 1px solid rgba(46,213,115,0.3);
        }
        
                 /* Responsive */
         @media (max-width: 768px) {
             .admin-sidebar {
                 width: 100%;
                 transform: translateX(-100%);
             }
             
             .main-content {
                 margin-left: 0;
             }
             
             .form-container {
                 margin: 20px;
                 padding: 30px 20px;
             }
             
             .form-row {
                 grid-template-columns: 1fr;
                 gap: 20px;
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
                                 <h1 style="color: #fff; margin: 0; font-size: 24px;">Add New Employee</h1>
                <div class="breadcrumb-nav">
                    <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
                    <span>></span>
                    <a href="${pageContext.request.contextPath}/admin?action=manage-employees">Manage Employees</a>
                    <span>></span>
                                         <span>Add Employee</span>
                </div>
            </div>
        </div>
        
        <!-- Form Container -->
        <div class="form-container">
            <div class="employee-info-header">
                <i class="bi bi-plus-circle" style="font-size: 24px; margin-bottom: 10px;"></i>
                                 <h3>Employee Information</h3>
                 <p>Add new employee to the system</p>
            </div>
            
            <!-- Server Message -->
            <c:if test="${not empty message}">
                <div class="server-message error">
                    <i class="bi bi-exclamation-triangle"></i> ${message}
                </div>
            </c:if>
            
                         <form id="employeeForm" action="${pageContext.request.contextPath}/admin?action=add-employee" method="post">
                 <div class="form-row">
                                          <div class="form-group" id="name-group">
                          <label for="name" class="form-label">Full Name <span class="required">*</span></label>
                           <input type="text" id="name" name="name" class="form-control" placeholder="Cannot contain numbers and special characters" value="${param.name != null ? param.name : ''}" required>
                           <i class="bi bi-check-circle validation-icon success"></i>
                           <i class="bi bi-x-circle validation-icon error"></i>
                           <div class="error-message" id="name-error"></div>
                       </div>
                     
                                            <div class="form-group" id="phone-group">
                          <label for="phone" class="form-label">Phone Number <span class="required">*</span></label>
                           <input type="tel" id="phone" name="phone" class="form-control" placeholder="Must be 10-11 digits (no letters or characters)" value="${param.phone != null ? param.phone : ''}" required>
                           <i class="bi bi-check-circle validation-icon success"></i>
                           <i class="bi bi-x-circle validation-icon error"></i>
                           <div class="error-message" id="phone-error"></div>
                       </div>
                 </div>
                 
                 <div class="form-row">
                                            <div class="form-group" id="email-group">
                           <label for="email" class="form-label">Email <span class="required">*</span></label>
                           <input type="email" id="email" name="email" class="form-control" placeholder="Must have @gmail.com" value="${param.email != null ? param.email : ''}" required>
                           <i class="bi bi-check-circle validation-icon success"></i>
                           <i class="bi bi-x-circle validation-icon error"></i>
                           <div class="error-message" id="email-error"></div>
                       </div>
                     
                                                                  <div class="form-group" id="username-group">
                           <label for="username" class="form-label">Username <span class="required">*</span></label>
                           <input type="text" id="username" name="username" class="form-control" placeholder="Please select a username for the employee" value="${param.username != null ? param.username : ''}" required>
                           <i class="bi bi-check-circle validation-icon success"></i>
                           <i class="bi bi-x-circle validation-icon error"></i>
                            <div class="error-message" id="username-error"></div>
                        </div>
        </div>
                  
                                      <div class="form-group" id="password-group">
                        <label for="password" class="form-label">Password <span class="required">*</span></label>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Enter secure password" required>
                        <i class="bi bi-check-circle validation-icon success"></i>
                        <i class="bi bi-x-circle validation-icon error"></i>
                        <div class="error-message" id="password-error"></div>
        </div>
                
                                 <button type="submit" class="btn-submit" id="submitBtn">
                                           <i class="bi bi-plus-circle me-2"></i>Add Employee
                 </button>
                                 <a href="${pageContext.request.contextPath}/admin?action=manage-employees" class="btn-cancel">
                                           <i class="bi bi-arrow-left me-2"></i>Cancel
                 </a>
            </form>
        </div>
</div>
    
    <script>
        // Form validation
        const form = document.getElementById('employeeForm');
        const submitBtn = document.getElementById('submitBtn');
        
                 // Validation rules
         const validationRules = {
             name: {
                 pattern: /^[a-zA-Z\s]+$/,
                 minLength: 2,
                 maxLength: 50,
                 message: 'Full name cannot contain numbers and special characters'
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
                 message: 'Email must have @gmail.com'
             },
             username: {
                 pattern: /^[a-zA-Z0-9_]{3,20}$/,
                 message: 'Username must be 3-20 characters (letters, numbers, underscore only)'
             },
             password: {
                 minLength: 6,
                 message: 'Password must be at least 6 characters long'
             }
         };
        
                 // Validation functions
         function validateField(fieldName, value) {
             const rule = validationRules[fieldName];
             const field = document.getElementById(fieldName);
             const errorElement = document.getElementById(fieldName + '-error');
             const groupElement = field.closest('.form-group');
             
             // Reset states
             field.classList.remove('error', 'success');
             groupElement.classList.remove('has-error', 'has-success');
             hideError(errorElement);
             
             // Always show error if field is focused and has invalid content
             const trimmedValue = value ? value.trim() : '';
             
             if (trimmedValue !== '') {
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
                 // Standard validation for other fields
                 else {
                     // Pattern check
                     if (rule.pattern && !rule.pattern.test(trimmedValue)) {
                         showError(field, errorElement, rule.message);
                         return false;
                     }
                     
                     // Length checks
                     if (rule.minLength && trimmedValue.length < rule.minLength) {
                         showError(field, errorElement, rule.message);
                         return false;
                     }
                     
                     if (rule.maxLength && trimmedValue.length > rule.maxLength) {
                         showError(field, errorElement, rule.message);
                         return false;
                     }
                 }
                 
                 // Show success for valid input
                 showSuccess(field);
                 return true;
             }
             
             // Empty field - no error shown but not valid for submission
             return false;
         }
        
                 function showError(field, errorElement, message) {
             const groupElement = field.closest('.form-group');
             field.classList.add('error');
             groupElement.classList.remove('has-success');
             groupElement.classList.add('has-error');
             errorElement.textContent = message;
             errorElement.classList.add('show');
             errorElement.style.display = 'block';
         }
         
         function showSuccess(field) {
             const groupElement = field.closest('.form-group');
             field.classList.add('success');
             groupElement.classList.remove('has-error');
             groupElement.classList.add('has-success');
         }
         
         function hideError(errorElement) {
             errorElement.classList.remove('show');
             setTimeout(() => {
                 if (!errorElement.classList.contains('show')) {
                     errorElement.style.display = 'none';
                 }
             }, 300);
         }
        
                 // Real-time validation
         Object.keys(validationRules).forEach(fieldName => {
             const field = document.getElementById(fieldName);
             
             // Validate immediately on input
             field.addEventListener('input', function() {
                 setTimeout(() => {
                     validateField(fieldName, this.value);
                     checkFormValidity();
                 }, 300); // Debounce for better UX
             });
             
             // Validate on blur (when user leaves field)
             field.addEventListener('blur', function() {
                 validateField(fieldName, this.value);
                 checkFormValidity();
             });
             
             // Validate on keyup for immediate feedback
             field.addEventListener('keyup', function() {
                 if (this.value.trim() !== '') {
                     setTimeout(() => {
                         validateField(fieldName, this.value);
                         checkFormValidity();
                     }, 500);
                 }
             });
         });
        
                 function checkFormValidity() {
             let isValid = true;
             Object.keys(validationRules).forEach(fieldName => {
                 const field = document.getElementById(fieldName);
                 const value = field.value.trim();
                 
                 // Required fields must have value
                 if (!value) {
                     isValid = false;
                     return;
                 }
                 
                 if (!validateField(fieldName, value)) {
                     isValid = false;
                 }
             });
             
             submitBtn.disabled = !isValid;
         }
        
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
                                 submitBtn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Adding Employee...';
                this.submit();
            }
        });
        
                 // Initial form check and validate existing values (for server errors)
         Object.keys(validationRules).forEach(fieldName => {
             const field = document.getElementById(fieldName);
             if (field.value.trim() !== '') {
                 validateField(fieldName, field.value);
             }
         });
         checkFormValidity();
         
         // Special handling for username field - check uniqueness
         const usernameField = document.getElementById('username');
         let usernameTimeout;
         
         usernameField.addEventListener('input', function() {
             clearTimeout(usernameTimeout);
             const username = this.value.trim();
             
             if (username.length >= 3) {
                 usernameTimeout = setTimeout(() => {
                     checkUsernameAvailability(username);
                 }, 800);
             }
         });
         
         async function checkUsernameAvailability(username) {
             // This is a simple client-side check - server-side will be definitive
             const commonUsernames = ['admin', 'administrator', 'user', 'test', 'root', 'employee'];
             const errorElement = document.getElementById('username-error');
             const field = document.getElementById('username');
             
             if (commonUsernames.includes(username.toLowerCase())) {
                 showError(field, errorElement, 'This username is commonly used and may not be available');
             }
         }
    </script>
</body>
</html> 