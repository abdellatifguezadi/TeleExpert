package com.example.teleexpertise.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@DiscriminatorValue("MedecinGeneraliste")
public class MedecinGeneraliste extends Utilisateur {
    @OneToMany(mappedBy = "medecinGeneraliste" , cascade = CascadeType.ALL)
    private List<Consultation> consultations;

    public MedecinGeneraliste() {
        super();
    }

    public List<Consultation> getConsultations() { return consultations; }
    public void setConsultations(List<Consultation> consultations) { this.consultations = consultations; }
}