package com.b3.social_action.dto.social_action;

import com.b3.social_action.entity.SocialAction;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

public record CreateSocialActionDTO(
        Optional<UUID> ong,
        Optional<UUID> id,
        String name

) {

    public SocialAction toEntity(){
        return new SocialAction(
                this.name
        );
    }
}
