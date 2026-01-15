<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>My Dashboard - Meeting Room Manager</title>
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
                    <li><a href="${pageContext.request.contextPath}/rooms-page">Rooms</a></li>
                    <li><a href="${pageContext.request.contextPath}/dashboard" class="active">My Dashboard</a></li>
                    <li><a href="javascript:logout()">Logout</a></li>
                </ul>
            </div>
        </nav>

        <div class="container" style="padding-top: 50px;">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom: 30px;">
                <h2>My Bookings</h2>
                <a href="${pageContext.request.contextPath}/rooms-page" class="btn btn-primary">+ New Booking</a>
            </div>

            <div class="table-container">
                <table class="users-table" style="width:100%">
                    <thead>
                        <tr>
                            <th>Room</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Purpose</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="bookingsTableBody">
                        <tr>
                            <td colspan="6">Loading...</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/main.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                if (!isLoggedIn()) {
                    window.location.href = '${pageContext.request.contextPath}/login';
                    return;
                }
                loadBookings();
            });

            async function loadBookings() {
                const userId = localStorage.getItem('userId');
                if (!userId) {
                    alert("Session expired. Please login again.");
                    logout();
                    return;
                }

                try {
                    const bookings = await apiCall('/bookings/user/' + userId);
                    const tbody = document.getElementById('bookingsTableBody');

                    if (!bookings || bookings.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="6" style="text-align:center;">No bookings found.</td></tr>';
                        return;
                    }

                    tbody.innerHTML = bookings.map(b => {
                        const start = new Date(b.startTime);
                        const end = new Date(b.endTime);
                        const dateStr = start.toLocaleDateString();
                        const timeStr = start.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) + ' - ' + end.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

                        return `
                        <tr>
                            <td>${b.room ? b.room.name : 'Unknown Room'}</td>
                            <td>${dateStr}</td>
                            <td>${timeStr}</td>
                            <td>${b.purpose || '-'}</td>
                            <td>
                                <span style="
                                    background:${b.status === 'CONFIRMED' ? '#e8f5e9' : '#ffebee'}; 
                                    color:${b.status === 'CONFIRMED' ? '#2e7d32' : '#c62828'};
                                    padding:4px 8px; border-radius:4px; font-size:0.85rem;">
                                    ${b.status}
                                </span>
                            </td>
                            <td>
                                ${b.status === 'CONFIRMED' ?
                                `<button onclick="cancelBooking(${b.id})" class="btn btn-secondary" style="font-size:0.8rem; padding: 5px 10px; border-color: #f44336; color: #f44336;">Cancel</button>`
                                : '-'}
                            </td>
                        </tr>
                    `;
                    }).join('');
                } catch (e) {
                    console.error(e);
                }
            }

            async function cancelBooking(id) {
                if (!confirm('Are you sure you want to cancel this booking?')) return;
                try {
                    await apiCall('/bookings/' + id + '/cancel', 'POST');
                    loadBookings(); // Reload
                } catch (e) {
                    alert('Failed to cancel: ' + e.message);
                }
            }
        </script>
    </body>

    </html>