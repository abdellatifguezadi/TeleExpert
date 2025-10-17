package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.DemandeExpertise;
import com.example.teleexpertise.model.Consultation;

import java.util.List;

public interface IDemandeExpertiseDao {
    void save(DemandeExpertise demandeExpertise);
    List<DemandeExpertise> findByMedecinSpecialisteId(Long medecinSpecialisteId);
    DemandeExpertise getDemandeById(Long demandeId);
    boolean mergeDemandeAndConsultation(DemandeExpertise demande, Consultation consultation);
    List<DemandeExpertise> findByMedecinGeneralisteIdAndStatus(Long medecinGeneralisteId, DemandeExpertise.Status status);
}
