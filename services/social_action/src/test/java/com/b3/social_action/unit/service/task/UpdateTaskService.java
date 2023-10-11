package com.b3.social_action.unit.service.task;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import com.b3.social_action.dto.task.UpdateTaskDTO;
import com.b3.social_action.entity.SocialAction;
import com.b3.social_action.entity.Task;
import com.b3.social_action.repository.SocialActionRepository;
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

public class UpdateTaskService {

    @Mock
    private SocialActionRepository socialActionRepository;

    @Mock
    private TaskRepository taskRepository;

    @InjectMocks
    private TaskService taskService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testUpdateTask_Exists() {
        // Simular uma tarefa existente
        UUID taskId = UUID.randomUUID();
        Task existingTask = new Task();
        existingTask.setId(taskId);
        existingTask.setName("TaskName");
        SocialAction socialAction = new SocialAction();
        socialAction.setId(UUID.randomUUID());
        existingTask.setSocialAction(socialAction);

        when(taskRepository.findById(taskId)).thenReturn(Optional.of(existingTask));

        // Criar um objeto UpdateTaskDTO
        UpdateTaskDTO updateTaskDTO = new UpdateTaskDTO(
                Optional.of(taskId),
                socialAction.getId(),
                "NewTaskName",
                2
        );

        // Chamar o método updateTask
        Optional<UpdateTaskDTO> result = taskService.updateTask(updateTaskDTO, taskId);

        // Verificar se o método save do taskRepository foi chamado
        verify(taskRepository, times(1)).save(existingTask);

        // Verificar se o resultado contém os dados atualizados
        assertTrue(result.isPresent());
        assertEquals(taskId, result.get().id().orElse(null));
        assertEquals(socialAction.getId(), result.get().social_action_id());
        assertEquals("NewTaskName", result.get().name());
    }

    @Test
    public void testUpdateTask_NotExists() {
        // Simular uma tarefa que não existe
        UUID taskId = UUID.randomUUID();

        when(taskRepository.findById(taskId)).thenReturn(Optional.empty());

        // Criar um objeto UpdateTaskDTO
        UpdateTaskDTO updateTaskDTO = new UpdateTaskDTO(
                Optional.of(taskId),
                UUID.randomUUID(),
                "NewTaskName",
                2
        );

        // Chamar o método updateTask
        Optional<UpdateTaskDTO> result = taskService.updateTask(updateTaskDTO, taskId);

        // Verificar se o método save do taskRepository NÃO foi chamado
        verify(taskRepository, never()).save(any(Task.class));

        // Verificar se o resultado está vazio (tarefa não encontrada)
        assertFalse(result.isPresent());
    }
}
