package com.b3.social_action.dto.social_action;

import com.b3.social_action.entity.SocialAction;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDateTime;
import java.util.UUID;

public record DeleteSocialActionDTO(
        UUID id,
        String name

) {

    public SocialAction toEntity(){
        return new SocialAction(
                this.name
        );
    }
}