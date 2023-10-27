package com.b3.api_gateway;

import com.b3.api_gateway.repository.SocialActionRepository;
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
public class SocialActionRepositoryTest {

    private SocialActionRepository socialActionRepository;

    @Mock
    private RequestContract request;

    @BeforeEach
    public void setUp() {
        socialActionRepository = new SocialActionRepository();
        socialActionRepository.baseURL = "http://example.com"; // Defina um valor de baseURL para testes

        // Injete o mock do RequestContract na classe SocialActionRepository
        socialActionRepository.request = request;
    }

    @Test
    public void testListPaginateSocialActions() throws Exception {
        int size = 10;
        int page = 1;

        // Simule a chamada HTTP e resposta
        Map<String, Object> response = new LinkedHashMap<>();
        Mockito.when(request.makeGetRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class), Mockito.eq(page), Mockito.eq(size))
                .thenReturn(response);

        Map<String, Object> result = socialActionRepository.listPaginateSocialActions(size, page);
        assertEquals(response, result);
    }

    @Test
    public void testGetSocialActionByID() throws Exception {
        UUID id = UUID.randomUUID();

        // Simule a chamada HTTP e resposta
        Map<String, Object> response = new LinkedHashMap<>();
        Mockito.when(request.makeGetRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class), Mockito.eq(id))
                .thenReturn(response);

        Map<String, Object> result = socialActionRepository.getSocialActionByID(id);
        assertEquals(response, result);
    }

    @Test
    public void testCreateSocialAction() throws Exception {
        Map<String, Object> dto = new LinkedHashMap<>();

        // Simule a chamada HTTP e resposta
        Map<String, Object> response = new LinkedHashMap<>();
        Mockito.when(request.makePostRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class))
                .thenReturn(response);

        Map<String, Object> result = socialActionRepository.createSocialAction(dto);
        assertEquals(response, result);
    }

    @Test
    public void testUpdateSocialAction() throws Exception {
        UUID id = UUID.randomUUID();
        Map<String, Object> dto = new LinkedHashMap<>();

        // Simule a chamada HTTP e resposta
        Map<String, Object> response = new LinkedHashMap<>();
        Mockito.when(request.makePutRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class), Mockito.eq(id))
                .thenReturn(response);

        Map<String, Object> result = socialActionRepository.updateSocialAction(dto, id);
        assertEquals(response, result);
    }

    @Test
    public void testDeleteSocialAction() throws Exception {
        UUID id = UUID.randomUUID();

        // Simule a chamada HTTP e resposta
        Map<String, Object> response = new LinkedHashMap<>();
        Mockito.when(request.makeDeleteRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class), Mockito.eq(id))
                .thenReturn(response);

        Map<String, Object> result = socialActionRepository.deleteSocialAction(id);
        assertEquals(response, result);
    }
}

