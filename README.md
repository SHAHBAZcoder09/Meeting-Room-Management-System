# Spring Boot Application - README

## Project Overview
This is a comprehensive Java Spring Boot application with JWT-based authentication, REST API endpoints, and MySQL database integration.

## Prerequisites
- Java 17 or higher
- Maven 3.6+
- MySQL 8.0+
- Git

## Database Setup

### 1. Create MySQL Database
```sql
CREATE DATABASE shortproject_db;
USE shortproject_db;
```

### 2. Configure Database Credentials
Update `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/shortproject_db
spring.datasource.username=root
spring.datasource.password=your_password
```

## Build and Run

### Build the Application
```bash
mvn clean install
```

### Run the Application
```bash
mvn spring-boot:run
```

The application will start on `http://localhost:8080`

## API Endpoints

### Health Check
- **GET** `/api/users/health/check` - Check application health

### Authentication
- **POST** `/api/users/register` - Register a new user
  ```json
  {
    "email": "user@example.com",
    "password": "password123",
    "firstName": "John",
    "lastName": "Doe"
  }
  ```

- **POST** `/api/users/login` - Login user
  ```json
  {
    "email": "user@example.com",
    "password": "password123"
  }
  ```

### User Management
- **GET** `/api/users` - Get all users
- **GET** `/api/users/{id}` - Get user by ID
- **PUT** `/api/users/{id}` - Update user
- **DELETE** `/api/users/{id}` - Delete user

## Project Structure
```
src/
├── main/
│   ├── java/com/shortproject/
│   │   ├── Application.java
│   │   ├── config/
│   │   │   ├── SecurityConfig.java
│   │   │   └── WebConfig.java
│   │   ├── controller/
│   │   │   └── UserController.java
│   │   ├── dto/
│   │   │   ├── AuthResponseDTO.java
│   │   │   ├── LoginDTO.java
│   │   │   └── UserRegistrationDTO.java
│   │   ├── exception/
│   │   │   ├── DuplicateResourceException.java
│   │   │   └── ResourceNotFoundException.java
│   │   ├── model/
│   │   │   └── User.java
│   │   ├── repository/
│   │   │   └── UserRepository.java
│   │   ├── security/
│   │   │   └── JwtTokenProvider.java
│   │   └── service/
│   │       └── UserService.java
│   └── resources/
│       ├── application.properties
│       └── application-test.properties
└── test/
    └── java/com/shortproject/
        └── ApplicationTest.java
```

## Technologies Used
- **Spring Boot 3.2.0** - Framework
- **Spring Data JPA** - ORM
- **Spring Security** - Authentication & Authorization
- **JWT (jjwt)** - Token-based authentication
- **MySQL** - Database
- **Lombok** - Boilerplate code reduction
- **Maven** - Build tool

## Configuration
Key properties are configured in `application.properties`:
- Server Port: 8080
- Database: MySQL
- JWT Expiration: 24 hours
- CORS: Enabled for all origins

## Testing
Run tests using:
```bash
mvn test
```

## Development Notes
1. The application uses JWT tokens for authentication
2. Passwords are encoded using BCrypt
3. All entities use Lombok for reduced boilerplate
4. CORS is configured for development (allow all origins)
5. Hibernate auto-generates database schema (update mode)

## Troubleshooting

### MySQL Connection Issues
- Ensure MySQL server is running
- Verify database credentials in application.properties
- Check database exists: `SHOW DATABASES;`

### Port Already in Use
- Change `server.port` in application.properties
- Or kill the process using port 8080

### Build Failures
- Clear Maven cache: `mvn clean`
- Rebuild: `mvn install`

## License
This project is created for educational purposes.

## Support
For issues or questions, contact the development team.
