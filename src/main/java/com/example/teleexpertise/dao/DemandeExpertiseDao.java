package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.DemandeExpertise;
import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.ArrayList;
import java.util.List;

public class DemandeExpertiseDao implements IDemandeExpertiseDao{

    @Override
    public void save(DemandeExpertise demandeExpertise) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(demandeExpertise);
            entityManager.getTransaction().commit();
        }catch (Exception e){
            System.err.println("Error in save: " + e.getMessage());
            if(entityManager.getTransaction().isActive()){
                entityManager.getTransaction().rollback();
            }
        }finally {
            entityManager.close();
        }
    }

    @Override
    public List<DemandeExpertise> findByMedecinSpecialisteId(Long medecinSpecialisteId) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            String jpql = "SELECT DISTINCT d FROM DemandeExpertise d " +
                    "LEFT JOIN FETCH d.consultation c " +
                    "LEFT JOIN FETCH c.patient p " +
                    "LEFT JOIN FETCH p.dossierMedical dm " +
                    "LEFT JOIN FETCH p.signesVitaux sv " +
                    "WHERE d.medecinSpecialiste.id = :msId " +
                    "ORDER BY d.dateDemande DESC";
            TypedQuery<DemandeExpertise> query = em.createQuery(jpql, DemandeExpertise.class)
                    .setParameter("msId", medecinSpecialisteId);
            List<DemandeExpertise> results = query.getResultList();
            return results != null ? results : new ArrayList<>();
        } catch (Exception e) {
            System.err.println("Error in findByMedecinSpecialisteId: " + e.getMessage());
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    @Override
    public DemandeExpertise getDemandeById(Long demandeId) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            String jpql = "SELECT d FROM DemandeExpertise d " +
                    "LEFT JOIN FETCH d.consultation c " +
                    "LEFT JOIN FETCH c.patient p " +
                    "LEFT JOIN FETCH p.dossierMedical dm " +
                    "LEFT JOIN FETCH p.signesVitaux sv " +
                    "LEFT JOIN FETCH d.medecinSpecialiste ms " +
                    "WHERE d.id = :id";
            TypedQuery<DemandeExpertise> query = em.createQuery(jpql, DemandeExpertise.class)
                    .setParameter("id", demandeId);
            List<DemandeExpertise> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } catch (Exception e) {
            System.err.println("Error in getDemandeById: " + e.getMessage());
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean mergeDemandeAndConsultation(DemandeExpertise demande, Consultation consultation) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(demande);
            if (consultation != null) em.merge(consultation);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            System.err.println("Error in mergeDemandeAndConsultation: " + e.getMessage());
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public List<DemandeExpertise> findByMedecinGeneralisteIdAndStatus(Long medecinGeneralisteId, DemandeExpertise.Status status) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            String jpql = "SELECT DISTINCT d FROM DemandeExpertise d " +
                    "LEFT JOIN FETCH d.consultation c " +
                    "LEFT JOIN FETCH c.patient p " +
                    "LEFT JOIN FETCH c.medecinGeneraliste mg " +
                    "LEFT JOIN FETCH d.medecinSpecialiste ms " +
                    "WHERE c.medecinGeneraliste.id = :mgId AND d.status = :status " +
                    "ORDER BY d.dateDemande DESC";
            TypedQuery<DemandeExpertise> query = em.createQuery(jpql, DemandeExpertise.class)
                    .setParameter("mgId", medecinGeneralisteId)
                    .setParameter("status", status);
            List<DemandeExpertise> results = query.getResultList();
            return results != null ? results : new ArrayList<>();
        } catch (Exception e) {
            System.err.println("Error in findByMedecinGeneralisteIdAndStatus: " + e.getMessage());
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
