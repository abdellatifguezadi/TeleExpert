package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Creneau;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

import java.util.List;


public class CreneauDao implements ICreneauDao {
    public void save(Creneau creneau) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(creneau);
            em.getTransaction().commit();
        } catch (Exception e) {
            System.err.println("Error in save: " + e.getMessage());
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
        } finally {
            em.close();
        }
    }

    public List<Creneau> findBySpecialisteId(Long specialisteId){
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            return  entityManager.createQuery(
                "SELECT c FROM Creneau c WHERE c.medecinSpecialiste.id = :specialisteId", Creneau.class)
                .setParameter("specialisteId", specialisteId)
                .getResultList();
        } catch (Exception e) {
            System.err.println("Error in findBySpecialisteId: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Creneau findById(Long id) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            return entityManager.find(Creneau.class, id);
        } catch (Exception e) {
            System.err.println("Error in findById: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public boolean updateStatus(Long creneauId, String status) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            entityManager.getTransaction().begin();
            int updated = entityManager.createQuery(
                "UPDATE Creneau c SET c.status = :status WHERE c.id = :id")
                .setParameter("status", Creneau.Status.valueOf(status))
                .setParameter("id", creneauId)
                .executeUpdate();
            entityManager.getTransaction().commit();
            return updated > 0;
        } catch (Exception e) {
            System.err.println("Error in updateStatus: " + e.getMessage());
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            return false;
        } finally {
            entityManager.close();
        }
    }
}
