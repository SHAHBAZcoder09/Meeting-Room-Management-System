# Requirement Function Point
## Meeting Room Management System

---

## Requirement Function Point Matrix

| Affected System | Affected Module | Modification Point | Modification Content |
|-----------------|-----------------|-------------------|----------------------|
| Meeting Room Management System | User Authentication | Login Functionality | Implement user login with email/password validation, JWT token generation, and session management |
| Meeting Room Management System | User Authentication | Registration | New user registration with email uniqueness validation, password encryption, and role assignment |
| Meeting Room Management System | User Authentication | Password Management | Change password functionality with current password verification |
| Meeting Room Management System | User Management | User Profile | View and update user profile information (firstName, lastName, email) |
| Meeting Room Management System | User Management | User Listing | Admin ability to view all registered users |
| Meeting Room Management System | User Management | User Deletion | Admin ability to deactivate/delete user accounts |
| Meeting Room Management System | Room Management | Room Listing | Display all meeting rooms with details (name, capacity, amenities, status) |
| Meeting Room Management System | Room Management | Room Search | Filter rooms by date, time slot, and capacity requirements |
| Meeting Room Management System | Room Management | Room Creation | Admin creates new meeting rooms with all attributes |
| Meeting Room Management System | Room Management | Room Update | Admin modifies room details (capacity, amenities, status) |
| Meeting Room Management System | Room Management | Room Deletion | Admin removes rooms from the system |
| Meeting Room Management System | Booking Management | Create Booking | User creates room booking with time slot and purpose |
| Meeting Room Management System | Booking Management | View Bookings | User views their booking history and upcoming bookings |
| Meeting Room Management System | Booking Management | Cancel Booking | User cancels their pending or confirmed bookings |
| Meeting Room Management System | Booking Management | Booking Conflict Check | System prevents double-booking of rooms for overlapping time slots |
| Meeting Room Management System | Admin Approval | Pending Bookings | Admin views all pending booking requests |
| Meeting Room Management System | Admin Approval | Approve Booking | Admin approves pending booking, changes status to CONFIRMED |
| Meeting Room Management System | Admin Approval | Reject Booking | Admin rejects pending booking, changes status to REJECTED |
| Meeting Room Management System | Dashboard | Statistics Display | Show total rooms, active bookings, pending bookings, available rooms |
| Meeting Room Management System | Dashboard | Popular Room | Display most frequently booked meeting room |
| Meeting Room Management System | UI/UX | Language Switcher | Toggle between English and Chinese language |
| Meeting Room Management System | UI/UX | Responsive Design | Mobile, tablet, and desktop responsive layouts |
| Meeting Room Management System | Security | Token Authentication | JWT-based API authentication for protected endpoints |
| Meeting Room Management System | Security | Input Validation | Prevent SQL injection and XSS attacks |

---

## Scenario Description

| Scenario Type | Description |
|---------------|-------------|
| **Basic Flow** | Includes executable verification of basic business functions (e.g., accept/cancel), which is a prerequisite for the other three scenarios. |
| **Function Modification** | Covers test coverage of the main modification content, including boundary and abnormal scenarios for modification points. |
| **Business Rules** | Includes verification of relevant business rules and regression validation of business rules. |
| **Expansion Regression** | Includes regression of relevant business impacts not mentioned in the requirement assessment, and verification of user operation habits. |

---

## Detailed Scenario Breakdown

### 1. Basic Flow Scenarios

| Module | Scenario | Steps | Expected Result |
|--------|----------|-------|-----------------|
| Login | Valid Login | 1. Enter valid email 2. Enter correct password 3. Click Login | Redirect to dashboard with JWT token |
| Login | Invalid Login | 1. Enter invalid credentials 2. Click Login | Error message displayed, remain on login page |
| Registration | New User | 1. Enter unique email 2. Enter valid password 3. Enter name 4. Click Register | Account created, redirect to dashboard |
| Room Listing | View Rooms | 1. Navigate to Rooms page 2. View room cards | All available rooms displayed with details |
| Booking | Create Booking | 1. Select room 2. Choose date/time 3. Enter purpose 4. Submit | Booking created with PENDING status |
| Booking | Cancel Booking | 1. View my bookings 2. Click Cancel on booking | Booking status changed to CANCELLED |
| Admin | Approve Booking | 1. View pending bookings 2. Click Approve | Booking status changed to CONFIRMED |
| Admin | Reject Booking | 1. View pending bookings 2. Click Reject | Booking status changed to REJECTED |

