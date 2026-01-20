# Project Sharing and Setup Guide

This guide explains how to share this project, set it up on another machine, and manage the database.

## 1. Sharing the Project
When you zip this project to share with a friend:
*   **What is shared**: The source code (Java, Vue.js), configuration files, and build scripts.
*   **What is NOT shared**: The database *data* (users, bookings) is **NOT** inside the zip file.
    *   If using **H2** (default): Data is in memory and lost when the app stops.
    *   If using **MySQL**: Data is stored in your local MySQL server installation, not in the project folder.

## 2. Setting up on Friend's Machine (MySQL)
If your friend wants to run this with a real persistent MySQL database, they need to follow these steps:

### A. Install Prerequisites
1.  **Java JDK 17+**
2.  **Maven**
3.  **MySQL Server** (and a client like Workbench or DBeaver)

### B. Create Database
Run this SQL command in their MySQL client:
```sql
CREATE DATABASE shortproject_db;
```

### C. Configure Application
1.  Open `src/main/resources/application.properties`.
2.  **Comment out H2** settings:
    ```properties
    # spring.datasource.url=jdbc:h2:mem:testdb
    # spring.datasource.driverClassName=org.h2.Driver
    # ...
    # spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
    ```
3.  **Uncomment MySQL** settings and update password:
    ```properties
    spring.datasource.url=jdbc:mysql://localhost:3306/shortproject_db
    spring.datasource.username=root
    spring.datasource.password=YOUR_MYSQL_PASSWORD  <-- Update this!
    spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
    spring.jpa.database-platform=org.hibernate.dialect.MySQL8Dialect
    ```

### D. Run the App
Run `mvn spring-boot:run`. The tables will be automatically created (thanks to `ddl-auto=update`).

### E. Register User
Since the new database is empty:
1.  Go to `http://localhost:8080/register`.
2.  Create a new account.
3.  Login.

## 3. Getting the Code Back
When your friend sends the zip back to you:
1.  **Unzip** it.
2.  **Run** `mvn spring-boot:run`.
3.  **Your Data**:
    *   If you are using **MySQL**, your *local* data is still there safely in your MySQL server.
    *   You will **NOT** see your friend's data (because it stayed on their machine).
    *   If you want their data, they must export a `.sql` file (dump) from their database and send it to you to import.
