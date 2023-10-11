package com.b3.social_action.dto.task;

import com.b3.social_action.entity.Task;

import java.util.UUID;

public record DeleteTaskDTO(

        UUID id,
        String name,

        int quantityOfVacancy
)
{ }
