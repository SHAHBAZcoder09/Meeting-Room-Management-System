<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - User Management System</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
        <!-- Navigation Bar -->
        <nav class="navbar">
            <div class="container">
                <div class="navbar-brand">
                    <h1>Meeting Room Manager</h1>
                </div>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/register" class="active">Register</a></li>
                </ul>
            </div>
        </nav>

        <!-- Register Form Section -->
        <section class="auth-section">
            <div class="auth-container">
                <div class="auth-card">
                    <h2>Create Account</h2>
                    <p class="auth-subtitle">Join our user management system</p>

                    <form id="registerForm" onsubmit="handleRegister(event)">
                        <div class="form-group">
                            <label for="firstName">First Name</label>
                            <input type="text" id="firstName" name="firstName" placeholder="John" required>
                            <span class="error-message" id="firstNameError"></span>
                        </div>

                        <div class="form-group">
                            <label for="lastName">Last Name</label>
                            <input type="text" id="lastName" name="lastName" placeholder="Doe" required>
                            <span class="error-message" id="lastNameError"></span>
                        </div>

                        <div class="form-group">
                            <label for="regEmail">Email Address</label>
                            <input type="email" id="regEmail" name="email" placeholder="john@example.com" required>
                            <span class="error-message" id="emailError"></span>
                        </div>

                        <div class="form-group">
                            <label for="regPassword">Password</label>
                            <input type="password" id="regPassword" name="password"
                                placeholder="Enter a strong password" required>
                            <span class="help-text">Minimum 6 characters</span>
                            <span class="error-message" id="passwordError"></span>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword"
                                placeholder="Re-enter your password" required>
                            <span class="error-message" id="confirmError"></span>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">Register</button>
                    </form>

                    <p class="auth-link">
                        Already have an account? <a href="${pageContext.request.contextPath}/login">Sign In</a>
                    </p>

                    <div id="successMessage" class="success-message" style="display:none;">
                        <p>Account created successfully! <a href="login.jsp">Click here to login</a></p>
                    </div>

                    <div id="errorMessage" class="alert alert-danger" style="display:none;"></div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <p>&copy; 2026 User Management System. All rights reserved.</p>
            </div>
        </footer>

        <script src="${pageContext.request.contextPath}/js/main.js"></script>
        <script src="${pageContext.request.contextPath}/js/auth.js"></script>
    </body>

    </html>