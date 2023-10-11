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
@Table(name = "subscription", schema = "public")
public class Subscription {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    @ManyToOne
    @JoinColumn(name="task_id", nullable = false)
    Task task;

    @Column(name = "user_id")
    UUID userID;

    @Temporal(TemporalType.TIMESTAMP)
    LocalDateTime createdAt;

    @Temporal(TemporalType.TIMESTAMP)
    LocalDateTime updatedAt;

    public Subscription(UUID id, Task task, UUID userID){
        this.id = id;
        this.task = task;
        this.userID = userID;
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
