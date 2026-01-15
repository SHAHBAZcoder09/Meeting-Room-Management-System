# Meeting Room Management System
## Technical Design Document

**Project Name:** N4Booking - Meeting Room Management System  
**Group:** N4  
**Author:** Ayush Maheshwari  
**Version:** 1.0.0  
**Date:** January 16, 2026

---

# CONTENTS

1. Research Background .................................................... 5
2. Reading Object ............................................................. 5
3. References ................................................................... 5
4. Terms & Abbreviations .................................................. 5
5. Preliminary Design ........................................................ 5
   - 5.1 Requirement Overview ......................................... 5
   - 5.2 System Function Flowchart .................................. 6
   - 5.3 System Data Flow Diagram .................................. 6
   - 5.4 Others ................................................................ 6
6. Detailed Design ............................................................ 6
   - 6.1 Detailed Design of User Module ........................... 6
   - 6.2 Detailed Design of Room Module ......................... 7
   - 6.3 Detailed Design of Booking Module ..................... 7
7. Database Design ........................................................... 7
   - 7.1 Review of Database Design .................................. 7
   - 7.2 Design of Database Logical Structure ................... 7
   - 7.3 Design of Database Physical Structure ................. 7
   - 7.4 Database Security Design .................................... 7
   - 7.5 Data Dictionary .................................................. 7
8. System Reliability Design .............................................. 7
9. Appendix ..................................................................... 7

---

# 1. Research Background

## 1.1 Project Overview

The Meeting Room Management System (N4Booking) is a web-based application designed to streamline the process of booking and managing meeting rooms in corporate environments. Traditional methods of room booking through emails, spreadsheets, or manual sign-up sheets are inefficient, prone to double-bookings, and lack real-time visibility.

## 1.2 Problem Statement

Organizations face the following challenges with meeting room management:
- **Double Bookings:** Multiple teams booking the same room at the same time
- **Lack of Visibility:** No real-time view of room availability
- **Inefficient Process:** Time wasted in coordinating meeting spaces
- **No Approval Workflow:** Unauthorized use of premium meeting spaces
- **Poor Resource Utilization:** Rooms booked but not used

## 1.3 Solution

N4Booking provides a comprehensive digital solution that enables:
- Real-time room availability checking
- Instant booking with conflict prevention
- Admin approval workflow for controlled access
- Calendar view for weekly/monthly planning
- User-friendly interface with multilingual support (English/Chinese)

## 1.4 Target Users

| User Type | Description |
|-----------|-------------|
| Regular Users | Employees who need to book meeting rooms |
| Administrators | Office managers who approve/reject bookings and manage rooms |

---

# 2. Reading Object

This document is intended for the following audiences:

| Audience | Purpose |
|----------|---------|
| Development Team | Technical implementation reference |
| Project Managers | Project scope and requirements understanding |
| QA Engineers | Test case development and validation |
| System Administrators | Deployment and maintenance guidance |
| Future Developers | System maintenance and enhancement |

---

# 3. References

| Reference | Description |
|-----------|-------------|
| Spring Boot Documentation | https://docs.spring.io/spring-boot/docs/current/reference/html/ |
| Vue.js 3 Guide | https://vuejs.org/guide/introduction.html |
| Vuetify 3 Components | https://vuetifyjs.com/en/components/all/ |
| MySQL Documentation | https://dev.mysql.com/doc/ |
| TiDB Cloud Documentation | https://docs.pingcap.com/tidbcloud |
| JWT.io | https://jwt.io/introduction |
| RESTful API Design | https://restfulapi.net/ |

---

# 4. Terms & Abbreviations

| Term | Full Form | Description |
|------|-----------|-------------|
| API | Application Programming Interface | Interface for software communication |
| REST | Representational State Transfer | Architectural style for web services |
| JWT | JSON Web Token | Secure token for authentication |
| CRUD | Create, Read, Update, Delete | Basic database operations |
| DTO | Data Transfer Object | Object for transferring data between layers |
| JPA | Java Persistence API | Java specification for ORM |
| ORM | Object-Relational Mapping | Database-object conversion technique |
| SPA | Single Page Application | Web app that loads a single HTML page |
| UI | User Interface | Visual elements users interact with |
| UX | User Experience | Overall user interaction experience |
| MVC | Model-View-Controller | Software design pattern |
| i18n | Internationalization | Multi-language support |
| CORS | Cross-Origin Resource Sharing | Browser security mechanism |