---

### 2. Function Modification Scenarios

| Module | Modification Point | Boundary Scenarios | Abnormal Scenarios |
|--------|-------------------|-------------------|-------------------|
| Login | Email Validation | Empty email, max length email | Invalid email format, special characters |
| Login | Password Validation | Min length (6 chars), max length | Empty password, spaces only |
| Registration | Email Uniqueness | New unique email | Existing email in database |
| Registration | Password Strength | Exactly 6 characters | Less than 6 characters |
| Room Search | Capacity Filter | Minimum (1), Maximum (100+) | Zero, negative numbers |
| Room Search | Date Selection | Today's date, future dates | Past dates |
| Room Search | Time Range | Valid range (start < end) | End time before start time |
| Booking | Time Conflict | Adjacent bookings (no overlap) | Overlapping time slots |
| Booking | Past Date | Current time | Past date/time |
| Admin | Room Deletion | Room with no bookings | Room with active bookings |

---

### 3. Business Rules Scenarios

| Business Rule | Verification Scenario | Regression Validation |
|---------------|----------------------|----------------------|
| User can only cancel their own bookings | User attempts to cancel another user's booking | Verify access control after code changes |
| Admin can approve/reject any booking | Admin processes booking from any user | Verify admin privileges after role changes |
| Rooms under MAINTENANCE cannot be booked | User attempts to book MAINTENANCE room | Verify status check after room updates |
| Email must be unique | Register with existing email | Verify uniqueness constraint after DB changes |
| Password must be encrypted | Check password storage in database | Verify encryption after security updates |
| JWT token required for protected APIs | Access API without token | Verify authentication after token logic changes |
| Booking status follows workflow | PENDING → CONFIRMED → COMPLETED | Verify status transitions after workflow changes |
| Only future bookings allowed | Attempt booking for past date | Verify date validation after timezone changes |

---

### 4. Expansion Regression Scenarios

| Impact Area | Regression Scenario | User Operation Habit Verification |
|-------------|--------------------|---------------------------------|
| Dashboard Statistics | After booking creation, stats should update | User expects real-time dashboard updates |
| Room Availability | After booking approval, room shows as occupied | User expects immediate availability reflection |
| My Bookings List | After cancellation, list should refresh | User expects immediate list update |
| Admin Panel | After approval, pending count decreases | Admin expects count accuracy |
| Language Switch | After toggle, all text should translate | User expects consistent language across pages |
| Session Expiry | After token expiry, redirect to login | User expects graceful session handling |
| Page Navigation | After login, remember last visited page | User expects navigation continuity |
| Form Data | After validation error, preserve input | User expects data persistence on error |
| Search Results | After filter change, results refresh | User expects responsive filtering |
| Notification | After booking status change, notify user | User expects status change feedback |

---

## Test Coverage Matrix

| Module | Basic Flow | Function Modification | Business Rules | Expansion Regression | Total |
|--------|------------|----------------------|----------------|---------------------|-------|
| User Authentication | 4 | 6 | 4 | 2 | 16 |
| User Management | 3 | 4 | 2 | 2 | 11 |
| Room Management | 5 | 6 | 3 | 3 | 17 |
| Booking Management | 4 | 8 | 5 | 4 | 21 |
| Admin Approval | 3 | 2 | 2 | 2 | 9 |
| Dashboard | 2 | 2 | 1 | 3 | 8 |
| UI/UX | 4 | 4 | 2 | 6 | 16 |
| Security | 2 | 4 | 4 | 2 | 12 |
| **Total** | **27** | **36** | **23** | **24** | **110** |

---

## Priority Classification

| Priority | Scenario Type | Count | Focus Area |
|----------|---------------|-------|------------|
| P0 - Critical | Basic Flow | 27 | Core functionality must work |
| P1 - High | Business Rules | 23 | Business logic correctness |
| P2 - Medium | Function Modification | 36 | Edge cases and boundaries |
| P3 - Low | Expansion Regression | 24 | User experience optimization |

---

**Document Version:** 1.0  
**Last Updated:** January 18, 2026  
**Author:** Ayush Maheshwari
