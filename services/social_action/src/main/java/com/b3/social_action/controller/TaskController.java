package com.b3.social_action.controller;

import com.b3.social_action.dto.task.CreateTaskDTO;
import com.b3.social_action.dto.task.DeleteTaskDTO;
import com.b3.social_action.dto.task.UpdateTaskDTO;
import com.b3.social_action.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.UUID;

@RestController
@RequestMapping("task")
public class TaskController {

    @Autowired
    private TaskService taskService;

    @PostMapping
    public ResponseEntity<CreateTaskDTO> createTaskDTO(@RequestBody CreateTaskDTO dto, UriComponentsBuilder uriBuilder){
        var response =  taskService.createTask(dto);
        var uri = uriBuilder.path("/task/{id}").buildAndExpand(response.id().get()).toUri();
        return ResponseEntity.created(uri).body(response);
    }

    @GetMapping("/search/{search}")
    public ResponseEntity search(
            @PathVariable(value = "search") String search){
        var task = taskService.search(search);
        return ResponseEntity.ok().body(task);
    }

    @GetMapping("{id}")
    public ResponseEntity getTask(
            @PathVariable(value = "id") UUID taskID){
        var task = taskService.getTaskByID(taskID);
        if(task.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok().body(task);
    }

    @PutMapping("{id}")
    public ResponseEntity<UpdateTaskDTO> updateTaskDTO(
            @PathVariable("id") UUID id,
            @RequestBody UpdateTaskDTO dto){
        var response = taskService.updateTask(dto,id);
        if(response.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(response.get());
    }
    @DeleteMapping("{id}")
    public ResponseEntity<DeleteTaskDTO> deleteTask(@PathVariable UUID id){
        var response =  taskService.delete(id);
        if(response.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(response.get());
    }
}
