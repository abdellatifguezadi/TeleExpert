package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.IDemandeExpertiseDao;
import com.example.teleexpertise.model.DemandeExpertise;

import java.util.List;

public interface IDemandeExpertiseService {
    void saveDemandeExpertise(DemandeExpertise demandeExpertise);
    List<DemandeExpertise> getDemandesForSpecialiste(Long medecinSpecialisteId);
}
