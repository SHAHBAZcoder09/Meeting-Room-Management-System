package com.shortproject.controller;

import com.shortproject.dto.DashboardStatsDTO;
import com.shortproject.service.StatsService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/stats")
@RequiredArgsConstructor
public class StatsController {

    private final StatsService statsService;

    @GetMapping
    public ResponseEntity<DashboardStatsDTO> getStats() {
        return ResponseEntity.ok(statsService.getDashboardStats());
    }
}
