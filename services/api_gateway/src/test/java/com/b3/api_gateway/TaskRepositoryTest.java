package com.b3.api_gateway;

import com.b3.api_gateway.repository.TaskRepository;
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
public class TaskRepositoryTest {

    private TaskRepository taskRepository;

    @Mock
    private RequestContract request;

    @BeforeEach
    public void setUp() {
        taskRepository = new TaskRepository();
        taskRepository.baseURL = "http://example.com"; // Defina um valor de baseURL para testes

        // Injete o mock do RequestContract na classe TaskRepository
        taskRepository.request = request;
    }

    @Test
    public void testCreateTask() throws Exception {
        Map<String, Object> dto = new LinkedHashMap<>();

        // Simule a chamada HTTP e resposta
        Map<String, Object> response = new LinkedHashMap<>();
        Mockito.when(request.makePostRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class))
                .thenReturn(response);

        Map<String, Object> result = taskRepository.createTask(dto);
        assertEquals(response, result);
    }

    @Test
    public void testUpdateTask() throws Exception {
        UUID id = UUID.randomUUID();
        Map<String, Object> dto = new LinkedHashMap<>();

        // Simule a chamada HTTP e resposta
        Map<String, Object> response = new LinkedHashMap<>();
        Mockito.when(request.makePutRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class), Mockito.eq(id))
                .thenReturn(response);

        Map<String, Object> result = taskRepository.updateTask(dto, id);
        assertEquals(response, result);
    }

    @Test
    public void testDeleteTask() throws Exception {
        UUID id = UUID.randomUUID();

        // Simule a chamada HTTP e resposta
        Map<String, Object> response = new LinkedHashMap<>();
        Mockito.when(request.makeDeleteRequest(Mockito.anyString(), Mockito.any(), Mockito.any(), Mockito.eq(Map.class), Mockito.eq(id))
                .thenReturn(response);

        Map<String, Object> result = taskRepository.deleteTask(id);
        assertEquals(response, result);
    }
}

