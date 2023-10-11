package com.b3.social_action.repository;

import com.b3.social_action.entity.Subscription;
import com.b3.social_action.entity.Task;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface SubscriptionRepository extends JpaRepository<Subscription, UUID> {
    Integer countByTask(Task task);
    Optional<Subscription> findByUserIDAndTask(UUID userID, Task task);
}
