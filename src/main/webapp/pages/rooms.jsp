<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Browse Rooms - Meeting Room Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
        <nav class="navbar">
            <div class="container">
                <div class="navbar-brand">
                    <h1>Meeting Room Manager</h1>
                </div>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/rooms-page" class="active">Rooms</a></li>
                    <li id="navAuthSection">
                        <!-- Populated by JS -->
                    </li>
                </ul>
            </div>
        </nav>

        <div class="container" style="padding-top: 50px; padding-bottom: 50px;">
            <h2>Available Meeting Rooms</h2>
            <p>Select a room to view details and book.</p>

            <div id="roomsContainer" class="rooms-grid">
                <!-- Rooms will be loaded here via JS -->
                <p>Loading rooms...</p>
            </div>
        </div>

        <!-- Booking Modal -->
        <div id="bookingModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeBookingModal()">&times;</span>
                <h2 id="modalRoomName">Book Room</h2>
                <form id="bookingForm" onsubmit="handleBooking(event)">
                    <input type="hidden" id="bookingRoomId">
                    <div class="form-group">
                        <label>Date</label>
                        <input type="date" id="bookingDate" required min="${new java.text.SimpleDateFormat("
                            yyyy-MM-dd").format(new java.util.Date())}">
                    </div>
                    <div class="form-group" style="display: flex; gap: 10px;">
                        <div style="flex:1">
                            <label>Start Time</label>
                            <input type="time" id="bookingStartTime" required>
                        </div>
                        <div style="flex:1">
                            <label>End Time</label>
                            <input type="time" id="bookingEndTime" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Purpose</label>
                        <input type="text" id="bookingPurpose" placeholder="e.g. Weekly Team Sync" required>
                    </div>
                    <div id="bookingError" class="alert alert-danger" style="display:none;"></div>
                    <button type="submit" class="btn btn-primary" style="width:100%">Confirm Booking</button>
                </form>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/main.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                updateNavAuth();
                loadRooms();
            });

            function updateNavAuth() {
                const container = document.getElementById('navAuthSection');
                const token = localStorage.getItem('authToken');
                if (token) {
                    container.innerHTML = `
                    <a href="${pageContext.request.contextPath}/dashboard">My Dashboard</a>
                    <a href="javascript:logout()" style="margin-left: 15px;">Logout</a>
                `;
                } else {
                    container.innerHTML = `<a href="${pageContext.request.contextPath}/login">Login</a>`;
                }
            }

            async function loadRooms() {
                try {
                    // If user is not logged in, they can still view but clicking book will redirect
                    const rooms = await apiCall('/rooms'); // Use public endpoint logic in main.js
                    // Note: apiCall usually adds token. If public, ensure backend allows it.
                    // Our SecurityConfig allows /** so it's fine.

                    const container = document.getElementById('roomsContainer');
                    if (!rooms || rooms.length === 0) {
                        container.innerHTML = '<p>No rooms found. Admin needs to add some!</p>';
                        return;
                    }

                    container.innerHTML = rooms.map(room => `
                    <div class="room-card">
                        <img src="https://images.unsplash.com/photo-1497366216548-37526070297c?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80" alt="Meeting Room">
                        <h3>${room.name}</h3>
                        <div class="room-details">
                            <span>👥 ${room.capacity} People</span>
                            <span>📡 ${room.amenities || 'WiFi'}</span>
                        </div>
                        <p>${room.description || 'A perfect space for your meetings.'}</p>
                        <br>
                        <button onclick="openBookingModal(${room.id}, '${room.name}')" class="btn btn-primary">Book Now</button>
                    </div>
                `).join('');
                } catch (e) {
                    console.error(e);
                }
            }

            function openBookingModal(roomId, roomName) {
                if (!isLoggedIn()) {
                    alert("Please login to book a room.");
                    window.location.href = '${pageContext.request.contextPath}/login';
                    return;
                }
                document.getElementById('bookingRoomId').value = roomId;
                document.getElementById('modalRoomName').innerText = 'Book ' + roomName;
                document.getElementById('bookingModal').style.display = 'flex';
            }

            function closeBookingModal() {
                document.getElementById('bookingModal').style.display = 'none';
                document.getElementById('bookingError').style.display = 'none';
            }

            async function handleBooking(e) {
                e.preventDefault();
                const date = document.getElementById('bookingDate').value;
                const start = document.getElementById('bookingStartTime').value;
                const end = document.getElementById('bookingEndTime').value;
                const purpose = document.getElementById('bookingPurpose').value;
                const roomId = document.getElementById('bookingRoomId').value;

                // Construct ISO strings
                const startDateTime = date + 'T' + start + ':00';
                const endDateTime = date + 'T' + end + ':00';

                // Identify user (for this demo, we'll fetch ID from a profile call or store it on login)
                // Since we previously stored email, we might need to fetch user ID. 
                // Let's assume we implement a /me endpoint or store ID in localStorage.
                // QUIC FIX: We'll modify auth.js/main.js to store userId.
                // For now, let's try to get it.
                let userId = localStorage.getItem('userId');
                if (!userId) {
                    // Fetch me
                    const email = localStorage.getItem('userEmail');
                    // This is tricky without a dedicated /me endpoint or ID in token response. 
                    // We will update Login flow to store user ID.
                    // For current execution, assume user updates login first.
                    alert("User ID missing. Please relogin.");
                    logout();
                    return;
                }

                try {
                    const response = await apiCall('/bookings', 'POST', {
                        userId: userId,
                        roomId: roomId,
                        startTime: startDateTime,
                        endTime: endDateTime,
                        purpose: purpose
                    });

                    if (response && response.id) {
                        alert('Booking Confirmed!');
                        closeBookingModal();
                        window.location.href = '${pageContext.request.contextPath}/dashboard';
                    } else {
                        showError('bookingError', response?.message || 'Booking failed (Conflict?)');
                    }
                } catch (error) {
                    showError('bookingError', 'Error: ' + error.message);
                }
            }
        </script>
    </body>

    </html>