---

# 5. Preliminary Design

## 5.1 Requirement Overview

### 5.1.1 Functional Requirements

| ID | Requirement | Priority | Description |
|----|-------------|----------|-------------|
| FR-01 | User Registration | High | Users can create accounts with email and password |
| FR-02 | User Authentication | High | Secure login with JWT tokens |
| FR-03 | View Rooms | High | Display all available meeting rooms |
| FR-04 | Search Rooms | Medium | Filter rooms by date, time, capacity |
| FR-05 | Book Room | High | Create booking with date, time, purpose |
| FR-06 | View My Bookings | High | Users see their booking history |
| FR-07 | Cancel Booking | Medium | Users can cancel their bookings |
| FR-08 | Admin Approval | High | Admins approve/reject pending bookings |
| FR-09 | Room Management | Medium | Admins can add/edit/delete rooms |
| FR-10 | Calendar View | Medium | Weekly calendar of all bookings |
| FR-11 | Profile Management | Low | Users can update their profile |
| FR-12 | Change Password | Low | Users can change their password |
| FR-13 | Language Switch | Low | Toggle between English and Chinese |

### 5.1.2 Non-Functional Requirements

| ID | Requirement | Description |
|----|-------------|-------------|
| NFR-01 | Performance | Page load time < 3 seconds |
| NFR-02 | Security | Password encryption with BCrypt |
| NFR-03 | Availability | 99.9% uptime target |
| NFR-04 | Scalability | Support 500+ concurrent users |
| NFR-05 | Usability | Mobile-responsive design |
| NFR-06 | Maintainability | Modular code architecture |

## 5.2 System Function Flowchart

```
┌─────────────────────────────────────────────────────────────────┐
│                    N4Booking System Flow                         │
└─────────────────────────────────────────────────────────────────┘

                         ┌──────────┐
                         │  START   │
                         └────┬─────┘
                              │
                              ▼
                    ┌─────────────────┐
                    │   Home Page     │
                    │   (Landing)     │
                    └────────┬────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
        ┌──────────┐  ┌──────────┐  ┌──────────┐
        │  Login   │  │ Register │  │  Demo    │
        └────┬─────┘  └────┬─────┘  └──────────┘
             │              │
             └──────┬───────┘
                    │
                    ▼
           ┌────────────────┐
           │   Dashboard    │
           │  (Room List)   │
           └───────┬────────┘
                   │
    ┌──────────────┼──────────────────┐
    │              │                  │
    ▼              ▼                  ▼
┌────────┐   ┌──────────┐      ┌───────────┐
│ Book   │   │ Calendar │      │ My        │
│ Room   │   │ View     │      │ Bookings  │
└───┬────┘   └──────────┘      └─────┬─────┘
    │                                │
    ▼                                ▼
┌──────────────┐              ┌──────────────┐
│ Select Date/ │              │ View/Cancel  │
│ Time/Purpose │              │ Bookings     │
└──────┬───────┘              └──────────────┘
       │
       ▼
┌──────────────┐
│   Submit     │
│   Booking    │
└──────┬───────┘
       │
       ▼
┌──────────────┐     ┌──────────────┐
│   PENDING    │────▶│ Admin Review │
└──────────────┘     └──────┬───────┘
                            │
              ┌─────────────┼─────────────┐
              │                           │
              ▼                           ▼
       ┌──────────┐               ┌──────────┐
       │ APPROVED │               │ REJECTED │
       │ (Confirm)│               │          │
       └──────────┘               └──────────┘
```

## 5.3 System Data Flow Diagram

### Level 0 - Context Diagram

```
                    ┌─────────────────┐
     User ─────────▶│                 │─────────▶ Booking Confirmation
                    │   N4Booking     │
     Admin ────────▶│   System        │─────────▶ Management Reports
                    │                 │
                    └────────┬────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │    Database     │
                    │ (Users, Rooms,  │
                    │   Bookings)     │
                    └─────────────────┘
```

### Level 1 - Process Diagram

