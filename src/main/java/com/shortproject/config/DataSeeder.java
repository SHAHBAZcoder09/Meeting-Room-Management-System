package com.shortproject.config;

import com.shortproject.model.User;
import com.shortproject.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class DataSeeder implements CommandLineRunner {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        if (userRepository.count() == 0) {
            // Admin User
            User admin = new User();
            admin.setFirstName("Admin");
            admin.setLastName("User");
            admin.setEmail("admin@company.com");
            admin.setPassword(passwordEncoder.encode("password"));
            admin.setRole("ADMIN");
            admin.setActive(true);
            userRepository.save(admin);

            // Normal User
            User user = new User();
            user.setFirstName("Normal");
            user.setLastName("User");
            user.setEmail("user@company.com");
            user.setPassword(passwordEncoder.encode("password"));
            user.setRole("USER");
            user.setActive(true);
            userRepository.save(user); // Fixed: was saving admin again
            
            System.out.println("Seeded Default Users: admin@company.com / password, user@company.com / password");
        }
    }
}
