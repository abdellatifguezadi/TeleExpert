package com.example.teleexpertise.model;

import jakarta.persistence.*;

import java.util.List;

@Entity
@DiscriminatorValue("Infirmier")
public class Infirmier extends Utilisateur {

    @OneToMany(mappedBy = "infirmier")
    List<Patient> patients;

    public Infirmier() {
        super();
    }

    public List<Patient> getPatients() {
        return patients;
    }
    public void setPatients(List<Patient> patients) {
        this.patients = patients;
    }
}