package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.DossierMedical;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public interface IDossierMedicalDao {

    public void saveDossierMedical(DossierMedical dossierMedical);


    public DossierMedical getDossierMedicalByPatientId(long patientId);
}
