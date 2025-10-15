package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.IDossierMedicalDao;
import com.example.teleexpertise.model.DossierMedical;

public class DossierMedicalService implements IDossierMedicalService {
    private IDossierMedicalDao dossierMedicalDao;

    public DossierMedicalService(IDossierMedicalDao dossierMedicalDao) {
        this.dossierMedicalDao = dossierMedicalDao;
    }

    public void saveDossierMedical(DossierMedical dossierMedical) {
        dossierMedicalDao.saveDossierMedical(dossierMedical);
    }

    public DossierMedical getDossierMedicalByPatientId(long patientId) {
        return dossierMedicalDao.getDossierMedicalByPatientId(patientId);
    }
}
