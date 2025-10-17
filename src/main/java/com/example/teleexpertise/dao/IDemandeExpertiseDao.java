package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.DemandeExpertise;

import java.util.List;

public interface IDemandeExpertiseDao {
    void save(DemandeExpertise demandeExpertise);
    List<DemandeExpertise> findByMedecinSpecialisteId(Long medecinSpecialisteId);
}
