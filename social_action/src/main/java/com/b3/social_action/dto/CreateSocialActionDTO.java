package com.b3.social_action.dto;

import com.b3.social_action.entity.SocialAction;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

public record CreateSocialActionDTO(
        Optional<UUID> id,
        String name,

        @JsonFormat(pattern = "yyyy-MM-dd HH:mm" , shape = JsonFormat.Shape.STRING)
        LocalDateTime date,
        String locale,
        String resource
) {

    public SocialAction toEntity(){
        return new SocialAction(
                this.name,
                this.resource,
                this.date,
                this.locale
        );
    }
}
