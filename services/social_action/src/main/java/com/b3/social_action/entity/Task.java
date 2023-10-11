package com.b3.social_action.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
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
@Table(name = "task", schema = "public")
public class Task {

    public Task(String name, int quantityOfVacancy){
        this.name = name;
        this.quantityOfVacancy = quantityOfVacancy;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name="social_action_id", nullable = false)
    SocialAction socialAction;

    @Column
    String name;

    @Column
    Integer quantityOfVacancy;


    @Temporal(TemporalType.TIMESTAMP)
    LocalDateTime createdAt;

    @Temporal(TemporalType.TIMESTAMP)
    LocalDateTime updatedAt;


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