```
┌──────────────────────────────────────────────────────────────────┐
│                                                                   │
│  ┌────────┐    ┌──────────────┐    ┌──────────────┐              │
│  │  User  │───▶│ 1.0 User     │───▶│ Users Table  │              │
│  └────────┘    │ Management   │    └──────────────┘              │
│                └──────────────┘                                   │
│                                                                   │
│  ┌────────┐    ┌──────────────┐    ┌──────────────┐              │
│  │  User  │───▶│ 2.0 Room     │◀──▶│ Rooms Table  │              │
│  └────────┘    │ Search       │    └──────────────┘              │
│                └──────────────┘                                   │
│                                                                   │
│  ┌────────┐    ┌──────────────┐    ┌──────────────┐              │
│  │  User  │───▶│ 3.0 Booking  │◀──▶│ Bookings     │              │
│  └────────┘    │ Management   │    │ Table        │              │
│                └──────────────┘    └──────────────┘              │
│                       ▲                                           │
│                       │                                           │
│  ┌────────┐    ┌──────┴───────┐                                  │
│  │ Admin  │───▶│ 4.0 Admin    │                                  │
│  └────────┘    │ Approval     │                                  │
│                └──────────────┘                                   │
│                                                                   │
└──────────────────────────────────────────────────────────────────┘
```

## 5.4 Others

### 5.4.1 Technology Stack

| Layer | Technology | Version |
|-------|------------|---------|
| Frontend Framework | Vue.js | 3.5.26 |
| UI Component Library | Vuetify | 3.11.6 |
| Frontend Router | Vue Router | 4.6.4 |
| Internationalization | vue-i18n | 9.x |
| Build Tool | Vite | 7.3.0 |
| Backend Framework | Spring Boot | 3.x |
| ORM | Spring Data JPA | 3.x |
| Security | Spring Security | 6.x |
| Database | TiDB Cloud (MySQL) | 8.x compatible |
| Authentication | JWT | - |

### 5.4.2 Development Environment

| Tool | Version | Purpose |
|------|---------|---------|
| Node.js | 20.19.0+ | Frontend runtime |
| Java | 17+ | Backend runtime |
| Maven | 3.9+ | Build management |
| VS Code | Latest | IDE |
| Git | Latest | Version control |

---

# 6. Detailed Design

## 6.1 Detailed Design of User Module

### 6.1.1 Module Interface

| Interface | Method | Endpoint | Description |
|-----------|--------|----------|-------------|
| Register | POST | /api/users/register | Create new user account |
| Login | POST | /api/users/login | Authenticate and get token |
| Get User | GET | /api/users/{id} | Retrieve user details |
| Update User | PUT | /api/users/{id} | Update user profile |
| Delete User | DELETE | /api/users/{id} | Remove user account |
| Change Password | POST | /api/users/{id}/change-password | Update password |

### 6.1.2 Module Internal Processing Flow

```
Register Flow:
┌────────────┐   ┌──────────────┐   ┌──────────────┐   ┌────────────┐
│ Receive    │──▶│ Validate    │──▶│ Encrypt      │──▶│ Save to    │
│ Request    │   │ Input Data  │   │ Password     │   │ Database   │
└────────────┘   └──────────────┘   └──────────────┘   └─────┬──────┘
                                                              │
                                                              ▼
┌────────────┐   ┌──────────────┐                    ┌────────────────┐
│ Return     │◀──│ Generate     │◀───────────────────│ Create User    │
│ Response   │   │ JWT Token    │                    │ Object         │
└────────────┘   └──────────────┘                    └────────────────┘

Login Flow:
┌────────────┐   ┌──────────────┐   ┌──────────────┐   ┌────────────┐
│ Receive    │──▶│ Find User   │──▶│ Verify       │──▶│ Generate   │
│ Credentials│   │ by Email    │   │ Password     │   │ JWT Token  │
└────────────┘   └──────────────┘   └──────────────┘   └─────┬──────┘
                                                              │
                                                              ▼
                                                     ┌────────────────┐
                                                     │ Return Auth    │
                                                     │ Response       │
                                                     └────────────────┘
```

