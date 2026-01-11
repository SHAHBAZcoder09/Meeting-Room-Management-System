<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - User Management System</title>
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
                    <li><a href="${pageContext.request.contextPath}/login" class="active">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/register">Register</a></li>
                </ul>
            </div>
        </nav>

        <!-- Login Form Section -->
        <section class="auth-section">
            <div class="auth-container">
                <div class="auth-card">
                    <h2>Sign In</h2>
                    <p class="auth-subtitle">Access your account</p>

                    <form id="loginForm" onsubmit="handleLogin(event)">
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" placeholder="your@email.com" required>
                            <span class="error-message" id="emailError"></span>
                        </div>

                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" placeholder="Enter your password"
                                required>
                            <span class="error-message" id="passwordError"></span>
                        </div>

                        <div class="form-group checkbox">
                            <input type="checkbox" id="rememberMe" name="rememberMe">
                            <label for="rememberMe">Remember me</label>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">Sign In</button>
                    </form>

                    <p class="auth-link">
                        Don't have an account? <a href="${pageContext.request.contextPath}/register">Create one</a>
                    </p>

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