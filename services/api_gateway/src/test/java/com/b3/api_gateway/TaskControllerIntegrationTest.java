package com.b3.api_gateway;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import java.net.URI;
import java.util.HashMap;
import java.util.Map;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest(classes = ApiGatewayApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class TaskControllerIntegrationTest {

    @LocalServerPort
    private int port;

    private final RestTemplate restTemplate = new RestTemplate();
    private final String baseUrl = "http://localhost:";

    @Test
    public void testCreateTask() {
        URI uri = URI.create(baseUrl + port + "/task");
        Map<String, Object> requestBody = new HashMap<>();
        // Preencha o corpo da solicitação com os dados necessários
        ResponseEntity<Map> response = restTemplate.postForEntity(uri, requestBody, Map.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertNotNull(response.getBody());
    }

    @Test
    public void testUpdateTask() {
        String taskId = "ID_DA_TASK"; // Substitua com o ID real
        URI uri = URI.create(baseUrl + port + "/task/" + taskId);
        Map<String, Object> requestBody = new HashMap<>();
        // Preencha o corpo da solicitação com os dados necessários
        ResponseEntity<Map> response = restTemplate.exchange(uri, HttpMethod.PUT, null, Map.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertNotNull(response.getBody());
    }

    @Test
    public void testDeleteTask() {
        String taskId = "ID_DA_TASK"; // Substitua com o ID real
        URI uri = URI.create(baseUrl + port + "/task/" + taskId);
        ResponseEntity<Map> response = restTemplate.exchange(uri, HttpMethod.DELETE, null, Map.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertNotNull(response.getBody());
    }

}
