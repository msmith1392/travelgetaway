package com.example.travelgetaway;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

// Marks this class as a REST controller, making it capable of handling HTTP requests
@RestController
public class HelloController {
    // Maps HTTP GET requests to /api/hello to this method
    @GetMapping("/api/hello")
    public String hello() {
        return "Hello, World!";
    }
}