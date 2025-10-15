package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.SignesVitaux;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

public class SignesVitauxDao implements ISignesVitauxDao {

    public void saveSignesVitaux(SignesVitaux signesVitaux) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try{
            entityManager.getTransaction().begin();
            entityManager.persist(signesVitaux);
            entityManager.getTransaction().commit();
        }catch (Exception e){
            System.err.println("Error in saveSignesVitaux: " + e.getMessage());
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
        }finally {
            entityManager.close();
        }
    }


    public SignesVitaux getSignesVitauxByPatient(long patientId) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            return entityManager.createQuery(
                "SELECT s FROM SignesVitaux s WHERE s.patient.id = :patientId", SignesVitaux.class)
                .setParameter("patientId", patientId)
                .getSingleResult();
        } catch (Exception e) {
            System.err.println("Error in getSignesVitauxByPatient: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }




}
