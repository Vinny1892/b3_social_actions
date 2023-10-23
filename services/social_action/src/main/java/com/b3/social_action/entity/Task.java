package com.b3.social_action.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.UUID;
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "task", schema = "public")
public class Task {

    public Task(UUID id, String name, int quantityOfVacancy, String status, String description, String emailContact, LocalDate dateInit, LocalDate dateFinal, LocalTime timeInit, LocalTime timeFinal){
        this.id = id;
        this.name = name;
        this.quantityOfVacancy = quantityOfVacancy;
        this.status = status;
        this.description = description;
        this.emailContact = emailContact;
        this.dateInit = dateInit;
        this.dateFinal = dateFinal;
        this.timeInit = timeInit;
        this.timeFinal = timeFinal;
    }

    public Task(String name, int quantityOfVacancy, String status, String description, String emailContact, LocalDate dateInit, LocalDate dateFinal, LocalTime timeInit, LocalTime timeFinal ){
        this.name = name;
        this.quantityOfVacancy = quantityOfVacancy;
        this.status = status;
        this.description = description;
        this.emailContact = emailContact;
        this.dateInit = dateInit;
        this.dateFinal = dateFinal;
        this.timeInit = timeInit;
        this.timeFinal = timeFinal;
    }

    public Task(String name, int quantityOfVacancy, String status, String description, String emailContact, LocalDate dateInit, LocalDate dateFinal, LocalTime timeInit, LocalTime timeFinal, SocialAction socialAction ){
        this.name = name;
        this.quantityOfVacancy = quantityOfVacancy;
        this.status = status;
        this.description = description;
        this.emailContact = emailContact;
        this.dateInit = dateInit;
        this.dateFinal = dateFinal;
        this.timeInit = timeInit;
        this.timeFinal = timeFinal;
        this.socialAction = socialAction;
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

    @Column(name = "email_contact")
    String emailContact;

    @Column
    String status;

    @Column
    String description;

    @Column
    Integer quantityOfVacancy;

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
