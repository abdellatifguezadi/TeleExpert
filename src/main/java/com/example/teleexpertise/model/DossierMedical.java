package com.example.teleexpertise.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
public class DossierMedical {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    private String antecedents;
    private String allergies;
    private String traitementEnCours;



    @OneToMany
    private List<ActeTechnique> actesTechniques;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }
    public String getAntecedents() { return antecedents; }
    public void setAntecedents(String antecedents) { this.antecedents = antecedents; }
    public String getAllergies() { return allergies; }
    public void setAllergies(String allergies) { this.allergies = allergies; }
    public String getTraitementEnCours() { return traitementEnCours; }
    public void setTraitementEnCours(String traitementEnCours) { this.traitementEnCours = traitementEnCours; }
    public List<ActeTechnique> getActesTechniques() { return actesTechniques; }
    public void setActesTechniques(List<ActeTechnique> actesTechniques) { this.actesTechniques = actesTechniques; }
}