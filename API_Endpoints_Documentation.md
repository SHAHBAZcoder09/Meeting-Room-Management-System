# Meeting Room Management System - API Endpoints Documentation

**Project Name:** Meeting Room Management System  
**Base URL (Debug):** http://127.0.0.1:8080  
**Server Port:** 8080

---

## API Interface List

| Serial Number | Interface Name | URL | HTTP Request Method | Client Request Parameters & Parameter Types | Server-side Return JSON Data Structure | Full Test URL | Detailed Interface Function Description |
|---------------|----------------|-----|---------------------|---------------------------------------------|----------------------------------------|---------------|----------------------------------------|
| 1 | User Login Interface | /api/users/login | POST | email (type: string; description: user email), password (type: string; description: password) | {"token": "string", "userId": 1, "email": "user@example.com", "firstName": "John", "lastName": "Doe", "role": "USER"} | 127.0.0.1:8080/api/users/login | Used for system login. Returns auth token and user details on successful authentication. |
| 2 | User Registration Interface | /api/users/register | POST | email (type: string; description: user email), password (type: string; description: password), firstName (type: string; description: first name), lastName (type: string; description: last name) | {"token": "string", "userId": 1, "email": "user@example.com", "firstName": "John", "lastName": "Doe", "role": "USER"} | 127.0.0.1:8080/api/users/register | Used for new user registration. Creates a new user account and returns auth token. |
| 3 | Get User By ID | /api/users/{id} | GET | id (type: Long; description: user ID as path variable) | {"id": 1, "email": "user@example.com", "password": "hashed", "firstName": "John", "lastName": "Doe", "role": "USER", "active": true, "createdAt": "2026-01-18T00:00:00", "updatedAt": "2026-01-18T00:00:00"} | 127.0.0.1:8080/api/users/1 | Retrieves user details by user ID. |
| 4 | Get All Users | /api/users | GET | None | [{"id": 1, "email": "user@example.com", "password": "hashed", "firstName": "John", "lastName": "Doe", "role": "USER", "active": true, "createdAt": "2026-01-18T00:00:00", "updatedAt": "2026-01-18T00:00:00"}] | 127.0.0.1:8080/api/users | Retrieves list of all registered users in the system. |
| 5 | Update User | /api/users/{id} | PUT | id (type: Long; description: user ID as path variable), Request Body: User object with fields - email (string), password (string), firstName (string), lastName (string), role (string), active (boolean) | {"id": 1, "email": "updated@example.com", "password": "hashed", "firstName": "Updated", "lastName": "User", "role": "USER", "active": true, "createdAt": "2026-01-18T00:00:00", "updatedAt": "2026-01-18T00:00:00"} | 127.0.0.1:8080/api/users/1 | Updates user information for the specified user ID. |
| 6 | Delete User | /api/users/{id} | DELETE | id (type: Long; description: user ID as path variable) | No content (HTTP 204) | 127.0.0.1:8080/api/users/1 | Deletes a user from the system by user ID. |
| 7 | Change Password | /api/users/{id}/change-password | POST | id (type: Long; description: user ID as path variable), currentPassword (type: string; description: current password), newPassword (type: string; description: new password, min 6 characters) | {"message": "Password changed successfully"} | 127.0.0.1:8080/api/users/1/change-password | Changes the password for a specific user. Requires current password verification. |
| 8 | Health Check | /api/users/health/check | GET | None | "Application is healthy" | 127.0.0.1:8080/api/users/health/check | Health check endpoint to verify application status. |
| 9 | Get All Rooms | /api/rooms | GET | None | [{"id": 1, "name": "Conference Room A", "capacity": 10, "amenities": "Projector,Whiteboard,WiFi", "description": "Large conference room", "status": "AVAILABLE", "imageUrl": "/images/room1.jpg"}] | 127.0.0.1:8080/api/rooms | Retrieves list of all meeting rooms. |
| 10 | Search Rooms | /api/rooms/search | GET | date (type: string; description: date in YYYY-MM-DD format, optional), startTime (type: string; description: start time in HH:mm format, optional), endTime (type: string; description: end time in HH:mm format, optional), capacity (type: Integer; description: minimum capacity required, optional) | [{"id": 1, "name": "Conference Room A", "capacity": 10, "amenities": "Projector,Whiteboard,WiFi", "description": "Large conference room", "status": "AVAILABLE", "imageUrl": "/images/room1.jpg"}] | 127.0.0.1:8080/api/rooms/search?date=2026-01-18&startTime=09:00&endTime=10:00&capacity=5 | Searches for available meeting rooms based on date, time, and capacity filters. |
| 11 | Create Room | /api/rooms | POST | name (type: string; description: room name), capacity (type: Integer; description: room capacity), amenities (type: string; description: comma-separated amenities), description (type: string; description: room description), status (type: string; description: AVAILABLE or MAINTENANCE), imageUrl (type: string; description: image URL) | {"id": 1, "name": "Conference Room A", "capacity": 10, "amenities": "Projector,Whiteboard,WiFi", "description": "Large conference room", "status": "AVAILABLE", "imageUrl": "/images/room1.jpg"} | 127.0.0.1:8080/api/rooms | Creates a new meeting room in the system. |
| 12 | Get Room By ID | /api/rooms/{id} | GET | id (type: Long; description: room ID as path variable) | {"id": 1, "name": "Conference Room A", "capacity": 10, "amenities": "Projector,Whiteboard,WiFi", "description": "Large conference room", "status": "AVAILABLE", "imageUrl": "/images/room1.jpg"} | 127.0.0.1:8080/api/rooms/1 | Retrieves meeting room details by room ID. |
| 13 | Update Room | /api/rooms/{id} | PUT | id (type: Long; description: room ID as path variable), Request Body: MeetingRoom object with fields - name (string), capacity (Integer), amenities (string), description (string), status (string), imageUrl (string) | {"id": 1, "name": "Updated Room A", "capacity": 15, "amenities": "Projector,Whiteboard,WiFi,TV", "description": "Updated description", "status": "AVAILABLE", "imageUrl": "/images/room1.jpg"} | 127.0.0.1:8080/api/rooms/1 | Updates meeting room information for the specified room ID. |
| 14 | Delete Room | /api/rooms/{id} | DELETE | id (type: Long; description: room ID as path variable) | No content (HTTP 200) | 127.0.0.1:8080/api/rooms/1 | Deletes a meeting room from the system by room ID. |
| 15 | Create Booking | /api/bookings | POST | userId (type: Long; description: user ID), roomId (type: Long; description: room ID), startTime (type: LocalDateTime; description: booking start time in ISO format), endTime (type: LocalDateTime; description: booking end time in ISO format), purpose (type: string; description: purpose of booking) | {"id": 1, "user": {User object}, "room": {MeetingRoom object}, "startTime": "2026-01-18T09:00:00", "endTime": "2026-01-18T10:00:00", "status": "PENDING", "purpose": "Team meeting", "createdAt": "2026-01-18T00:00:00"} | 127.0.0.1:8080/api/bookings | Creates a new booking for a meeting room. |
| 16 | Get User Bookings | /api/bookings/user/{userId} | GET | userId (type: Long; description: user ID as path variable) | [{"id": 1, "user": {User object}, "room": {MeetingRoom object}, "startTime": "2026-01-18T09:00:00", "endTime": "2026-01-18T10:00:00", "status": "CONFIRMED", "purpose": "Team meeting", "createdAt": "2026-01-18T00:00:00"}] | 127.0.0.1:8080/api/bookings/user/1 | Retrieves all bookings for a specific user. |
| 17 | Cancel Booking | /api/bookings/{id}/cancel | POST | id (type: Long; description: booking ID as path variable) | No content (HTTP 200) | 127.0.0.1:8080/api/bookings/1/cancel | Cancels an existing booking by booking ID. |
| 18 | Get Pending Bookings (Admin) | /api/bookings/pending | GET | None | [{"id": 1, "user": {User object}, "room": {MeetingRoom object}, "startTime": "2026-01-18T09:00:00", "endTime": "2026-01-18T10:00:00", "status": "PENDING", "purpose": "Team meeting", "createdAt": "2026-01-18T00:00:00"}] | 127.0.0.1:8080/api/bookings/pending | Retrieves all pending bookings awaiting admin approval. |
| 19 | Get All Bookings (Admin) | /api/bookings/admin/all | GET | None | [{"id": 1, "user": {User object}, "room": {MeetingRoom object}, "startTime": "2026-01-18T09:00:00", "endTime": "2026-01-18T10:00:00", "status": "CONFIRMED", "purpose": "Team meeting", "createdAt": "2026-01-18T00:00:00"}] | 127.0.0.1:8080/api/bookings/admin/all | Retrieves all bookings in the system (Admin only). |
| 20 | Approve Booking (Admin) | /api/bookings/{id}/approve | POST | id (type: Long; description: booking ID as path variable) | {"id": 1, "user": {User object}, "room": {MeetingRoom object}, "startTime": "2026-01-18T09:00:00", "endTime": "2026-01-18T10:00:00", "status": "CONFIRMED", "purpose": "Team meeting", "createdAt": "2026-01-18T00:00:00"} | 127.0.0.1:8080/api/bookings/1/approve | Approves a pending booking (Admin only). Changes status to CONFIRMED. |
| 21 | Reject Booking (Admin) | /api/bookings/{id}/reject | POST | id (type: Long; description: booking ID as path variable) | {"id": 1, "user": {User object}, "room": {MeetingRoom object}, "startTime": "2026-01-18T09:00:00", "endTime": "2026-01-18T10:00:00", "status": "REJECTED", "purpose": "Team meeting", "createdAt": "2026-01-18T00:00:00"} | 127.0.0.1:8080/api/bookings/1/reject | Rejects a pending booking (Admin only). Changes status to REJECTED. |
| 22 | Get Bookings By Date Range | /api/bookings/range | GET | start (type: string; description: start datetime in ISO format), end (type: string; description: end datetime in ISO format) | [{"id": 1, "user": {User object}, "room": {MeetingRoom object}, "startTime": "2026-01-18T09:00:00", "endTime": "2026-01-18T10:00:00", "status": "CONFIRMED", "purpose": "Team meeting", "createdAt": "2026-01-18T00:00:00"}] | 127.0.0.1:8080/api/bookings/range?start=2026-01-18T00:00:00&end=2026-01-18T23:59:59 | Retrieves all bookings within a specific date/time range. |
| 23 | Get Dashboard Stats | /api/stats | GET | None | {"totalRooms": 5, "activeBookings": 10, "pendingBookings": 3, "confirmedBookingsToday": 8, "availableRooms": 4, "mostPopularRoomName": "Conference Room A"} | 127.0.0.1:8080/api/stats | Retrieves dashboard statistics including room counts, booking counts, and most popular room. |

