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
@Table(name = "presence", schema = "public")
public class Presence {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    @OneToOne
    @JoinColumn(name = "subscription_id" , referencedColumnName = "id")
    Subscription subscription;

    @ManyToOne
    @JoinColumn(name="task_id", nullable = false)
    Task task;

    @Column(name="user_id")
    UUID userID;

    @Temporal(TemporalType.TIMESTAMP)
    LocalDateTime createdAt;

    @Temporal(TemporalType.TIMESTAMP)
    LocalDateTime updatedAt;

    public Presence(UUID id, Subscription subscription, UUID userID, Task task) {
        this.id = id;
        this.subscription = subscription;
        this.userID = userID;
        this.task = task;
    }


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