### 6.1.3 Module Class Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         UserController                           │
├─────────────────────────────────────────────────────────────────┤
│ - userService: UserService                                       │
├─────────────────────────────────────────────────────────────────┤
│ + register(UserRegistrationDTO): ResponseEntity<AuthResponseDTO> │
│ + login(LoginDTO): ResponseEntity<AuthResponseDTO>               │
│ + getUserById(Long): ResponseEntity<User>                        │
│ + updateUser(Long, User): ResponseEntity<User>                   │
│ + deleteUser(Long): ResponseEntity<Void>                         │
│ + changePassword(Long, PasswordChangeDTO): ResponseEntity<?>     │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ uses
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                          UserService                             │
├─────────────────────────────────────────────────────────────────┤
│ - userRepository: UserRepository                                 │
│ - passwordEncoder: BCryptPasswordEncoder                         │
│ - jwtUtil: JwtUtil                                              │
├─────────────────────────────────────────────────────────────────┤
│ + register(UserRegistrationDTO): AuthResponseDTO                 │
│ + login(LoginDTO): AuthResponseDTO                               │
│ + getUserById(Long): User                                        │
│ + updateUser(Long, User): User                                   │
│ + deleteUser(Long): void                                         │
│ + changePassword(Long, String, String): void                     │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ uses
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        UserRepository                            │
│                   (extends JpaRepository)                        │
├─────────────────────────────────────────────────────────────────┤
│ + findByEmail(String): Optional<User>                           │
│ + existsByEmail(String): Boolean                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 6.1.4 Module Data Flow

```
Frontend (Vue.js)          API Gateway           Backend (Spring Boot)
     │                          │                        │
     │  POST /api/users/login   │                        │
     │─────────────────────────▶│                        │
     │    {email, password}     │   Forward Request      │
     │                          │───────────────────────▶│
     │                          │                        │ Validate
     │                          │                        │ credentials
     │                          │   Return JWT + User    │
     │                          │◀───────────────────────│
     │    {token, userId,       │                        │
     │     firstName, role}     │                        │
     │◀─────────────────────────│                        │
     │                          │                        │
     │  Store token in          │                        │
     │  localStorage            │                        │
     │                          │                        │
```

### 6.1.5 Algorithm Description

**Password Encryption Algorithm:** BCrypt

```
BCrypt Process:
1. Generate random salt (16 bytes)
2. Combine password + salt
3. Apply Blowfish cipher (cost factor = 10)
4. Produce 60-character hash

Hash Format: $2a$10$[22-char salt][31-char hash]

Verification:
1. Extract salt from stored hash
2. Hash input password with same salt
3. Compare resulting hash with stored hash
```

**JWT Token Generation:**

```
JWT Structure:
Header: {"alg": "HS256", "typ": "JWT"}
Payload: {
  "sub": "user@email.com",
  "userId": 1,
  "role": "USER",
  "iat": 1705347600,
  "exp": 1705434000  // 24 hours validity
}
Signature: HMACSHA256(base64(header) + "." + base64(payload), secret)
```

### 6.1.6 External Interface

**Request: User Registration**
```json
POST /api/users/register
Content-Type: application/json

{
  "firstName": "string (required, 2-50 chars)",
  "lastName": "string (required, 2-50 chars)",
  "email": "string (required, valid email format)",
  "password": "string (required, min 6 chars)"
}
```

**Response: Authentication Success**
```json
HTTP/1.1 201 Created
Content-Type: application/json

{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "userId": 1,
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "role": "USER"
}
```

---

## 6.2 Detailed Design of Room Module

### 6.2.1 Module Interface

| Interface | Method | Endpoint | Description |
|-----------|--------|----------|-------------|
| Get All Rooms | GET | /api/rooms | List all meeting rooms |
| Search Rooms | GET | /api/rooms/search | Search by criteria |
| Get Room | GET | /api/rooms/{id} | Get room details |
| Create Room | POST | /api/rooms | Add new room (Admin) |
| Update Room | PUT | /api/rooms/{id} | Edit room (Admin) |
| Delete Room | DELETE | /api/rooms/{id} | Remove room (Admin) |

