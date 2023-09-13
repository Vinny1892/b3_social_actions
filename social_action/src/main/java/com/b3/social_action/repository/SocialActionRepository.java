package com.b3.social_action.repository;

import com.b3.social_action.entity.SocialAction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface SocialActionRepository extends JpaRepository<SocialAction, UUID> {}
