package com.b3.social_action.entity;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Set;
import java.util.UUID;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "social_action", schema = "public")
public class SocialAction {

    public SocialAction(String name){
        this.name = name;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="ong_id", nullable = false)
    Ong ong;

    @OneToMany(mappedBy = "socialAction")
    Set<Task> tasks;

    @Column
    String name;


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
