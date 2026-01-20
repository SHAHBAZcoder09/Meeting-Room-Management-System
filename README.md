# N4Booking - Meeting Room Management System

A full-stack web application for streamlined conference room reservations, replacing traditional booking methods (emails, spreadsheets) with an intuitive online platform.

---

## 📋 Project Overview

| Property | Value |
|----------|-------|
| **Project Name** | N4Booking Meeting Room Management System |
| **Version** | 1.0.0 |
| **Author** | Ayush Maheshwari |
| **Last Updated** | January 20, 2026 |

---

## 🛠️ Technology Stack

| Layer | Technology | Version |
|-------|------------|---------|
| **Frontend** | Vue.js | 3.5.26 |
| **UI Components** | Vuetify | 3.11.6 |
| **Routing** | Vue Router | 4.6.4 |
| **i18n** | vue-i18n | 9.x |
| **Build Tool** | Vite | 7.3.0 |
| **Backend** | Spring Boot | 3.x |
| **Database Layer** | Spring Data JPA | 3.x |
| **Security** | Spring Security | 6.x |
| **Database** | MySQL / TiDB Cloud | 8.x |
| **Authentication** | JWT | - |

---

## 🎯 Core Features

### For Regular Users
- ✅ **Account Management** - Register, login, update profile, change password
- ✅ **Room Browsing** - View all meeting rooms with images, capacity, and amenities
- ✅ **Smart Search** - Filter rooms by date, time slot, and capacity requirements
- ✅ **Booking System** - Book rooms with date/time selection and purpose
- ✅ **My Bookings** - View, track, and cancel personal reservations
- ✅ **Calendar View** - Weekly overview of all bookings
- ✅ **Multi-Language** - Switch between English and Chinese

### For Administrators
- ✅ **Booking Approval** - Review, approve, or reject pending booking requests
- ✅ **Room Management** - Add, update, or remove meeting rooms
- ✅ **Dashboard Statistics** - View total rooms, active bookings, pending requests

---

## 📊 Database Design

```
┌─────────────────┐         ┌─────────────────┐
│     USERS       │         │  MEETING_ROOMS  │
├─────────────────┤         ├─────────────────┤
│ id (PK)         │         │ id (PK)         │
│ email (unique)  │         │ name            │
│ password        │         │ capacity        │
│ first_name      │         │ amenities       │
│ last_name       │         │ status          │
│ role            │         │ image_url       │
└────────┬────────┘         └────────┬────────┘
         │ 1:N                       │ 1:N
         └───────────┬───────────────┘
                     │
          ┌──────────┴──────────┐
          │      BOOKINGS       │
          ├─────────────────────┤
          │ id (PK)             │
          │ user_id (FK)        │
          │ room_id (FK)        │
          │ start_time          │
          │ end_time            │
          │ purpose             │
          │ status              │
          └─────────────────────┘
```

**Booking Status Flow:**
- `PENDING` → `CONFIRMED` (Admin approves)
- `PENDING` → `REJECTED` (Admin declines)
- `PENDING` / `CONFIRMED` → `CANCELLED` (User cancels)

---

## 📁 Project Structure

```
Meeting room Management system/
├── src/main/java/com/shortproject/
│   ├── controller/     # REST API endpoints
│   ├── service/        # Business logic
│   ├── repository/     # Database access (JPA)
│   ├── model/          # Entities (User, Room, Booking)
│   ├── dto/            # Data transfer objects
│   ├── security/       # JWT handling
│   └── config/         # Security, CORS, Web config
│
├── Meeting_Room_Frontend/src/
│   ├── views/          # Page components
│   ├── components/     # Reusable UI components
│   ├── i18n/           # Translations (EN/CN)
│   └── router/         # Vue Router config
│
└── Documentation/
    ├── Technical_Design_Document.md
    ├── Entity_Relationship_Diagram.md
    ├── Story_Tracking_Document.md
    ├── API_DOCUMENTATION.md
    └── ...
```

---

## 🚀 Getting Started

### Prerequisites
- Java 17+
- Maven 3.6+
- Node.js 20+
- MySQL 8.0+

### 1. Database Setup
```sql
CREATE DATABASE shortproject_db;
USE shortproject_db;
```

### 2. Configure Environment
Update `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/shortproject_db
spring.datasource.username=root
spring.datasource.password=your_password
```

### 3. Start Backend
```bash
cd "Meeting room Management system"
mvn clean install
mvn spring-boot:run
```
Backend runs on: `http://localhost:8080`

### 4. Start Frontend
```bash
cd Meeting_Room_Frontend
npm install
npm run dev
```
Frontend runs on: `http://localhost:5173`

---

## 🔗 API Endpoints

### Authentication
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/users/register` | Register new user |
| POST | `/api/users/login` | Login user |

### User Management
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/users/{id}` | Get user by ID |
| PUT | `/api/users/{id}` | Update user |
| DELETE | `/api/users/{id}` | Delete user |
| POST | `/api/users/{id}/change-password` | Change password |

### Room Management
| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| GET | `/api/rooms` | User | List all rooms |
| GET | `/api/rooms/search` | User | Search available rooms |
| POST | `/api/rooms` | Admin | Add new room |
| PUT | `/api/rooms/{id}` | Admin | Update room |
| DELETE | `/api/rooms/{id}` | Admin | Remove room |

### Booking Management
| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| POST | `/api/bookings` | User | Create booking |
| GET | `/api/bookings/user/{id}` | User | Get user's bookings |
| POST | `/api/bookings/{id}/cancel` | User | Cancel booking |
| GET | `/api/bookings/pending` | Admin | View pending requests |
| GET | `/api/bookings/admin/all` | Admin | View all bookings |
| POST | `/api/bookings/{id}/approve` | Admin | Approve booking |
| POST | `/api/bookings/{id}/reject` | Admin | Reject booking |

---

## 🔐 Security Features

| Feature | Implementation |
|---------|----------------|
| Password Encryption | BCrypt hashing (cost factor 10) |
| Session Management | JWT tokens (24-hour expiry) |
| SQL Injection Prevention | Parameterized JPA queries |
| XSS Prevention | Input validation & sanitization |
| Access Control | Role-based (USER / ADMIN) |

---

## 📈 Project Metrics

| Metric | Value |
|--------|-------|
| Total User Stories | 17 |
| Total Development Days | 20.5 |
| Completion Rate | 100% |
| Delayed Stories | 0 |

---

## 🧪 Testing

```bash
# Run backend tests
mvn test
```

---

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [Technical_Design_Document.md](./Technical_Design_Document.md) | Complete system design specification |
| [Entity_Relationship_Diagram.md](./Entity_Relationship_Diagram.md) | Database schema and relationships |
| [Story_Tracking_Document.md](./Story_Tracking_Document.md) | User stories and progress tracking |
| [API_DOCUMENTATION.md](./API_DOCUMENTATION.md) | Detailed API reference |

---

## 🐛 Troubleshooting

### MySQL Connection Issues
- Ensure MySQL server is running
- Verify credentials in `application.properties`
- Check database exists: `SHOW DATABASES;`

### Port Already in Use
- Change `server.port` in `application.properties`
- Or kill the process using port 8080

### Build Failures
```bash
mvn clean
mvn install
```

---

## 📄 License

This project is created for educational purposes.

---

## 👥 Support

For issues or questions, contact the development team.
