package com.b3.social_action.entity;


import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Set;
import java.util.UUID;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "social_action", schema = "public")
public class SocialAction {

    public SocialAction(String name, String status,  LocalDate dateInit, LocalDate dateFinal, LocalTime timeInit, LocalTime timeFinal, String description, String emailContact, Ong ong){
        this.name = name;
        this.status = status;
        this.dateInit = dateInit;
        this.dateFinal = dateFinal;
        this.timeInit = timeInit;
        this.timeFinal = timeFinal;
        this.description = description;
        this.emailContact = emailContact;
        this.ong = ong;
    }

    public SocialAction(String paymentLink, String name, String status, LocalDate dateInit, LocalDate dateFinal, LocalTime timeInit, LocalTime timeFinal, String description, String emailContact){
        this.name = name;
        this.status = status;
        this.dateInit = dateInit;
        this.dateFinal = dateFinal;
        this.timeInit = timeInit;
        this.timeFinal = timeFinal;
        this.description = description;
        this.emailContact = emailContact;
        this.paymentLink = paymentLink;
    }
    public SocialAction(UUID id, String paymentLink ,String name, String status, LocalDate dateInit, LocalDate dateFinal, LocalTime timeInit, LocalTime timeFinal ,String description, String emailContact) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.dateInit = dateInit;
        this.dateFinal = dateFinal;
        this.timeInit = timeInit;
        this.timeFinal = timeFinal;
        this.description = description;
        this.emailContact = emailContact;
        this.paymentLink = paymentLink;

    }

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    @ManyToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name="ong_id", nullable = true)
    Ong ong;

    @OneToMany(mappedBy = "socialAction")
    Set<Task> tasks;

    @Column
    String name;

    @Column
    String status;

    @Column(name="email_contact")
    String emailContact;

    @Column
    String description;

    @Column
    String paymentLink;

    @Temporal(TemporalType.DATE)
    LocalDate dateInit;

    @Temporal(TemporalType.DATE)
    LocalDate dateFinal;

    @Temporal(TemporalType.TIME)
    LocalTime timeInit;

    @Temporal(TemporalType.TIME)
    LocalTime timeFinal;

    @Temporal(TemporalType.TIMESTAMP)
     LocalDateTime createdAt;

    @Temporal(TemporalType.TIMESTAMP)
     LocalDateTime updatedAt;

    public SocialAction(String name) {
        this.name =name;
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
