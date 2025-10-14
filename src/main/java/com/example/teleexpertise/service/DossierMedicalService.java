package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.DossierMedicalDao;
import com.example.teleexpertise.model.DossierMedical;

public class DossierMedicalService implements IDossierMedicalService {
    private DossierMedicalDao dossierMedicalDao;

    public DossierMedicalService(DossierMedicalDao dossierMedicalDao) {
        this.dossierMedicalDao = dossierMedicalDao;
    }

    public void saveDossierMedical(DossierMedical dossierMedical) {
        dossierMedicalDao.saveDossierMedical(dossierMedical);
    }

    public DossierMedical getDossierMedicalByPatientId(long patientId) {
        return dossierMedicalDao.getDossierMedicalByPatientId(patientId);
    }
}
