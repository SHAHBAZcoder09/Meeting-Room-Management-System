# Database Schema for Meeting Room Management System

Based on the JPA Entities, here is the SQL schema for your database (MySQL compatible).

## Users Table
```sql
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    active BOOLEAN DEFAULT TRUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

## Meeting Rooms Table
```sql
CREATE TABLE IF NOT EXISTS meeting_rooms (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    capacity INT NOT NULL,
    amenities VARCHAR(255),
    description TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'AVAILABLE',
    image_url VARCHAR(255)
);
```

## Bookings Table
```sql
CREATE TABLE IF NOT EXISTS bookings (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    room_id BIGINT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'CONFIRMED',
    purpose VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES meeting_rooms(id) ON DELETE CASCADE
);
```

## Initial Data (Optional)
If you want to seed some initial admins or rooms:

```sql
INSERT INTO meeting_rooms (name, capacity, amenities, description, status) VALUES 
('Nebula Conference Hall', 20, 'Projector,Video Conf,Whiteboard', 'Large conference room', 'AVAILABLE'),
('Starlight Huddle', 6, 'TV Screen,Whiteboard', 'Small huddle room', 'AVAILABLE');

-- Note: Password should be BCrypt encoded. 'password123' -> $2a$10$D/.. (example hash)
-- INSERT INTO users (email, password, first_name, last_name, role) VALUES ...
```
