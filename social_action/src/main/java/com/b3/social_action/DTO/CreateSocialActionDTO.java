package com.b3.social_action.DTO;

import com.b3.social_action.Entity.SocialAction;

import java.time.LocalDateTime;

public record CreateSocialActionDTO(
        String name,
        String date,
        LocalDateTime locale,
        String resource
) {

    public SocialAction toEntity(){
        return new SocialAction(
                this.name,
                this.resource,
                this.locale,
                this.date
        );
    }
}
