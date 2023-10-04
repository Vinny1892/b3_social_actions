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

    @ManyToOne // Muitas ações sociais podem pertencer a uma categoria
    @JoinColumn(name = "categoria_id") // Nome da coluna que armazena a chave estrangeira
    private Categoria categoria;
    
    public SocialAction(String name){
        this.name = name;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    @ManyToOne
    @JoinColumn(name="ong_id", nullable = false)
    Ong ong;

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
