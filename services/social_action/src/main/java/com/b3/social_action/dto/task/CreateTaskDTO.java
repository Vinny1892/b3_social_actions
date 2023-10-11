package com.b3.social_action.dto.task;

import com.b3.social_action.entity.SocialAction;
import com.b3.social_action.entity.Task;

import java.util.Optional;
import java.util.UUID;

public record CreateTaskDTO(
        Optional<UUID> id,
        UUID social_action_id,
        String name,

        int quantityOfVacancy
) {

    public Task toEntity(){
        return new Task(
                this.name,
                this.quantityOfVacancy
        );
    }
}
