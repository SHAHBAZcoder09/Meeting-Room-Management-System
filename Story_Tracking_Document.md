# Story Tracking Document
## Meeting Room Management System

---

## Project Overview

| Property | Value |
|----------|-------|
| **Project Name** | Meeting Room Management System |
| **Document Type** | Story Tracking Sheet |
| **Version** | 1.0 |
| **Last Updated** | January 18, 2026 |
| **Author** | Ayush Maheshwari |

---

## Story Tracking Matrix

| Module | Story Name | Story ID | Workload (days) | Priority | Start Time | Completion Time | Delay Status | Primary Responsible | Secondary Responsible | Testing Responsible | Status |
|--------|-----------|----------|-----------------|----------|------------|-----------------|--------------|--------------------|-----------------------|---------------------|--------|
| User Management | System Admin Account | US-001 | 0.5 | 1 | 0.26 | 0.26 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. A system admin account (only one) during system initialization, used to manage secondary admins. |  |  |  |  |  |  |  |  |  |  |
|  | 2. If no data found in the user table at System Startup, insert system administrator, NOT GUI Solution. |  |  |  |  |  |  |  |  |  |  |
| User Management | User Login Interface | US-002 | 1 | 1 | 0.21 | 0.26 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As a client rep, I want the system to support user login (enter username/password, verify), with database. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As a client rep, I want a prompt when the password is incorrect. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As a client rep, I want the login button to change style when focused. |  |  |  |  |  |  |  |  |  |  |
|  | 4. As a client rep, I want a prompt when the password format is invalid. |  |  |  |  |  |  |  |  |  |  |
|  | 5. As a customer representative, I want the button to change when the mouse hovers over the registration button. Clicking "Register" will redirect to the registration page. |  |  |  |  |  |  |  |  |  |  |
|  | 6. As a customer representative, I would like to register by providing a username, password, and phone number. |  |  |  |  |  |  |  |  |  |  |
| User Management | User Registration Interface | US-003 | 2 | 1 | 0.28 | 0.28 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As a customer representative, I would like to see a prompt when the password entered during registration differs from the one I set. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As a customer representative, I would like to see error messages when passwords are entered incorrectly. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As a customer representative, I want to prevent duplicate username registration and display a message indicating the username already exists. |  |  |  |  |  |  |  |  |  |  |
| Room Management | Room Listing Page | RM-001 | 1.5 | 1 | 0.28 | 0.30 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As a user, I want to view all available meeting rooms in a grid layout with room images. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As a user, I want to see room details including name, capacity, and amenities. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As a user, I want to see the availability status of each room. |  |  |  |  |  |  |  |  |  |  |
| Room Management | Room Search Functionality | RM-002 | 1 | 2 | 0.30 | 0.31 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As a user, I want to search rooms by date, time slot, and capacity requirements. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As a user, I want the search results to show only available rooms for my selected time. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As a user, I want to clear filters and see all rooms again. |  |  |  |  |  |  |  |  |  |  |
| Room Management | Room CRUD Operations | RM-003 | 2 | 1 | 0.31 | 0.33 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As an admin, I want to create new meeting rooms with name, capacity, amenities, and description. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As an admin, I want to update existing room information. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As an admin, I want to delete rooms that are no longer in use. |  |  |  |  |  |  |  |  |  |  |
|  | 4. As an admin, I want to set room status (AVAILABLE/MAINTENANCE). |  |  |  |  |  |  |  |  |  |  |
| Booking Management | Create Booking | BK-001 | 2 | 1 | 0.33 | 0.35 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As a user, I want to book a meeting room by selecting date, start time, end time, and purpose. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As a user, I want to see a confirmation when my booking is submitted. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As a user, I want the system to prevent booking if the time slot conflicts with existing bookings. |  |  |  |  |  |  |  |  |  |  |
|  | 4. As a user, I want to receive an error if I try to book a past date/time. |  |  |  |  |  |  |  |  |  |  |
| Booking Management | View My Bookings | BK-002 | 1 | 2 | 0.35 | 0.36 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As a user, I want to view all my bookings with status (PENDING, CONFIRMED, CANCELLED, REJECTED). |  |  |  |  |  |  |  |  |  |  |
|  | 2. As a user, I want to see booking details including room name, date, time, and purpose. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As a user, I want to filter my bookings by status. |  |  |  |  |  |  |  |  |  |  |
| Booking Management | Cancel Booking | BK-003 | 0.5 | 2 | 0.36 | 0.36 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As a user, I want to cancel my pending or confirmed bookings. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As a user, I want a confirmation prompt before cancelling a booking. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As a user, I want the cancelled booking to show status CANCELLED in my bookings list. |  |  |  |  |  |  |  |  |  |  |
| Admin Approval | View Pending Bookings | AD-001 | 1 | 1 | 0.36 | 0.37 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As an admin, I want to view all pending booking requests. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As an admin, I want to see booking details including user, room, date, time, and purpose. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As an admin, I want to see the total count of pending bookings. |  |  |  |  |  |  |  |  |  |  |
| Admin Approval | Approve/Reject Booking | AD-002 | 1 | 1 | 0.37 | 0.38 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As an admin, I want to approve a pending booking, changing status to CONFIRMED. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As an admin, I want to reject a pending booking, changing status to REJECTED. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As an admin, I want to see a confirmation after approving or rejecting a booking. |  |  |  |  |  |  |  |  |  |  |
| Dashboard | Statistics Display | DB-001 | 1.5 | 2 | 0.38 | 0.39 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As a user, I want to see total rooms, active bookings, and pending bookings on the dashboard. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As a user, I want to see the number of available rooms currently. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As a user, I want to see the most popular meeting room. |  |  |  |  |  |  |  |  |  |  |
| UI/UX | Language Switcher | UX-001 | 1 | 3 | 0.39 | 0.40 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As a user, I want to switch between English and Chinese languages. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As a user, I want my language preference to persist after page refresh. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As a user, I want all UI elements to translate when I switch language. |  |  |  |  |  |  |  |  |  |  |
| UI/UX | Responsive Design | UX-002 | 2 | 2 | 0.40 | 0.42 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As a user, I want the application to display properly on mobile devices. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As a user, I want the application to adapt to tablet screen sizes. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As a user, I want responsive navigation that collapses on smaller screens. |  |  |  |  |  |  |  |  |  |  |
| Security | JWT Authentication | SC-001 | 1.5 | 1 | 0.21 | 0.23 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As a system, I want to generate JWT tokens upon successful login. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As a system, I want to validate JWT tokens for protected API endpoints. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As a system, I want to return 401 Unauthorized for invalid or missing tokens. |  |  |  |  |  |  |  |  |  |  |
| Security | Input Validation | SC-002 | 1 | 1 | 0.23 | 0.24 | No Delay | Wang Pei | Wang Pei | Wang Pei | CLOSED |
|  |  |  |  |  |  |  |  |  |  |  |  |
|  | 1. As a system, I want to sanitize all user inputs to prevent SQL injection. |  |  |  |  |  |  |  |  |  |  |
|  | 2. As a system, I want to escape special characters to prevent XSS attacks. |  |  |  |  |  |  |  |  |  |  |
|  | 3. As a system, I want to validate email format during registration. |  |  |  |  |  |  |  |  |  |  |

