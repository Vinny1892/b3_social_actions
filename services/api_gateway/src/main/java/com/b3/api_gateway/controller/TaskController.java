package com.b3.api_gateway.controller;

import com.b3.api_gateway.repository.TaskRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("task")
public class TaskController {

    Logger logger =  LoggerFactory.getLogger(this.getClass());

    @Autowired
    TaskRepository taskRepository;

    @GetMapping("/search/{search}")
    public Map search(
            @PathVariable(value = "search") String search) throws Exception {
        var response = taskRepository.search(search);
        return response;
    }

    @PostMapping
    public Map createTask(@RequestBody Map dto) throws Exception {
        var response = taskRepository.createTask(dto);
        logger.info("created task");

        return response;
    }

    @PutMapping("{id}")
    public Map updateTask(@RequestBody Map dto, @PathVariable("id") UUID id) throws Exception {
        var response = taskRepository.updateTask(dto,id);
        logger.info("task updated");

        return response;
    }

    @GetMapping("{id}")
    public Map get(
            @PathVariable(required = true) UUID id
    ) throws Exception {
        return taskRepository.getTaskByID(id);
    }

    @DeleteMapping("{id}")
    public Map deleteTask(@PathVariable("id") UUID id) throws Exception {
        var response = taskRepository.deleteTask(id);
        logger.info("task deleted");

        return response;
    }


}
