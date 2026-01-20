# N4Booking Meeting Room Management System

---

## 产品名称 Product Name | 密级 Confidentiality Level
:--- | :---
Meeting Room Management System | Internal Public

## 产品版本 Product Version | 
:--- | :---
Version 1.0.0 | Total Pages: 15

---

<div align="center">

# **N4Booking Product Software Design Specification**

<br><br><br>

| Drafter 起草人 | Time 时间 |
|:---|:---|
| Ayush Maheshwari | January 16, 2026 |

<br>

**Group N4**

**All Rights Reserved. Infringement will be prosecuted.**

</div>

---

# Document Revision History

| Version | Date | Author | Changes Made |
|---------|------|--------|--------------|
| 1.0.0 | 2026-01-16 | Ayush Maheshwari | Initial document creation |

---

# TABLE OF CONTENTS

1. [Research Background](#1-research-background)
2. [Reading Object](#2-reading-object)
3. [References](#3-references)
4. [Terms & Abbreviations](#4-terms--abbreviations)
5. [Preliminary Design](#5-preliminary-design)
   - 5.1 Requirement Overview
   - 5.2 System Function Flowchart
   - 5.3 System Data Flow Diagram
   - 5.4 Technology Stack
6. [Detailed Design](#6-detailed-design)
   - 6.1 User Module Design
   - 6.2 Room Module Design
   - 6.3 Booking Module Design
7. [Database Design](#7-database-design)
   - 7.1 Database Design Review
   - 7.2 Logical Structure Design
   - 7.3 Physical Structure Design
   - 7.4 Security Design
   - 7.5 Data Dictionary
8. [System Reliability Design](#8-system-reliability-design)
9. [Appendix](#9-appendix)

---

# 1. Research Background

## 1.1 What This Project Is About

N4Booking is a web-based platform built to make meeting room reservations simple and hassle-free for organizations. The traditional approach to booking conference rooms—through emails, spreadsheets, or paper sign-up sheets—often leads to confusion, overlapping reservations, and wasted time trying to coordinate spaces.

## 1.2 The Problems We're Solving

Many organizations struggle with these common pain points when managing meeting spaces:

- **Overlapping Reservations:** It's frustrating when two teams show up for the same room because someone forgot to check the schedule
- **No Real-Time Visibility:** People waste time walking to rooms only to find them occupied
- **Time-Consuming Coordination:** Employees spend too much time emailing back and forth just to secure a meeting space
- **Uncontrolled Access to Premium Spaces:** Executive boardrooms get booked without proper authorization
- **Underutilized Resources:** Rooms get reserved but no one shows up, leaving valuable spaces empty

## 1.3 How We're Addressing These Challenges

Our solution brings the entire booking experience online with these core capabilities:

- Check room availability instantly from your browser
- Book rooms in seconds with automatic conflict prevention
- Admin approval workflow ensures proper authorization for key spaces
- Weekly and monthly calendar views help with planning ahead
- Support for both English and Chinese makes the system accessible to diverse teams

## 1.4 Who Will Use This System

| User Category | What They Do |
|---------------|--------------|
| Regular Employees | Browse available rooms and make reservations for their meetings |
| Office Administrators | Review booking requests, approve or decline them, and manage room configurations |

---

# 2. Reading Object

This document was written with the following readers in mind:

| Who Should Read This | Why It Matters to Them |
|----------------------|------------------------|
| Development Team | Provides the technical blueprint for building the system |
| Project Managers | Offers clarity on scope, features, and system capabilities |
| QA Engineers | Serves as a foundation for creating comprehensive test scenarios |
| System Administrators | Contains deployment and operational guidance |
| Future Developers | Acts as a reference for maintaining and extending the codebase |

---

# 3. References

The following resources informed the design and development approach:

| Resource | Purpose |
|----------|---------|
| [Spring Boot Official Docs](https://docs.spring.io/spring-boot/docs/current/reference/html/) | Backend framework reference |
| [Vue.js 3 Guide](https://vuejs.org/guide/introduction.html) | Frontend framework documentation |
| [Vuetify 3 Component Library](https://vuetifyjs.com/en/components/all/) | UI component reference |
| [MySQL Documentation](https://dev.mysql.com/doc/) | Database management guidance |
| [TiDB Cloud Docs](https://docs.pingcap.com/tidbcloud) | Cloud database platform reference |
| [JWT Introduction](https://jwt.io/introduction) | Token-based authentication concepts |
| [RESTful API Best Practices](https://restfulapi.net/) | API design principles |

---

# 4. Terms & Abbreviations

Here's a quick reference for technical terms used throughout this document:

| Abbreviation | What It Stands For | Plain English Explanation |
|--------------|-------------------|---------------------------|
| API | Application Programming Interface | A way for different software pieces to talk to each other |
| REST | Representational State Transfer | A popular style for building web services |
| JWT | JSON Web Token | A secure way to verify who you are when using the system |
| CRUD | Create, Read, Update, Delete | The four basic things you can do with data |
| DTO | Data Transfer Object | A container for moving data between different parts of the app |
| JPA | Java Persistence API | A standard way to connect Java code to databases |
| ORM | Object-Relational Mapping | Making database tables work like regular code objects |
| SPA | Single Page Application | A web app that loads once and updates dynamically |
| i18n | Internationalization | Making the app work in multiple languages |
| CORS | Cross-Origin Resource Sharing | A browser security feature that controls who can access the API |

---

# 5. Preliminary Design

## 5.1 What the System Needs to Do

### 5.1.1 Core Features

We prioritized features based on what users need most:

| ID | Feature | Priority | What It Does |
|----|---------|----------|--------------|
| FR-01 | Account Registration | High | New users can sign up with their email and a password |
| FR-02 | Secure Login | High | Existing users can authenticate using JWT tokens |
| FR-03 | Room Browsing | High | Anyone can see what meeting rooms are available |
| FR-04 | Smart Room Search | Medium | Filter rooms by date, time, and how many people you need to fit |
| FR-05 | Quick Booking | High | Reserve a room with your preferred date, time, and meeting purpose |
| FR-06 | Booking History | High | Users can review all their past and upcoming reservations |
| FR-07 | Cancellation | Medium | Changed plans? Cancel your booking easily |
| FR-08 | Admin Approval | High | Administrators can approve or decline pending requests |
| FR-09 | Room Administration | Medium | Admins can add new rooms, update details, or remove old ones |
| FR-10 | Calendar Overview | Medium | See all bookings laid out on a weekly calendar |
| FR-11 | Profile Settings | Low | Users can update their personal information |
| FR-12 | Password Updates | Low | Change your password when needed |
| FR-13 | Language Toggle | Low | Switch between English and Chinese interface |

### 5.1.2 Quality Requirements

Beyond features, we're committed to these quality standards:

| ID | Area | Target |
|----|------|--------|
| NFR-01 | Speed | Pages should load in under 3 seconds |
| NFR-02 | Security | All passwords encrypted using BCrypt |
| NFR-03 | Reliability | Aiming for 99.9% system uptime |
| NFR-04 | Scale | Should handle 500+ simultaneous users |
| NFR-05 | Accessibility | Works well on phones, tablets, and desktops |
| NFR-06 | Maintainability | Clean, modular code that's easy to update |

## 5.2 How Users Move Through the System

Here's a visual walkthrough of the typical user journey:

```
                          ┌──────────┐
                          │  START   │
                          └────┬─────┘
                               │
                               ▼
                     ┌─────────────────┐
                     │   Welcome Page  │
                     │   (Landing)     │
                     └────────┬────────┘
                              │
               ┌──────────────┼──────────────┐
               │              │              │
               ▼              ▼              ▼
         ┌──────────┐  ┌──────────┐  ┌──────────┐
         │  Log In  │  │ Sign Up  │  │ Explore  │
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
│ Reserve│   │ Calendar │      │    My     │
│ a Room │   │   View   │      │ Bookings  │
└───┬────┘   └──────────┘      └─────┬─────┘
    │                                │
    ▼                                ▼
┌──────────────┐              ┌──────────────┐
│ Pick Your    │              │ View, Edit,  │
│ Date & Time  │              │ or Cancel    │
└──────┬───────┘              └──────────────┘
       │
       ▼
┌──────────────┐
│ Submit Your  │
│ Reservation  │
└──────┬───────┘
       │
       ▼
┌──────────────┐     ┌──────────────┐
│   Waiting    │────▶│ Admin Takes  │
│  (Pending)   │     │   Action     │
└──────────────┘     └──────┬───────┘
                            │
              ┌─────────────┼─────────────┐
              │                           │
              ▼                           ▼
       ┌──────────┐               ┌──────────┐
       │ Approved │               │ Declined │
       │(You're in│               │          │
       └──────────┘               └──────────┘
```

## 5.3 Data Flow Overview

### High-Level View

```
                     ┌─────────────────┐
      User ─────────▶│                 │─────────▶ Booking Confirmations
                     │   N4Booking     │
      Admin ────────▶│   Application   │─────────▶ Management Reports
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

### Process-Level View

```
┌──────────────────────────────────────────────────────────────────┐
│                                                                   │
│  ┌────────┐    ┌──────────────┐    ┌──────────────┐              │
│  │  User  │───▶│ User Account │───▶│ Users Table  │              │
│  └────────┘    │  Management  │    └──────────────┘              │
│                └──────────────┘                                   │
│                                                                   │
│  ┌────────┐    ┌──────────────┐    ┌──────────────┐              │
│  │  User  │───▶│ Room Finder  │◀──▶│ Rooms Table  │              │
│  └────────┘    │              │    └──────────────┘              │
│                └──────────────┘                                   │
│                                                                   │
│  ┌────────┐    ┌──────────────┐    ┌──────────────┐              │
│  │  User  │───▶│  Booking     │◀──▶│ Bookings     │              │
│  └────────┘    │  Handler     │    │ Table        │              │
│                └──────────────┘    └──────────────┘              │
│                       ▲                                           │
│                       │                                           │
│  ┌────────┐    ┌──────┴───────┐                                  │
│  │ Admin  │───▶│  Approval    │                                  │
│  └────────┘    │  Workflow    │                                  │
│                └──────────────┘                                   │
│                                                                   │
└──────────────────────────────────────────────────────────────────┘
```

## 5.4 Technology Choices

### Our Tech Stack

| Layer | What We're Using | Version |
|-------|------------------|---------|
| Frontend Framework | Vue.js | 3.5.26 |
| UI Components | Vuetify | 3.11.6 |
| Client-Side Routing | Vue Router | 4.6.4 |
| Multi-Language Support | vue-i18n | 9.x |
| Build System | Vite | 7.3.0 |
| Backend Framework | Spring Boot | 3.x |
| Database Layer | Spring Data JPA | 3.x |
| Security | Spring Security | 6.x |
| Database | TiDB Cloud (MySQL-compatible) | 8.x |
| Authentication | JWT | - |

### Development Tools

| Tool | Version | What It's For |
|------|---------|---------------|
| Node.js | 20.19.0+ | Runs the frontend build tools |
| Java | 17+ | Powers the backend server |
| Maven | 3.9+ | Manages backend dependencies and builds |
| VS Code | Latest | Code editing |
| Git | Latest | Version control |

---

# 6. Detailed Design

## 6.1 User Module

This module handles everything related to user accounts—creating them, logging in, and managing profiles.

### 6.1.1 Available Endpoints

| Action | HTTP Method | URL | What It Does |
|--------|-------------|-----|--------------|
| Create Account | POST | /api/users/register | Signs up a new user |
| Log In | POST | /api/users/login | Validates credentials and issues a token |
| Get User Details | GET | /api/users/{id} | Retrieves user information |
| Update Profile | PUT | /api/users/{id} | Modifies user details |
| Delete Account | DELETE | /api/users/{id} | Removes a user from the system |
| Change Password | POST | /api/users/{id}/change-password | Updates the user's password |

### 6.1.2 How Registration and Login Work

**Creating an Account:**
```
┌────────────┐   ┌──────────────┐   ┌──────────────┐   ┌────────────┐
│ Get User   │──▶│ Check All    │──▶│ Encrypt the  │──▶│ Store in   │
│ Details    │   │ Fields Valid │   │ Password     │   │ Database   │
└────────────┘   └──────────────┘   └──────────────┘   └─────┬──────┘
                                                              │
                                                              ▼
┌────────────┐   ┌──────────────┐                    ┌────────────────┐
│ Send Back  │◀──│ Create       │◀───────────────────│ Build User     │
│ Response   │   │ Login Token  │                    │ Record         │
└────────────┘   └──────────────┘                    └────────────────┘

**Logging In:**
┌────────────┐   ┌──────────────┐   ┌──────────────┐   ┌────────────┐
│ Receive    │──▶│ Look Up User │──▶│ Verify the   │──▶│ Generate   │
│ Email/Pass │   │ by Email     │   │ Password     │   │ Login Token│
└────────────┘   └──────────────┘   └──────────────┘   └─────┬──────┘
                                                              │
                                                              ▼
                                                     ┌────────────────┐
                                                     │ Return Success │
                                                     │ with Token     │
                                                     └────────────────┘
```

### 6.1.3 Component Structure

```
┌─────────────────────────────────────────────────────────────────┐
│                         UserController                           │
├─────────────────────────────────────────────────────────────────┤
│ Depends on: UserService                                          │
├─────────────────────────────────────────────────────────────────┤
│ • register() - Creates new accounts                              │
│ • login() - Authenticates users                                  │
│ • getUserById() - Fetches user data                             │
│ • updateUser() - Modifies profiles                              │
│ • deleteUser() - Removes accounts                               │
│ • changePassword() - Updates credentials                         │
└─────────────────────────────────────────────────────────────────┘
                               │
                               │ calls
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                          UserService                             │
├─────────────────────────────────────────────────────────────────┤
│ Depends on: UserRepository, PasswordEncoder, JwtUtil            │
├─────────────────────────────────────────────────────────────────┤
│ • Contains all the business logic for user operations           │
└─────────────────────────────────────────────────────────────────┘
                               │
                               │ talks to
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                        UserRepository                            │
│                   (extends JpaRepository)                        │
├─────────────────────────────────────────────────────────────────┤
│ • findByEmail() - Looks up users by email                       │
│ • existsByEmail() - Checks if an email is already registered    │
└─────────────────────────────────────────────────────────────────┘
```

### 6.1.4 How Security Works

**Password Protection using BCrypt:**

When a user sets their password, we never store it directly. Instead:
1. We generate a random salt (think of it as a unique scrambler)
2. We combine the password with this salt
3. We run it through the BCrypt algorithm 10 times
4. The result is a 60-character hash that we store

When they log in later, we use the same salt to hash what they typed and compare it to what we stored. This way, even if someone got our database, they couldn't figure out the actual passwords.

**Token-Based Sessions using JWT:**

Instead of keeping track of sessions on the server, we give users a signed token:
```
Token Structure:
• Header: Identifies this as a JWT using HS256 signing
• Payload: Contains user email, ID, role, and expiration time
• Signature: Ensures the token hasn't been tampered with
```

Tokens are valid for 24 hours, after which users need to log in again.

### 6.1.5 API Examples

**Signing Up:**
```json
POST /api/users/register
Content-Type: application/json

{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@company.com",
  "password": "mySecurePassword123"
}
```

**Successful Response:**
```json
HTTP/1.1 201 Created

{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "userId": 42,
  "email": "john.doe@company.com",
  "firstName": "John",
  "lastName": "Doe",
  "role": "USER"
}
```

---

## 6.2 Room Module

This module manages the meeting room catalog—listing rooms, searching for availability, and administrative functions.

### 6.2.1 Available Endpoints

| Action | HTTP Method | URL | Who Can Use It |
|--------|-------------|-----|----------------|
| List All Rooms | GET | /api/rooms | Everyone |
| Find Available Rooms | GET | /api/rooms/search | Everyone |
| Get Room Details | GET | /api/rooms/{id} | Everyone |
| Add New Room | POST | /api/rooms | Admins Only |
| Update Room | PUT | /api/rooms/{id} | Admins Only |
| Remove Room | DELETE | /api/rooms/{id} | Admins Only |

### 6.2.2 Component Structure

```
┌─────────────────────────────────────────────────────────────────┐
│                         RoomController                          │
├─────────────────────────────────────────────────────────────────┤
│ • getAllRooms() - Returns the complete room catalog             │
│ • searchRooms() - Finds rooms matching specific criteria        │
│ • getRoomById() - Gets details for one specific room            │
│ • createRoom() - Adds a room to the system (admin)              │
│ • updateRoom() - Modifies room details (admin)                  │
│ • deleteRoom() - Removes a room (admin)                         │
└─────────────────────────────────────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                          RoomService                            │
├─────────────────────────────────────────────────────────────────┤
│ • Handles the logic for room queries and modifications          │
│ • Coordinates with BookingRepository for availability checks    │
└─────────────────────────────────────────────────────────────────┘
```

### 6.2.3 Finding Available Rooms

When someone searches for a room, here's what happens behind the scenes:

```
Given: date, startTime, endTime, minimumCapacity

Steps:
1. Convert the date and times into full timestamps
2. Find all rooms that can hold at least the requested number of people
3. For each room, check if any confirmed bookings overlap with the requested time
4. A room is available only if it has zero overlapping bookings
5. Return the list of available rooms

The SQL logic essentially says:
"Find rooms big enough where there's no existing booking that 
starts before we want to end AND ends after we want to start"
```

---

## 6.3 Booking Module

This is the heart of the system—where users make reservations and admins manage the approval workflow.

### 6.3.1 Available Endpoints

| Action | HTTP Method | URL | Who Can Use It |
|--------|-------------|-----|----------------|
| Make a Booking | POST | /api/bookings | Any Logged-in User |
| My Reservations | GET | /api/bookings/user/{id} | The User Themselves |
| Cancel Booking | POST | /api/bookings/{id}/cancel | The User Who Made It |
| See Pending Requests | GET | /api/bookings/pending | Admins Only |
| View All Bookings | GET | /api/bookings/admin/all | Admins Only |
| Approve Request | POST | /api/bookings/{id}/approve | Admins Only |
| Decline Request | POST | /api/bookings/{id}/reject | Admins Only |
| Calendar Data | GET | /api/bookings/range | Any Logged-in User |

### 6.3.2 Booking Lifecycle

A booking moves through different states during its lifetime:

```
                     ┌──────────────┐
                     │   PENDING    │
                     │ (Just Made)  │
                     └──────┬───────┘
                            │
            ┌───────────────┼───────────────┐
            │               │               │
            ▼               │               ▼
     ┌──────────────┐       │       ┌──────────────┐
     │  CONFIRMED   │       │       │   REJECTED   │
     │ (Greenlight) │       │       │  (Declined)  │
     └──────┬───────┘       │       └──────────────┘
            │               │
            │               ▼
            │       ┌──────────────┐
            └──────▶│  CANCELLED   │
                    │  (Called Off)│
                    └──────────────┘

Possible Transitions:
• PENDING → CONFIRMED: Admin approves the request
• PENDING → REJECTED: Admin declines the request
• PENDING → CANCELLED: User changes their mind
• CONFIRMED → CANCELLED: Plans changed after approval
```

### 6.3.3 Preventing Double-Bookings

Before any booking is confirmed, we run a conflict check:

```
For a proposed booking (roomId, startTime, endTime):

1. Get all CONFIRMED bookings for that room
2. For each existing booking:
   - Check if new start is before existing end
   - AND if new end is after existing start
   - If both true → There's a conflict!
3. If any conflict found → Reject the booking
4. If no conflicts → Safe to proceed
```

---

# 7. Database Design

## 7.1 Design Philosophy

We built the database following Third Normal Form (3NF) principles to keep data organized and minimize redundancy. The system stores three main types of information:

1. **Users** - Everyone who has an account
2. **Meeting Rooms** - All available spaces for meetings
3. **Bookings** - The reservations connecting users to rooms

Key design decisions:
- Each table has an auto-generated numeric ID as its primary key
- Foreign keys link bookings to their associated users and rooms
- Strategic indexes speed up common queries
- We don't use cascade deletes—this preserves booking history even if a user leaves

## 7.2 How the Data Connects

```
┌─────────────────┐         ┌─────────────────┐
│     USERS       │         │  MEETING_ROOMS  │
├─────────────────┤         ├─────────────────┤
│ id (primary)    │         │ id (primary)    │
│ first_name      │         │ name            │
│ last_name       │         │ capacity        │
│ email (unique)  │         │ amenities       │
│ password        │         │ description     │
│ role            │         │ status          │
└────────┬────────┘         │ image_url       │
         │                  └────────┬────────┘
         │ one                       │ one
         │                           │
         │ makes                     │ hosts
         │                           │
         │ many                      │ many
         │                           │
┌────────┴───────────────────────────┴────────┐
│                  BOOKINGS                    │
├──────────────────────────────────────────────┤
│ id (primary)                                 │
│ user_id → links to USERS                     │
│ room_id → links to MEETING_ROOMS             │
│ start_time                                   │
│ end_time                                     │
│ purpose                                      │
│ status (PENDING/CONFIRMED/REJECTED/CANCELLED)│
│ created_at                                   │
└──────────────────────────────────────────────┘

Relationships Explained:
• One user can make many bookings
• One room can have many bookings
• Each booking belongs to exactly one user and one room
```

## 7.3 Table Definitions

### Users Table

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

### Meeting Rooms Table

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

### Bookings Table

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

## 7.4 Security Measures

### How We Protect Credentials

| Protection Layer | How We Do It |
|------------------|--------------|
| Password Storage | BCrypt hashing with salt (60 characters, cost factor 10) |
| Session Tokens | JWT signed with HS256 algorithm |
| Token Lifetime | 24 hours before requiring re-authentication |
| Secret Management | JWT secret stored in environment variables, never in code |

### Defending Against Common Attacks

| Threat | Our Defense |
|--------|-------------|
| SQL Injection | All queries go through JPA parameterized statements |
| Cross-Site Scripting | Input validation and sanitization on the frontend |
| Unauthorized API Access | CORS configuration limits which domains can call our API |
| Man-in-the-Middle | HTTPS recommended for all production deployments |

### Permission Levels

| Role | What They Can Do |
|------|------------------|
| USER | View rooms, create and cancel their own bookings, update their profile |
| ADMIN | Everything users can do, plus: approve/reject any booking, add/edit/remove rooms |

## 7.5 Field Reference

### Users Table Fields

| Column | Type | Details | Purpose |
|--------|------|---------|---------|
| id | BIGINT | Primary key, auto-increment | Unique identifier |
| first_name | VARCHAR(50) | Required | User's given name |
| last_name | VARCHAR(50) | Required | User's family name |
| email | VARCHAR(100) | Required, must be unique | Login credential |
| password | VARCHAR(255) | Required | BCrypt-hashed password |
| role | VARCHAR(20) | Defaults to 'USER' | Either 'USER' or 'ADMIN' |
| created_at | TIMESTAMP | Auto-generated | When account was created |

### Meeting Rooms Table Fields

| Column | Type | Details | Purpose |
|--------|------|---------|---------|
| id | BIGINT | Primary key, auto-increment | Unique identifier |
| name | VARCHAR(100) | Required | Display name like "Conference Room A" |
| capacity | INT | Required | Maximum number of people |
| amenities | TEXT | Optional | Features like "Projector, Whiteboard" |
| description | TEXT | Optional | Additional room details |
| status | VARCHAR(20) | Defaults to 'AVAILABLE' | AVAILABLE or MAINTENANCE |
| image_url | VARCHAR(500) | Optional | Path to room photo |

### Bookings Table Fields

| Column | Type | Details | Purpose |
|--------|------|---------|---------|
| id | BIGINT | Primary key, auto-increment | Unique identifier |
| user_id | BIGINT | Foreign key to users | Who made the reservation |
| room_id | BIGINT | Foreign key to meeting_rooms | Which room was booked |
| start_time | DATETIME | Required | When the meeting begins |
| end_time | DATETIME | Required | When the meeting ends |
| purpose | VARCHAR(500) | Optional | What the meeting is about |
| status | VARCHAR(20) | Defaults to 'PENDING' | Current booking state |
| created_at | TIMESTAMP | Auto-generated | When booking was submitted |

**Status Options:**
- **PENDING** - Awaiting admin review
- **CONFIRMED** - Approved and on the calendar
- **REJECTED** - Admin declined the request
- **CANCELLED** - User or admin cancelled it

---

# 8. System Reliability Design

## 8.1 Error Handling Strategy

When things go wrong, we return clear, actionable error messages:

| Situation | Response | Message |
|-----------|----------|---------|
| Invalid form data | 400 Bad Request | Specific field errors |
| Wrong login credentials | 401 Unauthorized | "Invalid credentials" |
| Trying to access someone else's data | 403 Forbidden | "Access denied" |
| Looking for something that doesn't exist | 404 Not Found | "Resource not found" |
| Trying to book an already-taken slot | 400 Bad Request | "Time slot unavailable" |
| Something unexpected broke | 500 Server Error | Generic message (details logged) |

## 8.2 Logging Approach

We log different things at different levels:

| Level | What Gets Logged |
|-------|------------------|
| ERROR | Exceptions, failed operations—anything that needs immediate attention |
| WARN | Unusual conditions that might indicate problems |
| INFO | Normal but significant events (successful logins, new bookings) |
| DEBUG | Detailed flow information for troubleshooting |

## 8.3 Data Protection

| Backup Type | How Often | How Long We Keep It |
|-------------|-----------|---------------------|
| Full Database Snapshot | Daily | 30 days |
| Transaction Logs | Hourly | 7 days |

## 8.4 Performance Optimizations

| What We Did | How It Helps |
|-------------|--------------|
| Database Indexes | Fast lookups on commonly-searched columns |
| Connection Pooling | HikariCP manages 10 reusable database connections |
| Lazy Loading | Only fetch related data when actually needed |
| Client-Side Caching | User session stored in browser's localStorage |

---

# 9. Appendix

## 9.1 Complete API Reference

| # | Endpoint | Method | Requires Login | Description |
|---|----------|--------|----------------|-------------|
| 1 | /api/users/register | POST | No | Create new account |
| 2 | /api/users/login | POST | No | Authenticate user |
| 3 | /api/users/{id} | GET | Yes | Get user details |
| 4 | /api/users/{id} | PUT | Yes | Update profile |
| 5 | /api/users/{id} | DELETE | Yes | Delete account |
| 6 | /api/users/{id}/change-password | POST | Yes | Change password |
| 7 | /api/rooms | GET | Yes | List all rooms |
| 8 | /api/rooms/search | GET | Yes | Search available rooms |
| 9 | /api/rooms | POST | Admin | Add new room |
| 10 | /api/rooms/{id} | PUT | Admin | Update room |
| 11 | /api/rooms/{id} | DELETE | Admin | Remove room |
| 12 | /api/bookings | POST | Yes | Create booking |
| 13 | /api/bookings/user/{id} | GET | Yes | User's bookings |
| 14 | /api/bookings/{id}/cancel | POST | Yes | Cancel booking |
| 15 | /api/bookings/pending | GET | Admin | Pending requests |
| 16 | /api/bookings/admin/all | GET | Admin | All bookings |
| 17 | /api/bookings/{id}/approve | POST | Admin | Approve request |
| 18 | /api/bookings/{id}/reject | POST | Admin | Reject request |
| 19 | /api/bookings/range | GET | Yes | Calendar data |

## 9.2 Configuration Settings

```properties
# Database Connection
spring.datasource.url=jdbc:mysql://gateway01.xxx.tidbcloud.com:4000/meeting_room_db
spring.datasource.username=${DB_USERNAME}
spring.datasource.password=${DB_PASSWORD}

# JPA Settings
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# JWT Configuration
jwt.secret=${JWT_SECRET}
jwt.expiration=86400000

# Server Port
server.port=8080
```

## 9.3 Getting the Project Running

**Starting the Backend:**
```bash
cd "Meeting room Management system"
mvn spring-boot:run
```

**Starting the Frontend:**
```bash
cd Meeting_Room_Frontend
npm install
npm run dev
```

**Where to Access:**
- **Frontend Application:** http://localhost:5173
- **Backend API:** http://localhost:8080/api

---

**— End of Document —**
