package com.b3.social_action.repository;

import com.b3.social_action.entity.SocialAction;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface SocialActionRepository extends JpaRepository<SocialAction, UUID> {

    List<SocialAction> findSocialActionByNameContainsIgnoreCase(String name);
    Page<SocialAction> findSocialActionByStatus(String status, Pageable page);
}
