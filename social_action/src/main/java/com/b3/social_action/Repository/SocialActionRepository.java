package com.b3.social_action.Repository;

import com.b3.social_action.Entity.SocialAction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface SocialActionRepository extends JpaRepository<SocialAction, UUID> {}
