package com.b3.social_action.entity;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "social_action", schema = "public")
public class SocialAction {

    public SocialAction(String name , String locale, LocalDateTime date, String resources){
        this.name = name;
        this.locale = locale;
        this.resources = resources;
        this.date = date;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    @Column
    String name;

    @Temporal(TemporalType.TIMESTAMP)
    LocalDateTime date;

    @Column
    String locale;

    @Column
    String resources;

    @Temporal(TemporalType.TIMESTAMP)
     LocalDateTime createdAt;

    @Temporal(TemporalType.TIMESTAMP)
     LocalDateTime updatedAt;

    @Column(nullable = true)
     LocalDateTime verifiedAt;


    @PrePersist
    protected void onCreate() {
        this.updatedAt = LocalDateTime.now();
        this.createdAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
}
