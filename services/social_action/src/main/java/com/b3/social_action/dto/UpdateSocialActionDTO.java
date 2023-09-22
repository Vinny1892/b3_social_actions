package com.b3.social_action.dto;

import com.b3.social_action.entity.SocialAction;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDateTime;
import java.util.UUID;

public record UpdateSocialActionDTO(
        UUID id,
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