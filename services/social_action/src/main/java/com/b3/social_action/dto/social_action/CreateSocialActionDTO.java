package com.b3.social_action.dto.social_action;

import com.b3.social_action.controller.SocialActionStatus;
import com.b3.social_action.entity.SocialAction;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Optional;
import java.util.UUID;

public record CreateSocialActionDTO(
        Optional<UUID> id,

        Optional<UUID> ongID,
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

        SocialActionStatus status,
        String emailContact,
        String description
) {

    public SocialAction toEntity(){
        return new SocialAction(
                this.paymentLink,
                this.name,
                this.status.name(),
                this.dateInit,
                this.dateFinal,
                this.timeInit,
                this.timeFinal,
                this.description,
                this.emailContact
        );
    }
}
