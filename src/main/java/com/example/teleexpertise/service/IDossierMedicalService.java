package com.example.teleexpertise.service;

import com.example.teleexpertise.model.DossierMedical;

public interface IDossierMedicalService {
    void saveDossierMedical(DossierMedical dossierMedical);
    DossierMedical getDossierMedicalByPatientId(long patientId);
}

