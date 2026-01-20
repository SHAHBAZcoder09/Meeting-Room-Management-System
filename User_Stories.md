# User Stories
## Meeting Room Management System

---

## Backend Stories

| Story Number | Story Name | Story Description | Workload (day) | Owner |
|--------------|------------|-------------------|----------------|-------|
| BE-001 | System Admin Initialization | As the system, I aim to achieve automatic admin account creation through the database initialization function. | 0.5 | Wang Pei |
| BE-002 | User Registration API | As the backend developer, I aim to achieve new user account creation through the POST /api/users/register endpoint. | 1 | Wang Pei |
| BE-003 | User Login API | As the backend developer, I aim to achieve user authentication through the POST /api/users/login endpoint with JWT token generation. | 1 | Wang Pei |
| BE-004 | Get User By ID API | As the backend developer, I aim to achieve user profile retrieval through the GET /api/users/{id} endpoint. | 0.5 | Wang Pei |
| BE-005 | Get All Users API | As the backend developer, I aim to achieve user listing through the GET /api/users endpoint. | 0.5 | Wang Pei |
| BE-006 | Update User API | As the backend developer, I aim to achieve user profile updates through the PUT /api/users/{id} endpoint. | 0.5 | Wang Pei |
| BE-007 | Delete User API | As the backend developer, I aim to achieve user account removal through the DELETE /api/users/{id} endpoint. | 0.5 | Wang Pei |
| BE-008 | Change Password API | As the backend developer, I aim to achieve password updates through the POST /api/users/{id}/change-password endpoint. | 0.5 | Wang Pei |
| BE-009 | Health Check API | As the backend developer, I aim to achieve system health monitoring through the GET /api/users/health/check endpoint. | 0.25 | Wang Pei |
| BE-010 | Get All Rooms API | As the backend developer, I aim to achieve room listing through the GET /api/rooms endpoint. | 0.5 | Wang Pei |
| BE-011 | Search Rooms API | As the backend developer, I aim to achieve room filtering by date, time, and capacity through the GET /api/rooms/search endpoint. | 1 | Wang Pei |
| BE-012 | Create Room API | As the backend developer, I aim to achieve new room creation through the POST /api/rooms endpoint. | 0.5 | Wang Pei |
| BE-013 | Get Room By ID API | As the backend developer, I aim to achieve single room retrieval through the GET /api/rooms/{id} endpoint. | 0.25 | Wang Pei |
| BE-014 | Update Room API | As the backend developer, I aim to achieve room information updates through the PUT /api/rooms/{id} endpoint. | 0.5 | Wang Pei |
| BE-015 | Delete Room API | As the backend developer, I aim to achieve room removal through the DELETE /api/rooms/{id} endpoint. | 0.5 | Wang Pei |
| BE-016 | Create Booking API | As the backend developer, I aim to achieve new booking creation with conflict validation through the POST /api/bookings endpoint. | 1.5 | Wang Pei |
| BE-017 | Get User Bookings API | As the backend developer, I aim to achieve user-specific booking retrieval through the GET /api/bookings/user/{userId} endpoint. | 0.5 | Wang Pei |
| BE-018 | Cancel Booking API | As the backend developer, I aim to achieve booking cancellation through the POST /api/bookings/{id}/cancel endpoint. | 0.5 | Wang Pei |
| BE-019 | Get Pending Bookings API | As the backend developer, I aim to achieve pending bookings listing through the GET /api/bookings/pending endpoint. | 0.5 | Wang Pei |
| BE-020 | Get All Bookings API | As the backend developer, I aim to achieve complete bookings listing through the GET /api/bookings/admin/all endpoint. | 0.5 | Wang Pei |
| BE-021 | Approve Booking API | As the backend developer, I aim to achieve booking approval status update through the POST /api/bookings/{id}/approve endpoint. | 0.5 | Wang Pei |
| BE-022 | Reject Booking API | As the backend developer, I aim to achieve booking rejection status update through the POST /api/bookings/{id}/reject endpoint. | 0.5 | Wang Pei |
| BE-023 | Get Bookings By Range API | As the backend developer, I aim to achieve date-range booking retrieval through the GET /api/bookings/range endpoint. | 0.5 | Wang Pei |
| BE-024 | Dashboard Stats API | As the backend developer, I aim to achieve dashboard statistics aggregation through the GET /api/stats endpoint. | 1 | Wang Pei |
| BE-025 | JWT Token Generation | As the backend developer, I aim to achieve secure authentication through the JWT token generation service. | 1 | Wang Pei |
| BE-026 | JWT Token Validation | As the backend developer, I aim to achieve API protection through the JWT token validation middleware. | 1 | Wang Pei |
| BE-027 | Password Encryption | As the backend developer, I aim to achieve secure password storage through the BCrypt encryption service. | 0.5 | Wang Pei |
| BE-028 | Booking Conflict Detection | As the backend developer, I aim to achieve double-booking prevention through the time slot conflict detection service. | 1 | Wang Pei |
| BE-029 | Database Entity Mapping | As the backend developer, I aim to achieve data persistence through the JPA/Hibernate entity-table mapping. | 1 | Wang Pei |
| BE-030 | CORS Configuration | As the backend developer, I aim to achieve cross-origin requests support through the CORS configuration. | 0.25 | Wang Pei |

