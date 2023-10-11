package com.b3.social_action.dto.subscription;

import java.util.Optional;
import java.util.UUID;

public record CreateSubscriptionDTO(
        Optional<UUID> id,
        UUID taskID,
        Optional<UUID> userID

) {}