### 6.2.2 Module Class Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         RoomController                           │
├─────────────────────────────────────────────────────────────────┤
│ - roomService: RoomService                                       │
├─────────────────────────────────────────────────────────────────┤
│ + getAllRooms(): ResponseEntity<List<MeetingRoom>>              │
│ + searchRooms(...): ResponseEntity<List<MeetingRoom>>           │
│ + getRoomById(Long): ResponseEntity<MeetingRoom>                │
│ + createRoom(MeetingRoom): ResponseEntity<MeetingRoom>          │
│ + updateRoom(Long, MeetingRoom): ResponseEntity<MeetingRoom>    │
│ + deleteRoom(Long): ResponseEntity<?>                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                          RoomService                             │
├─────────────────────────────────────────────────────────────────┤
│ - roomRepository: RoomRepository                                 │
│ - bookingRepository: BookingRepository                           │
├─────────────────────────────────────────────────────────────────┤
│ + getAllRooms(): List<MeetingRoom>                              │
│ + searchRooms(LocalDateTime, LocalDateTime, Integer): List      │
│ + getRoomById(Long): MeetingRoom                                │
│ + createRoom(MeetingRoom): MeetingRoom                          │
│ + updateRoom(Long, MeetingRoom): MeetingRoom                    │
│ + deleteRoom(Long): void                                        │
└─────────────────────────────────────────────────────────────────┘
```

### 6.2.3 Room Search Algorithm

```
Input: date, startTime, endTime, minCapacity

Algorithm:
1. Parse date + startTime → requestedStart
2. Parse date + endTime → requestedEnd
3. Query all rooms with capacity >= minCapacity
4. For each room:
   a. Get all CONFIRMED bookings overlapping with [requestedStart, requestedEnd]
   b. If overlap count = 0, room is available
5. Return list of available rooms

SQL Logic:
SELECT * FROM meeting_rooms r
WHERE r.capacity >= :capacity
AND NOT EXISTS (
  SELECT 1 FROM bookings b
  WHERE b.room_id = r.id
  AND b.status = 'CONFIRMED'
  AND b.start_time < :endTime
  AND b.end_time > :startTime
)
```

---

## 6.3 Detailed Design of Booking Module

### 6.3.1 Module Interface

| Interface | Method | Endpoint | Description |
|-----------|--------|----------|-------------|
| Create Booking | POST | /api/bookings | Submit new booking |
| User Bookings | GET | /api/bookings/user/{id} | Get user's bookings |
| Cancel Booking | POST | /api/bookings/{id}/cancel | Cancel a booking |
| Pending Bookings | GET | /api/bookings/pending | Admin: pending list |
| All Bookings | GET | /api/bookings/admin/all | Admin: all bookings |
| Approve | POST | /api/bookings/{id}/approve | Admin: approve |
| Reject | POST | /api/bookings/{id}/reject | Admin: reject |
| Date Range | GET | /api/bookings/range | Calendar data |

### 6.3.2 Booking State Machine

```
                    ┌──────────────┐
                    │   PENDING    │
                    │  (Initial)   │
                    └──────┬───────┘
                           │
           ┌───────────────┼───────────────┐
           │               │               │
           ▼               │               ▼
    ┌──────────────┐       │       ┌──────────────┐
    │  CONFIRMED   │       │       │   REJECTED   │
    │  (Approved)  │       │       │              │
    └──────┬───────┘       │       └──────────────┘
           │               │
           │               ▼
           │       ┌──────────────┐
           └──────▶│  CANCELLED   │
                   │ (User/Admin) │
                   └──────────────┘

State Transitions:
- PENDING → CONFIRMED (Admin approves)
- PENDING → REJECTED (Admin rejects)
- PENDING → CANCELLED (User cancels)
- CONFIRMED → CANCELLED (User/Admin cancels)
```

### 6.3.3 Conflict Detection Algorithm

```
function checkConflict(roomId, startTime, endTime):
    existingBookings = findBookings(roomId, status='CONFIRMED')
    
    for each booking in existingBookings:
        // Overlap condition:
        // New start < Existing end AND New end > Existing start
        if (startTime < booking.endTime AND endTime > booking.startTime):
            return CONFLICT_DETECTED
    
    return NO_CONFLICT
