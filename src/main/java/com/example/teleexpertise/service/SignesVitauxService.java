package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.ISignesVitauxDao;
import com.example.teleexpertise.model.SignesVitaux;

public class SignesVitauxService implements ISignesVitauxService {

    private ISignesVitauxDao signesVitauxDao;

    public SignesVitauxService(ISignesVitauxDao signesVitauxDao) {
        this.signesVitauxDao = signesVitauxDao;
    }

    public void enregistrerSignesVitaux(SignesVitaux signesVitaux) {
        signesVitauxDao.saveSignesVitaux(signesVitaux);
    }

    public SignesVitaux obtenirSignesVitauxParPatientId(long patientId) {
        return signesVitauxDao.getSignesVitauxByPatient(patientId);
    }
}