---

## Frontend Stories

| Story Number | Story Name | Story Description | Workload (day) | Owner |
|--------------|------------|-------------------|----------------|-------|
| FE-001 | Login Page UI | As the frontend developer, I aim to achieve user authentication interface through the LoginView component. | 1 | Wang Pei |
| FE-002 | Login Form Validation | As the user, I aim to achieve input error prevention through the login form validation function. | 0.5 | Wang Pei |
| FE-003 | Login API Integration | As the frontend developer, I aim to achieve authentication through the login API service integration. | 0.5 | Wang Pei |
| FE-004 | Registration Page UI | As the frontend developer, I aim to achieve new user registration interface through the RegisterView component. | 1 | Wang Pei |
| FE-005 | Registration Form Validation | As the user, I aim to achieve input error prevention through the registration form validation function. | 0.5 | Wang Pei |
| FE-006 | Registration API Integration | As the frontend developer, I aim to achieve account creation through the registration API service integration. | 0.5 | Wang Pei |
| FE-007 | Dashboard Page UI | As the frontend developer, I aim to achieve system overview display through the DashboardView component. | 1.5 | Wang Pei |
| FE-008 | Dashboard Stats Display | As the user, I aim to achieve quick system insights through the dashboard statistics cards function. | 1 | Wang Pei |
| FE-009 | Dashboard API Integration | As the frontend developer, I aim to achieve live statistics through the dashboard API service integration. | 0.5 | Wang Pei |
| FE-010 | Room Listing Page UI | As the frontend developer, I aim to achieve room browsing through the RoomsView component. | 1.5 | Wang Pei |
| FE-011 | Room Cards Display | As the user, I aim to achieve visual room information through the room cards grid layout function. | 1 | Wang Pei |
| FE-012 | Room Search Filters | As the user, I aim to achieve room filtering through the date, time, and capacity filter function. | 1 | Wang Pei |
| FE-013 | Room API Integration | As the frontend developer, I aim to achieve room data display through the rooms API service integration. | 0.5 | Wang Pei |
| FE-014 | Booking Modal UI | As the frontend developer, I aim to achieve booking creation through the BookingModal component. | 1 | Wang Pei |
| FE-015 | Booking Form Validation | As the user, I aim to achieve valid booking submission through the booking form validation function. | 0.5 | Wang Pei |
| FE-016 | Booking API Integration | As the frontend developer, I aim to achieve reservation creation through the booking API service integration. | 0.5 | Wang Pei |
| FE-017 | My Bookings Page UI | As the frontend developer, I aim to achieve booking history display through the MyBookingsView component. | 1 | Wang Pei |
| FE-018 | Booking Status Badges | As the user, I aim to achieve booking status visibility through the color-coded status badge function. | 0.5 | Wang Pei |
| FE-019 | Cancel Booking Function | As the user, I aim to achieve booking cancellation through the cancel booking button function. | 0.5 | Wang Pei |
| FE-020 | Admin Panel Page UI | As the frontend developer, I aim to achieve admin management through the AdminView component. | 1.5 | Wang Pei |
| FE-021 | Pending Bookings List | As the admin, I aim to achieve booking request review through the pending bookings list function. | 1 | Wang Pei |
| FE-022 | Approve/Reject Actions | As the admin, I aim to achieve booking decision through the approve and reject button function. | 0.5 | Wang Pei |
| FE-023 | Admin API Integration | As the frontend developer, I aim to achieve admin operations through the admin API service integration. | 0.5 | Wang Pei |
| FE-024 | Navigation Bar | As the frontend developer, I aim to achieve page navigation through the NavBar component. | 1 | Wang Pei |
| FE-025 | User Menu Dropdown | As the user, I aim to achieve profile and logout access through the user menu dropdown function. | 0.5 | Wang Pei |
| FE-026 | Route Guards | As the frontend developer, I aim to achieve page protection through the Vue Router navigation guards. | 0.5 | Wang Pei |
| FE-027 | Language Switcher UI | As the frontend developer, I aim to achieve language selection through the LanguageSwitcher component. | 0.5 | Wang Pei |
| FE-028 | i18n Integration | As the user, I aim to achieve multi-language support through the Vue i18n translation function. | 1 | Wang Pei |
| FE-029 | English Translations | As the frontend developer, I aim to achieve English UI through the en.json translation file. | 0.5 | Wang Pei |
| FE-030 | Chinese Translations | As the frontend developer, I aim to achieve Chinese UI through the zh.json translation file. | 0.5 | Wang Pei |
| FE-031 | Token Storage | As the frontend developer, I aim to achieve persistent login through the localStorage token storage function. | 0.25 | Wang Pei |
| FE-032 | API Interceptor | As the frontend developer, I aim to achieve automatic token injection through the Axios request interceptor. | 0.5 | Wang Pei |
| FE-033 | Error Handling | As the user, I aim to achieve friendly error messages through the global error handler function. | 0.5 | Wang Pei |
| FE-034 | Loading States | As the user, I aim to achieve visual feedback through the loading spinner function. | 0.5 | Wang Pei |
| FE-035 | Responsive Layout | As the user, I aim to achieve mobile-friendly access through the responsive CSS media queries. | 1 | Wang Pei |
| FE-036 | Home Page UI | As the frontend developer, I aim to achieve landing page display through the HomeView component. | 1 | Wang Pei |
| FE-037 | Hero Section | As the user, I aim to achieve attractive first impression through the hero section with CTA buttons. | 0.5 | Wang Pei |
| FE-038 | Features Section | As the user, I aim to achieve system understanding through the features showcase section. | 0.5 | Wang Pei |
| FE-039 | Room Image Display | As the user, I aim to achieve visual room representation through the room image display function. | 0.5 | Wang Pei |
| FE-040 | Date Picker Component | As the user, I aim to achieve easy date selection through the date picker input component. | 0.5 | Wang Pei |

---

## Summary

| Category | Story Count | Total Workload (days) |
|----------|-------------|----------------------|
| Backend Stories | 30 | 18.75 |
| Frontend Stories | 40 | 27.25 |
| **Total** | **70** | **46.00** |

---

## Story Description Format

> **Template:** As the `[role]`, I aim to achieve `[goal]` through the `[function/feature]`.

| Role Examples | Description |
|---------------|-------------|
| user | End user of the application |
| admin | System administrator |
| frontend developer | Developer working on Vue.js UI |
| backend developer | Developer working on Spring Boot API |
| system | Automated system process |

---

**Document Version:** 1.0  
**Last Updated:** January 18, 2026  
**Author:** Ayush Maheshwari
