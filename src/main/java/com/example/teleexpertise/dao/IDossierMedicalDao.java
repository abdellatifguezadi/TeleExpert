package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.DossierMedical;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public interface IDossierMedicalDao {
     void saveDossierMedical(DossierMedical dossierMedical);
     DossierMedical getDossierMedicalByPatientId(long patientId);
}
