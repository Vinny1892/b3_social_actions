package com.b3.social_action.dto.task;

import com.b3.social_action.entity.Task;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

public record DeleteTaskDTO(
        UUID id,

        UUID social_action_id,
        String name,
        Integer quantityOfVacancy,
        String emailContact,

        String description,
        String status,

        LocalDate dateInit,
        LocalDate dateFinal,
        LocalTime timeInit,
        LocalTime timeFinal

){ }
