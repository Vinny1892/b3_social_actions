package com.b3.api_gateway;

import com.b3.api_gateway.repository.SubscriptionRepository;
import com.b3.api_gateway.helper.RequestContract;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
public class SubscriptionRepositoryTest {

    private SubscriptionRepository subscriptionRepository;

    @Mock
    private RequestContract request;

    @BeforeEach
    public void setUp() {
        subscriptionRepository = new SubscriptionRepository();
        subscriptionRepository.baseURL = "http://example.com"; // Defina um valor de baseURL para testes

        // Injete o mock do RequestContract na classe SubscriptionRepository
        subscriptionRepository.request = request;
    }

    @Test
    public void testCreateSubscription() throws Exception {
        Map<String, Object> dto = new LinkedHashMap<>();

        // Simule a chamada HTTP e resposta
        Map<String, Object> response = new LinkedHashMap<>();
        Mockito.when(request.makePostRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class))
                .thenReturn(response);

        Map<String, Object> result = subscriptionRepository.createSubscription(dto);
        assertEquals(response, result);
    }

    @Test
    public void testGetAllSubscriptions() throws Exception {
        int page = 1;
        int size = 10;

        // Simule a chamada HTTP e resposta
        Map<String, Object> response = new LinkedHashMap<>();
        Mockito.when(request.makeGetRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class), Mockito.eq(page), Mockito.eq(size))
                .thenReturn(response);

        Map<String, Object> result = subscriptionRepository.getAllSubscriptions(page, size);
        assertEquals(response, result);
    }

    @Test
    public void testDeleteSubscription() throws Exception {
        UUID id = UUID.randomUUID();

        // Simule a chamada HTTP e resposta
        Map<String, Object> response = new LinkedHashMap<>();
        Mockito.when(request.makeDeleteRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class), Mockito.eq(id))
                .thenReturn(response);

        Map<String, Object> result = subscriptionRepository.deleteSubscription(id);
        assertEquals(response, result);
    }
}

