package com.b3.social_action.dto.task;

import com.b3.social_action.entity.SocialAction;
import com.b3.social_action.entity.Task;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Optional;
import java.util.UUID;

public record CreateTaskDTO(
        Optional<UUID> id,
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
) {

    public Task toEntity(){
        return new Task(
                this.name,
                this.quantityOfVacancy,
                this.status,
                this.description,
                this.emailContact,
                this.dateInit,
                this.dateFinal,
                this.timeInit,
                this.timeFinal
        );
    }
}
