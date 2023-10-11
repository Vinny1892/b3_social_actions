package com.b3.social_action.repository;

import com.b3.social_action.entity.Presence;
import com.b3.social_action.entity.Task;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface PresenceRepository extends JpaRepository<Presence, UUID> {
    Optional<Presence> findByUserIDAndTask(UUID userID,Task task);
}
