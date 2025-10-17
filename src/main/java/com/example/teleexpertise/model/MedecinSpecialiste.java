package com.example.teleexpertise.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@DiscriminatorValue("MedecinSpecialiste")
public class MedecinSpecialiste extends Utilisateur {
    @Enumerated(EnumType.STRING)
    private Specialite specialite;
    private Double tarif;
    private Integer dureeConsultation;

    @OneToMany(mappedBy = "medecinSpecialiste",cascade = CascadeType.ALL)
    private List<Creneau> creneauxDisponibles;

    public MedecinSpecialiste() {
        super();
    }

    public enum Specialite {
        CARDIOLOGIE, PNEUMOLOGIE , ORTHOPEDIE ,NEPHROLOGIE , PSYCHIATRIE , RHUMATALOGIE , DERMATOLOGIE , ENDOCRINOLOGIE , GASTRO_ENTEROLOGIE  , NEUROLOGIE
    }

    public Specialite getSpecialite() { return specialite; }
    public void setSpecialite(Specialite specialite) { this.specialite = specialite; }
    public Double getTarif() { return tarif; }
    public void setTarif(Double tarif) { this.tarif = tarif; }
    public Integer getDureeConsultation() { return dureeConsultation; }
    public void setDureeConsultation(Integer dureeConsultation) { this.dureeConsultation = dureeConsultation; }
    public List<Creneau> getCreneauxDisponibles() { return creneauxDisponibles; }
    public void setCreneauxDisponibles(List<Creneau> creneauxDisponibles) { this.creneauxDisponibles = creneauxDisponibles; }

}