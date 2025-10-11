package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.SignesVitauxDao;
import com.example.teleexpertise.model.SignesVitaux;

public class SignesVitauxService {

    private SignesVitauxDao signesVitauxDao;

    public SignesVitauxService(SignesVitauxDao signesVitauxDao) {
        this.signesVitauxDao = signesVitauxDao;
    }

    public void enregistrerSignesVitaux(SignesVitaux signesVitaux) {
        signesVitauxDao.saveSignesVitaux(signesVitaux);
    }

    public SignesVitaux obtenirSignesVitauxParPatientId(long patientId) {
        return signesVitauxDao.getSignesVitauxByPatient(patientId);
    }
}

