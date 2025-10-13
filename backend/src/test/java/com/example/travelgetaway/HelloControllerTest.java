package com.example.travelgetaway;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

// Loads the Spring Boot application context for the test
@SpringBootTest
// Automatically configures MockMvc for HTTP request testing
@AutoConfigureMockMvc
public class HelloControllerTest {
    // Injects the MockMvc instance for performing HTTP requests in tests
    @Autowired
    private MockMvc mockMvc;

    // Marks this method as a test case to be run by JUnit
    @Test
    void helloEndpointReturnsHelloWorld() throws Exception {
        // Performs a GET request to /api/hello and checks the response
        mockMvc.perform(get("/api/hello"))
                .andExpect(status().isOk())
                .andExpect(content().string("Hello World!"));
    }
}