```

---

# 7. Database Design

## 7.1 Review of Database Design

The database design follows the Third Normal Form (3NF) to minimize data redundancy and ensure data integrity. The system uses three main entities:

1. **Users** - Stores user account information
2. **Meeting Rooms** - Stores room details and amenities
3. **Bookings** - Stores reservation records linking users and rooms

### Design Principles Applied:
- Primary keys use auto-increment Long IDs
- Foreign keys maintain referential integrity
- Appropriate indexes for query optimization
- Cascade delete disabled to preserve audit trail

## 7.2 Design of Database Logical Structure

### Entity-Relationship Diagram

```
┌─────────────────┐         ┌─────────────────┐
│     USERS       │         │  MEETING_ROOMS  │
├─────────────────┤         ├─────────────────┤
│ PK: id          │         │ PK: id          │
│ first_name      │         │ name            │
│ last_name       │         │ capacity        │
│ email (unique)  │         │ amenities       │
│ password        │         │ description     │
│ role            │         │ status          │
└────────┬────────┘         │ image_url       │
         │                  └────────┬────────┘
         │ 1                         │ 1
         │                           │
         │ creates                   │ has
         │                           │
         │ *                         │ *
         │                           │
┌────────┴───────────────────────────┴────────┐
│                  BOOKINGS                    │
├──────────────────────────────────────────────┤
│ PK: id                                       │
│ FK: user_id → USERS.id                       │
│ FK: room_id → MEETING_ROOMS.id               │
│ start_time                                   │
│ end_time                                     │
│ purpose                                      │
│ status (PENDING/CONFIRMED/REJECTED/CANCELLED)│
│ created_at                                   │
└──────────────────────────────────────────────┘

Cardinality:
- One USER can make many BOOKINGS (1:N)
- One ROOM can have many BOOKINGS (1:N)
- BOOKING is an associative entity between USER and ROOM
```

## 7.3 Design of Database Physical Structure

### Table: users

```sql
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### Table: meeting_rooms

