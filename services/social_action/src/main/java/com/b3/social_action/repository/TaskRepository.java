package com.b3.social_action.repository;

import com.b3.social_action.entity.Task;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface TaskRepository extends JpaRepository<Task, UUID> {
    List<Task> findTaskByNameContainsIgnoreCase(String name);
}
