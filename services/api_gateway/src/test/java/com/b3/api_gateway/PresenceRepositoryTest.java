package com.b3.api_gateway;

import com.b3.api_gateway.dto.CreateSocialActionDTO;
import com.b3.api_gateway.repository.PresenceRepository;
import com.b3.api_gateway.helper.RequestContract;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.stubbing.OngoingStubbing;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
public class PresenceRepositoryTest {

    private PresenceRepository presenceRepository;

    @Mock
    private RequestContract request;

    @BeforeEach
    public void setUp() {
        presenceRepository = new PresenceRepository();
        presenceRepository.baseURL = "http://example.com"; // Defina um valor de baseURL para testes

        // Injete o mock do RequestContract na classe PresenceRepository
        presenceRepository.request = request;
    }

    @Test
    public void testCreatePresence() throws Exception {
        Map<String, Object> dto = new LinkedHashMap<>();
        dto.put("name", "Event Name");
        dto.put("date", "2023-10-30T08:00:00");
        dto.put("resource", "Resource Name");

        // Simule a chamada HTTP e resposta
        Mockito.when(request.makePostRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class)).thenReturn(dto);


        Map<String, Object> response = presenceRepository.createPresence(dto);
        assertEquals(dto, response);
    }

    @Test
    public void testDeletePresence() throws Exception {
        UUID id = UUID.randomUUID();

        // Simule a chamada HTTP e resposta
        Mockito.when(request.makeDeleteRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class), Mockito.eq(id))
                .thenReturn(new LinkedHashMap<>());


        Map<String, Object> response = presenceRepository.deletePresence(id);
        assertEquals(0, response.size());
    }

}

