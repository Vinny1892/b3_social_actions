package com.b3.social_action.service;

import com.b3.social_action.dto.task.CreateTaskDTO;
import com.b3.social_action.dto.task.DeleteTaskDTO;
import com.b3.social_action.dto.task.UpdateTaskDTO;
import com.b3.social_action.entity.SocialAction;
import com.b3.social_action.entity.Task;
import com.b3.social_action.exceptions.UnprocessableEntityException;
import com.b3.social_action.repository.SocialActionRepository;
import com.b3.social_action.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class TaskService {

    @Autowired
    private SocialActionRepository socialActionRepository;

    @Autowired
    private TaskRepository taskRepository;


    public List<Task> search(String search){
        return taskRepository.findTaskByNameContainsIgnoreCase(search);
    }
    public CreateTaskDTO createTask(CreateTaskDTO createTaskDTO){
        var socialAction = socialActionRepository.findById(createTaskDTO.social_action_id());
        if(socialAction.isEmpty()){
            throw new UnprocessableEntityException("social action not exists");
        }
        var task = createTaskDTO.toEntity();
        task.setSocialAction(socialAction.get());
        taskRepository.save(task);
        return new CreateTaskDTO(
                Optional.ofNullable(task.getId()),
                task.getSocialAction().getId(),
                task.getName(),
                task.getQuantityOfVacancy(),
                task.getEmailContact(),
                task.getDescription(),
                task.getStatus(),
                task.getDateInit(),
                task.getDateFinal(),
                task.getTimeInit(),
                task.getTimeFinal()
        );
    }

    public Optional<UpdateTaskDTO> updateTask(UpdateTaskDTO updateTaskDTO, UUID id){
        var optionalTask = taskRepository.findById(id);
        if(optionalTask.isEmpty()){
           return Optional.empty();
        }
        var task =  optionalTask.get();
        task.setName(updateTaskDTO.name());
        task.setQuantityOfVacancy(updateTaskDTO.quantityOfVacancy());
        taskRepository.save(task);
        return Optional.of(new UpdateTaskDTO(
                task.getId(),
                task.getSocialAction().getId(),
                task.getName(),
                task.getQuantityOfVacancy(),
                task.getEmailContact(),
                task.getDescription(),
                task.getStatus(),
                task.getDateInit(),
                task.getDateFinal(),
                task.getTimeInit(),
                task.getTimeFinal()
        ));
    }
    public Optional<DeleteTaskDTO> delete(UUID id){
        var optionalTask = taskRepository.findById(id);
        if(optionalTask.isEmpty()){
            return Optional.empty();
        }
        taskRepository.delete(optionalTask.get());
        return Optional.of(new DeleteTaskDTO(
                optionalTask.get().getId(),
                optionalTask.get().getSocialAction().getId(),
                optionalTask.get().getName(),
                optionalTask.get().getQuantityOfVacancy(),
                optionalTask.get().getEmailContact(),
                optionalTask.get().getDescription(),
                optionalTask.get().getStatus(),
                optionalTask.get().getDateInit(),
                optionalTask.get().getDateFinal(),
                optionalTask.get().getTimeInit(),
                optionalTask.get().getTimeFinal()
        ));
    }

    public Optional<Task> getTaskByID(UUID id){
        return taskRepository.findById(id);
    }

}