```sql
CREATE TABLE meeting_rooms (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL,
    amenities TEXT,
    description TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'AVAILABLE',
    image_url VARCHAR(500),
    
    INDEX idx_capacity (capacity),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### Table: bookings

```sql
CREATE TABLE bookings (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    room_id BIGINT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    purpose VARCHAR(500),
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (room_id) REFERENCES meeting_rooms(id),
    
    INDEX idx_user_id (user_id),
    INDEX idx_room_id (room_id),
    INDEX idx_status (status),
    INDEX idx_time_range (start_time, end_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

## 7.4 Database Security Design

### 7.4.1 Authentication Security

| Security Measure | Implementation |
|------------------|----------------|
| Password Storage | BCrypt hashing (60 chars, cost factor 10) |
| Token Authentication | JWT with HS256 signature |
| Token Expiry | 24 hours |
| Secret Key | Environment variable (not in code) |

### 7.4.2 Data Protection

| Protection | Description |
|------------|-------------|
| SQL Injection | Parameterized queries via JPA |
| XSS Prevention | Input sanitization in frontend |
| CORS | Configured allowed origins |
| HTTPS | Recommended for production |

### 7.4.3 Access Control

| Role | Permissions |
|------|-------------|
| USER | View rooms, Create/Cancel own bookings, Update own profile |
| ADMIN | All USER permissions + Approve/Reject bookings + Manage rooms |

## 7.5 Data Dictionary

### Table: users

| Column | Data Type | Constraints | Description |
|--------|-----------|-------------|-------------|
| id | BIGINT | PK, AUTO_INCREMENT | Unique user identifier |
| first_name | VARCHAR(50) | NOT NULL | User's first name |
| last_name | VARCHAR(50) | NOT NULL | User's last name |
| email | VARCHAR(100) | NOT NULL, UNIQUE | Login email address |
| password | VARCHAR(255) | NOT NULL | BCrypt hashed password |
| role | VARCHAR(20) | NOT NULL, DEFAULT 'USER' | USER or ADMIN |
| created_at | TIMESTAMP | DEFAULT NOW() | Account creation time |

### Table: meeting_rooms

| Column | Data Type | Constraints | Description |
|--------|-----------|-------------|-------------|
| id | BIGINT | PK, AUTO_INCREMENT | Unique room identifier |
| name | VARCHAR(100) | NOT NULL | Room display name |
| capacity | INT | NOT NULL | Maximum occupancy |
| amenities | TEXT | | Comma-separated facilities |
| description | TEXT | | Room description |
| status | VARCHAR(20) | NOT NULL, DEFAULT 'AVAILABLE' | AVAILABLE or MAINTENANCE |
| image_url | VARCHAR(500) | | Room image path |

### Table: bookings

| Column | Data Type | Constraints | Description |
|--------|-----------|-------------|-------------|
| id | BIGINT | PK, AUTO_INCREMENT | Unique booking identifier |
| user_id | BIGINT | FK → users.id, NOT NULL | Booking creator |
| room_id | BIGINT | FK → meeting_rooms.id, NOT NULL | Booked room |
| start_time | DATETIME | NOT NULL | Meeting start time |
| end_time | DATETIME | NOT NULL | Meeting end time |
| purpose | VARCHAR(500) | | Meeting purpose/agenda |
| status | VARCHAR(20) | NOT NULL, DEFAULT 'PENDING' | Booking status |
| created_at | TIMESTAMP | DEFAULT NOW() | Booking creation time |

**Status Values:**
- PENDING - Awaiting admin approval
- CONFIRMED - Approved and scheduled
- REJECTED - Denied by admin
- CANCELLED - Cancelled by user or admin

---

# 8. System Reliability Design

## 8.1 Error Handling

| Error Type | Handling Strategy |
|------------|-------------------|
| Validation Errors | Return 400 with field-specific messages |
| Authentication Failure | Return 401 with "Invalid credentials" |
| Authorization Failure | Return 403 with "Access denied" |
| Resource Not Found | Return 404 with "Resource not found" |
| Booking Conflict | Return 400 with "Time slot unavailable" |
| Server Errors | Return 500, log full stack trace |

## 8.2 Logging Strategy

| Log Level | Usage |
|-----------|-------|
| ERROR | Exceptions, failed operations |
| WARN | Unusual conditions, deprecations |
| INFO | Significant events (login, booking) |
| DEBUG | Detailed flow information |

## 8.3 Data Backup

| Backup Type | Frequency | Retention |
|-------------|-----------|-----------|
| Full Database | Daily | 30 days |
| Transaction Logs | Hourly | 7 days |

## 8.4 Performance Optimization

| Optimization | Implementation |
|--------------|----------------|
| Database Indexing | Indexes on frequently queried columns |
| Connection Pooling | HikariCP with 10 connections |
| Lazy Loading | JPA lazy fetch for collections |
| Frontend Caching | LocalStorage for user session |

---

# 9. Appendix

## 9.1 API Endpoint Summary

| # | Endpoint | Method | Auth | Description |
|---|----------|--------|------|-------------|
| 1 | /api/users/register | POST | No | Register user |
| 2 | /api/users/login | POST | No | User login |
| 3 | /api/users/{id} | GET | Yes | Get user |
| 4 | /api/users/{id} | PUT | Yes | Update user |
| 5 | /api/users/{id} | DELETE | Yes | Delete user |
| 6 | /api/users/{id}/change-password | POST | Yes | Change password |
| 7 | /api/rooms | GET | Yes | List rooms |
| 8 | /api/rooms/search | GET | Yes | Search rooms |
| 9 | /api/rooms | POST | Admin | Create room |
| 10 | /api/rooms/{id} | PUT | Admin | Update room |
| 11 | /api/rooms/{id} | DELETE | Admin | Delete room |
| 12 | /api/bookings | POST | Yes | Create booking |
| 13 | /api/bookings/user/{id} | GET | Yes | User bookings |
| 14 | /api/bookings/{id}/cancel | POST | Yes | Cancel booking |
| 15 | /api/bookings/pending | GET | Admin | Pending list |
| 16 | /api/bookings/admin/all | GET | Admin | All bookings |
| 17 | /api/bookings/{id}/approve | POST | Admin | Approve |
| 18 | /api/bookings/{id}/reject | POST | Admin | Reject |
| 19 | /api/bookings/range | GET | Yes | Calendar data |

## 9.2 Environment Configuration

```properties
# Database
spring.datasource.url=jdbc:mysql://gateway01.xxx.tidbcloud.com:4000/meeting_room_db
spring.datasource.username=${DB_USERNAME}
spring.datasource.password=${DB_PASSWORD}

# JPA
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# JWT
jwt.secret=${JWT_SECRET}
jwt.expiration=86400000

# Server
server.port=8080
```

## 9.3 Build & Run Instructions

**Backend:**
```bash
cd "Meeting room Management system"
mvn spring-boot:run
```

**Frontend:**
```bash
cd Meeting_Room_Frontend
npm install
npm run dev
```

**Access:**
- Frontend: http://localhost:5173
- Backend API: http://localhost:8080/api

---

**Document End**
