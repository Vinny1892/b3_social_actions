package com.b3.api_gateway.dto;

import java.time.LocalDateTime;

public record CreateSocialActionDTO(
        String name,
        String date,
        LocalDateTime locale,
        String resource
) {}