package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.IDemandeExpertiseDao;
import com.example.teleexpertise.model.DemandeExpertise;

import java.util.List;

public interface IDemandeExpertiseService {
    void saveDemandeExpertise(DemandeExpertise demandeExpertise);

    List<DemandeExpertise> getDemandesForSpecialiste(Long medecinSpecialisteId);
    boolean respondToDemande(Long demandeId, Long medecinSpecialisteId, String avisMedecin, String recommandations);
    List<DemandeExpertise> getDemandesForGeneraliste(Long medecinGeneralisteId, DemandeExpertise.Status status);
}
