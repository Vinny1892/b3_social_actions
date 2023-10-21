package com.b3.social_action.dto.social_action;

import com.b3.social_action.entity.SocialAction;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.UUID;

public record DeleteSocialActionDTO(
        UUID id,
        String name,

        String paymentLink,
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "UTC")
        LocalDate dateInit,

        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "UTC")
        LocalDate dateFinal,

        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm:ss", timezone = "UTC")
        LocalTime timeInit,

        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm:ss", timezone = "UTC")
        LocalTime timeFinal,


        String status,
        String emailContact,
        String description

) {

    public SocialAction toEntity(){
        return new SocialAction(
                this.id,
                this.paymentLink,
                this.name,
                this.status,
                this.dateInit,
                this.dateFinal,
                this.timeInit,
                this.timeFinal,
                this.description,
                this.emailContact
        );
    }
}