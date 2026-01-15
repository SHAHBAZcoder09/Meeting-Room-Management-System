<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Meeting Room Manager - Home</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    </head>

    <body>
        <nav class="navbar">
            <div class="container">
                <div class="navbar-brand">
                    <h1>Meeting Room Manager</h1>
                </div>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/" class="active">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/rooms-page">Rooms</a></li>
                    <li id="guestLinks"><a href="${pageContext.request.contextPath}/login">Login</a></li>
                    <li id="userLinks" style="display:none;">
                        <a href="${pageContext.request.contextPath}/dashboard">My Dashboard</a>
                        <a href="javascript:logout()">Logout</a>
                    </li>
                </ul>
            </div>
        </nav>

        <section class="hero">
            <div class="container">
                <div class="hero-content">
                    <h2>Book Your Perfect Workspace</h2>
                    <p>Seamlessly schedule meetings with real-time availability and instant confirmation.</p>
                    <div class="hero-buttons">
                        <a href="${pageContext.request.contextPath}/rooms-page" class="btn btn-primary">Browse Rooms</a>
                    </div>
                </div>
            </div>
        </section>

        <section class="features">
            <div class="container">
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">📅</div>
                        <h3>Real-time Booking</h3>
                        <p>Check availability instantly and secure your spot in seconds.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">🏢</div>
                        <h3>Premium Spaces</h3>
                        <p>Access well-equipped rooms with projectors, whiteboards and high-speed WiFi.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">✨</div>
                        <h3>Smart Management</h3>
                        <p>Track your upcoming meetings and manage cancellations effortlessly.</p>
                    </div>
                </div>
            </div>
        </section>

        <footer class="footer">
            <div class="container">
                <p>&copy; 2026 Meeting Room Manager. All rights reserved.</p>
            </div>
        </footer>

        <script src="${pageContext.request.contextPath}/js/main.js"></script>
        <script>
            // Simple script to toggle nav links based on login status
            document.addEventListener('DOMContentLoaded', () => {
                const token = localStorage.getItem('authToken');
                if (token) {
                    document.getElementById('guestLinks').style.display = 'none';
                    document.getElementById('userLinks').style.display = 'flex';
                    document.getElementById('userLinks').style.gap = '20px';
                }
            });
        </script>
    </body>

    </html>