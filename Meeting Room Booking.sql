CREATE DATABASE `test`;

CREATE TABLE `bookings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `end_time` datetime(6) NOT NULL,
  `purpose` varchar(255) COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `start_time` datetime(6) NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `room_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */,
  KEY `FKn9817s563pei2or3wsemt3lvi` (`room_id`),
  KEY `FKeyog2oic85xg7hsu2je2lx3s6` (`user_id`),
  CONSTRAINT `FKeyog2oic85xg7hsu2je2lx3s6` FOREIGN KEY (`user_id`) REFERENCES `test`.`users` (`id`),
  CONSTRAINT `FKn9817s563pei2or3wsemt3lvi` FOREIGN KEY (`room_id`) REFERENCES `test`.`meeting_rooms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci AUTO_INCREMENT=120007;

INSERT INTO `bookings` VALUES
(1,'2026-01-15 00:29:54.944448','2026-03-20 11:00:00.000000','Test','2026-03-20 10:00:00.000000','CONFIRMED',1,1),
(2,'2026-01-15 01:02:02.658934','2026-01-15 03:00:00.000000','Test Booking','2026-01-15 02:00:00.000000','REJECTED',1,4),
(3,'2026-01-15 01:34:47.882551','2026-01-23 07:34:00.000000','Testing code room ','2026-01-23 02:34:00.000000','CANCELLED',2,3),
(4,'2026-01-15 01:36:33.007660','2026-01-16 12:50:00.000000','antkick bday celebration','2026-01-16 01:36:00.000000','CANCELLED',1,5),
(5,'2026-01-15 02:41:32.412286','2026-01-28 06:45:00.000000','Quarterly connect with team','2026-01-28 02:44:00.000000','CANCELLED',2,5),
(6,'2026-01-15 03:28:38.124500','2026-01-21 05:28:00.000000','Test Meeting','2026-01-21 03:30:00.000000','CONFIRMED',1,5),
(30007,'2026-01-16 05:17:36.330346','2026-01-17 07:17:00.000000','test','2026-01-17 06:17:00.000000','CANCELLED',2,5),
(60007,'2026-01-19 12:32:15.151201','2026-01-22 16:32:00.000000','meeting','2026-01-22 14:32:00.000000','CONFIRMED',2,30009),
(90007,'2026-01-20 16:20:42.085656','2026-01-21 10:20:00.000000','test001','2026-01-21 09:20:00.000000','CONFIRMED',2,3);

CREATE TABLE `meeting_rooms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `capacity` int(11) NOT NULL,
  `amenities` varchar(255) COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'AVAILABLE',
  `image_url` varchar(255) COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci AUTO_INCREMENT=90005;

INSERT INTO `meeting_rooms` VALUES
(1,'Nebula Conference Hall',20,'Projector,Video Conf,Whiteboard','Large conference room','AVAILABLE','https://www.wework.com/ideas/wp-content/uploads/sites/4/2021/08/20201008-199WaterSt-2_fb.jpg?fit=1200%2C675'),
(2,'Starlight Huddle',6,'TV Screen,Whiteboard','Small huddle room','AVAILABLE',NULL),
(60005,'test room 01',10,'',NULL,'AVAILABLE',NULL);

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */,
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci AUTO_INCREMENT=60009;

INSERT INTO `users` VALUES
(1,'snowman@google.com','$2a$10$1aXxa.fO5qDNa654SacjlOMEmIJkSSpzqsbiLWpwgTbI9x.MVJlxS','snow ','man','USER',1,'2026-01-14 18:32:43','2026-01-14 18:32:43'),
(2,'snowman@hcl.com','$2a$10$u4ugNllgdYfTk/PaWPtLKemH.gXDNdPojxQ7N0WXfUhSxKl2kE8TW','snow ','man','USER',1,'2026-01-14 18:33:15','2026-01-14 18:33:15'),
(3,'snowdon@gmail.com','$2a$10$isObqBO8x.XjY55wSveZyulFDIKGBlyYZI9bFvuJBRGQtddRgm1u6','Snow','Man','ADMIN',1,'2026-01-14 18:34:50','2026-01-14 19:29:23'),
(4,'test@example.com','$2a$10$cLhmu.opG2F4CQnVVGCX4u1g/17b5rWH.hRnmPnqyUz3s.U1F2V/2','Test','User','admin',1,'2026-01-14 19:17:58','2026-01-16 19:10:15'),
(5,'antkick@g.com','$2a$10$L2rz.to/pLs446hXKVJ4/.AbOeuXdLY7z4Ni/UqTeszUQOdPAWiEO','Ant','Kick','USER',1,'2026-01-14 20:05:49','2026-01-14 20:05:49'),
(6,'testuser@example.com','$2a$10$HjBvt1Rf4u2uCi4SPlZDFut0z4f/puXThtlsD2Z3xSRJlXx/cNgMS','Test','User','USER',1,'2026-01-14 21:08:44','2026-01-14 21:08:44'),
(7,'admin@n4.com','$2a$10$dlAaTy7Y3yn6DetVsH./0.ERUBX5QGOv8KvdauuSZkWp/9mrNbL5i','Super','Admin','ADMIN',1,'2026-01-14 21:14:05','2026-01-14 21:14:05'),
(8,'test@n4.com','$2a$10$oRngT/LCTyYIudAwro5uFuG31SaAwSw7tgBIZ36gzUq9mb0QYpxBW','Test','User','USER',1,'2026-01-14 21:27:32','2026-01-14 21:27:32'),
(30009,'admin@g.com','$2a$10$jGVHLRp3CTnwJusl3laejeUoZDbsm89M822xrd25eJo3fdCkWFQRa','admin','1','USER',1,'2026-01-19 12:25:28','2026-01-19 12:25:28');