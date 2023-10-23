package com.b3.social_action.repository;

import com.b3.social_action.entity.Ong;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface OngRepository extends JpaRepository<Ong, UUID> {
    List<Ong> findOngByNameContainsIgnoreCase(String name);
}
