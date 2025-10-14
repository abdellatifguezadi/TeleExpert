package com.example.teleexpertise.service;

import com.example.teleexpertise.model.SignesVitaux;

public interface ISignesVitauxService {
    void enregistrerSignesVitaux(SignesVitaux signesVitaux);
    SignesVitaux obtenirSignesVitauxParPatientId(long patientId);
}


