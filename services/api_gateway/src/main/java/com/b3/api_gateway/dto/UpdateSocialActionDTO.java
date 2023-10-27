package com.b3.api_gateway.dto;

import java.time.LocalDateTime;

public record UpdateSocialActionDTO(
        String name,
        String date,
        LocalDateTime locale,
        String resource
) {}

