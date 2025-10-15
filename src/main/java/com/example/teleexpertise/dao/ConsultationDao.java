package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

import java.util.Collections;
import java.util.List;

public class ConsultationDao implements IConsultationDao {
        public void saveConsultation(Consultation consultation) {
            EntityManager entityManager = HibernateUtil.getEntityManager();
            try{
                entityManager.getTransaction().begin();
                entityManager.persist(consultation);
                entityManager.getTransaction().commit();
            }catch (Exception e){
                System.err.println("Error in saveConsultation: " + e.getMessage());
            }finally {
                entityManager.close();
            }

        }

        public List<Consultation> getConsultationsByPatientAndMedecin(long patientId, long medecinId) {
            EntityManager entityManager  = HibernateUtil.getEntityManager();
            try {
                return entityManager.createQuery(
                    "SELECT c FROM Consultation c WHERE c.patient.id = :patientId AND c.medecinGeneraliste.id = :medecinId",
                    Consultation.class)
                    .setParameter("patientId", patientId)
                    .setParameter("medecinId", medecinId)
                    .getResultList();
            } catch (Exception e) {
                System.err.println("Error in getConsultationsByPatientAndMedecin: " + e.getMessage());
                return Collections.emptyList();
            } finally {
                entityManager.close();
            }
        }

    public Consultation getConsultationById(Long id) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            return entityManager.find(Consultation.class, id);
        } catch (Exception e) {
            System.err.println("Error in getConsultationById: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }

    public List<Consultation> getConsultationsById(long id) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            return entityManager.createQuery("SELECT c FROM Consultation c WHERE c.patient.id = :patientId",
                Consultation.class)
                .setParameter("patientId", id)
                .getResultList();
        } catch (Exception e) {
            System.err.println("Error in getConsultationsById: " + e.getMessage());
            return Collections.emptyList();
        } finally {
            entityManager.close();
        }
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