---

## Summary Statistics

| Metric | Value |
|--------|-------|
| **Total Stories** | 17 |
| **Total Workload** | 20.5 days |
| **Stories Completed** | 17 |
| **Stories In Progress** | 0 |
| **Stories Delayed** | 0 |
| **Completion Rate** | 100% |

---

## Module Breakdown

| Module | Story Count | Total Workload (days) | Status |
|--------|-------------|----------------------|--------|
| User Management | 3 | 3.5 | CLOSED |
| Room Management | 3 | 4.5 | CLOSED |
| Booking Management | 3 | 3.5 | CLOSED |
| Admin Approval | 2 | 2.0 | CLOSED |
| Dashboard | 1 | 1.5 | CLOSED |
| UI/UX | 2 | 3.0 | CLOSED |
| Security | 2 | 2.5 | CLOSED |

---

## Priority Distribution

| Priority | Count | Description |
|----------|-------|-------------|
| 1 (High) | 11 | Critical functionality |
| 2 (Medium) | 5 | Important features |
| 3 (Low) | 1 | Nice-to-have features |

---

## Status Legend

| Status | Color | Description |
|--------|-------|-------------|
| CLOSED | 🟢 Green | Story completed and verified |
| IN PROGRESS | 🟡 Yellow | Story currently being worked on |
| OPEN | ⚪ White | Story not yet started |
| BLOCKED | 🔴 Red | Story blocked by dependencies |

---

## Delay Status Legend

| Status | Description |
|--------|-------------|
| No Delay | Completed on or before scheduled time |
| Delayed | Completed after scheduled time |
| At Risk | May not complete on time |

---

**Document Version:** 1.0  
**Last Updated:** January 18, 2026  
**Author:** Ayush Maheshwari
