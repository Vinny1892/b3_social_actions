package com.b3.social_action.unit.service.task;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.*;

import com.b3.social_action.dto.task.CreateTaskDTO;
import com.b3.social_action.entity.SocialAction;
import com.b3.social_action.entity.Task;
import com.b3.social_action.exceptions.UnprocessableEntityException;
import com.b3.social_action.repository.SocialActionRepository;
import com.b3.social_action.repository.TaskRepository;
import com.b3.social_action.service.TaskService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Optional;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

public class CreateTaskServiceTest {


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
    public void testCreateTask_Success() {
        // Simular um SocialAction existente
        SocialAction socialAction = new SocialAction();
        when(socialActionRepository.findById(any())).thenReturn(Optional.of(socialAction));

        // Criar um objeto CreateTaskDTO
        CreateTaskDTO createTaskDTO = new CreateTaskDTO(null, UUID.randomUUID(),"teste", 2);

        // Chamar o método createTask
        taskService.createTask(createTaskDTO);

        // Verificar se o método save do taskRepository foi chamado
        verify(taskRepository, times(1)).save(any(Task.class));
    }

    @Test
    public void testCreateTask_SocialActionNotFound() {
        // Simular um SocialAction não existente
        when(socialActionRepository.findById(any())).thenReturn(Optional.empty());

        // Criar um objeto CreateTaskDTO
        CreateTaskDTO createTaskDTO = new CreateTaskDTO(null, UUID.randomUUID(),"teste", 2);

        // Verificar se uma exceção UnprocessableEntityException é lançada
        assertThrows(UnprocessableEntityException.class, () -> {
            taskService.createTask(createTaskDTO);
        });

        // Verificar se o método save do taskRepository NÃO foi chamado
        verify(taskRepository, never()).save(any(Task.class));
    }
}
