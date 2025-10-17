package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.IDemandeExpertiseDao;
import com.example.teleexpertise.model.DemandeExpertise;

import java.util.List;

public class DemandeExpertiseService implements IDemandeExpertiseService{

    private  IDemandeExpertiseDao demandeExpertiseDao;

    public DemandeExpertiseService(IDemandeExpertiseDao demandeExpertiseDao) {
        this.demandeExpertiseDao = demandeExpertiseDao;
    }

    @Override
    public void saveDemandeExpertise(DemandeExpertise demandeExpertise) {
        demandeExpertiseDao.save(demandeExpertise);
    }

    @Override
    public List<DemandeExpertise> getDemandesForSpecialiste(Long medecinSpecialisteId) {
        return demandeExpertiseDao.findByMedecinSpecialisteId(medecinSpecialisteId);
    }
}
