package com.b3.social_action.dto.presence;

import java.util.UUID;

public record DeletePresenceDTO(
        UUID id,
        UUID taskID
) {
}
