package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.DossierMedical;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class DossierMedicalDao {

    public void saveDossierMedical(DossierMedical dossierMedical) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try{
            entityManager.getTransaction().begin();
            entityManager.persist(dossierMedical);
            entityManager.getTransaction().commit();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            entityManager.close();
        }
    }


    public DossierMedical getDossierMedicalByPatientId(long patientId) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            List<DossierMedical> dossierMedicals = entityManager.createQuery(
                "SELECT d FROM DossierMedical d WHERE d.patient.id = :patientId", DossierMedical.class)
                .setParameter("patientId", patientId)
                .getResultList();
            return dossierMedicals.isEmpty() ? null : dossierMedicals.get(0);
        } finally {
            entityManager.close();
        }
    }

}
