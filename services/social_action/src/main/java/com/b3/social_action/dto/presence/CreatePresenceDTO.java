package com.b3.social_action.dto.presence;

import com.b3.social_action.entity.Presence;
import com.b3.social_action.entity.Subscription;
import com.b3.social_action.entity.Task;

import java.util.Optional;
import java.util.UUID;

public record CreatePresenceDTO(
        Optional<UUID> id,
        Optional<UUID> userID,
        UUID taskID
) {}
