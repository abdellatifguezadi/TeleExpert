package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.IDemandeExpertiseDao;
import com.example.teleexpertise.model.Consultation;
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

    @Override
    public boolean respondToDemande(Long demandeId, Long medecinSpecialisteId, String avisMedecin, String recommandations) {
        DemandeExpertise demande = demandeExpertiseDao.getDemandeById(demandeId);
        if (demande == null) return false;
        demande.setAvisMedecin(avisMedecin);
        demande.setRecommandations(recommandations);
        demande.setStatus(DemandeExpertise.Status.TERMINEE);

        Consultation consultation = demande.getConsultation();
        consultation.setStatus(Consultation.Status.AVIS_SPECIALISTE_RECU);
        Double oldCout = consultation.getCout() != null ? consultation.getCout() : 0.0;
        Double newCout = oldCout + demande.getMedecinSpecialiste().getTarif();
        consultation.setCout(newCout);

        return demandeExpertiseDao.mergeDemandeAndConsultation(demande, consultation);
    }
}
