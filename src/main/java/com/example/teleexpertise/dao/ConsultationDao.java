package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ConsultationDao {
        public void saveConsultation(Consultation consultation) {
            EntityManager entityManager = HibernateUtil.getEntityManager();
            try{
                entityManager.getTransaction().begin();
                entityManager.persist(consultation);
                entityManager.getTransaction().commit();
            }catch (Exception e){
                e.printStackTrace();
            }finally {
                entityManager.close();
            }

        }




        public List<Consultation> getConsultationsByPatientAndMedecin(long patientId, long medecinId) {
            EntityManager entityManager  = HibernateUtil.getEntityManager();
            List<Consultation> consultations = entityManager.createQuery(
                "SELECT c FROM Consultation c WHERE c.patient.id = :patientId AND c.medecinGeneraliste.id = :medecinId",
                Consultation.class)
                    .setParameter("patientId", patientId)
                    .setParameter("medecinId", medecinId)
                    .getResultList();
            entityManager.close();
            return consultations;
        }

    public Consultation getConsultationById(Long id) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        Consultation consultation = entityManager.find(Consultation.class, id);
        entityManager.close();
        return consultation;
    }

    public List<Consultation> getConsultationsById(long id) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        List<Consultation> consultations = entityManager.createQuery("SELECT c FROM Consultation c WHERE c.patient.id = :patientId",
                Consultation.class)
                .setParameter("patientId", id)
                .getResultList();
        entityManager.close();
        return consultations;
    }

    public void updateConsultation(Consultation consultation) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.merge(consultation);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
        } finally {
            entityManager.close();
        }
    }

}
