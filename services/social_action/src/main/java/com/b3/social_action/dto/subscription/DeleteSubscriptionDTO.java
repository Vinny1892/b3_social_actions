package com.b3.social_action.dto.subscription;

import java.util.UUID;

public record DeleteSubscriptionDTO(
        UUID id,
        UUID taskID
) {
}
