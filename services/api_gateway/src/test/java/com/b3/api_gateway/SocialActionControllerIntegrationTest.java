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
public class SocialActionControllerIntegrationTest {

    @LocalServerPort
    private int port;

    private final RestTemplate restTemplate = new RestTemplate();
    private final String baseUrl = "http://localhost:";

    @Test
    public void testGetSocialActions() {
        URI uri = URI.create(baseUrl + port + "/social_actions?page=1&size=10");
        ResponseEntity<Map> response = restTemplate.getForEntity(uri, Map.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertNotNull(response.getBody());
    }

    @Test
    public void testCreateSocialAction() {
        URI uri = URI.create(baseUrl + port + "/social_actions");
        Map<String, Object> requestBody = new HashMap<>();
        // Preencha o corpo da solicitação com os dados necessários
        ResponseEntity<Map> response = restTemplate.postForEntity(uri, requestBody, Map.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertNotNull(response.getBody());
    }

    @Test
    public void testUpdateSocialAction() {
        String socialActionId = "ID_DA_SOCIAL_ACTION"; // Substitua com o ID real
        URI uri = URI.create(baseUrl + port + "/social_actions/" + socialActionId);
        Map<String, Object> requestBody = new HashMap<>();
        // Preencha o corpo da solicitação com os dados necessários
        final ResponseEntity<Map> response = restTemplate.exchange(uri, HttpMethod.PUT, null, Map.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertNotNull(response.getBody());
    }

    @Test
    public void testDeleteSocialAction() {
        String socialActionId = "ID_DA_SOCIAL_ACTION"; // Substitua com o ID real
        URI uri = URI.create(baseUrl + port + "/social_actions/" + socialActionId);
        ResponseEntity<Map> response = restTemplate.exchange(uri, HttpMethod.DELETE, null, Map.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertNotNull(response.getBody());
    }
}