---

## Notes

1. **All interfaces adopt the RESTful architecture**, with URLs structured as domain + static resource.
2. **Debug domain:** http://127.0.0.1:8080
3. **All HTTP requests must include the userid and token parameters in the headers** (note: userid should not contain underscores).
4. **If required parameters are absent, the system returns 0.**
5. **Standard response format:** {code: 1, msg: success, data: xxx}, where code 1 indicates successful data retrieval, and other values represent errors.

---

## Data Models Reference

### User Object
```json
{
  "id": 1,
  "email": "user@example.com",
  "password": "hashed_password",
  "firstName": "John",
  "lastName": "Doe",
  "role": "USER",
  "active": true,
  "createdAt": "2026-01-18T00:00:00",
  "updatedAt": "2026-01-18T00:00:00"
}
```

### MeetingRoom Object
```json
{
  "id": 1,
  "name": "Conference Room A",
  "capacity": 10,
  "amenities": "Projector,Whiteboard,WiFi",
  "description": "Large conference room",
  "status": "AVAILABLE",
  "imageUrl": "/images/room1.jpg"
}
```

### Booking Object
```json
{
  "id": 1,
  "user": {User object},
  "room": {MeetingRoom object},
  "startTime": "2026-01-18T09:00:00",
  "endTime": "2026-01-18T10:00:00",
  "status": "CONFIRMED",
  "purpose": "Team meeting",
  "createdAt": "2026-01-18T00:00:00"
}
```

### AuthResponseDTO
```json
{
  "token": "jwt-token-string",
  "userId": 1,
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "role": "USER"
}
```

### DashboardStatsDTO
```json
{
  "totalRooms": 5,
  "activeBookings": 10,
  "pendingBookings": 3,
  "confirmedBookingsToday": 8,
  "availableRooms": 4,
  "mostPopularRoomName": "Conference Room A"
}
```

---

## Status Codes

| Status | Description |
|--------|-------------|
| AVAILABLE | Room is available for booking |
| MAINTENANCE | Room is under maintenance |
| PENDING | Booking is awaiting admin approval |
| CONFIRMED | Booking is confirmed/approved |
| CANCELLED | Booking has been cancelled |
| REJECTED | Booking has been rejected by admin |
| COMPLETED | Booking has been completed |

---

## Role Types

| Role | Description |
|------|-------------|
| USER | Regular user - can book rooms and view own bookings |
| ADMIN | Administrator - can approve/reject bookings, manage rooms and users |
