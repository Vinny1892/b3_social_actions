package com.b3.social_action.unit.service.task;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import com.b3.social_action.dto.task.DeleteTaskDTO;
import com.b3.social_action.entity.Task;
import com.b3.social_action.repository.TaskRepository;
import com.b3.social_action.service.TaskService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Optional;
import java.util.UUID;

public class DeleteTaskService {

    @Mock
    private TaskRepository taskRepository;

    @InjectMocks
    private TaskService taskService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testDeleteTask_Exists() {
        // Simular uma tarefa existente
        UUID taskId = UUID.randomUUID();
        Task existingTask = new Task();
        existingTask.setId(taskId);
        existingTask.setName("TaskName");

        when(taskRepository.findById(taskId)).thenReturn(Optional.of(existingTask));

        // Chamar o método delete
        Optional<DeleteTaskDTO> result = taskService.delete(taskId);

        // Verificar se o método delete do taskRepository foi chamado
        verify(taskRepository, times(1)).delete(existingTask);

        // Verificar se o resultado contém os dados da tarefa excluída
        assertTrue(result.isPresent());
        assertEquals(taskId, result.get().id());
        assertEquals("TaskName", result.get().name());
    }

    @Test
    public void testDeleteTask_NotExists() {
        // Simular uma tarefa que não existe
        UUID taskId = UUID.randomUUID();

        when(taskRepository.findById(taskId)).thenReturn(Optional.empty());

        // Chamar o método delete
        Optional<DeleteTaskDTO> result = taskService.delete(taskId);

        // Verificar se o método delete do taskRepository NÃO foi chamado
        verify(taskRepository, never()).delete(any(Task.class));

        // Verificar se o resultado está vazio (tarefa não encontrada)
        assertFalse(result.isPresent());
    }
}
