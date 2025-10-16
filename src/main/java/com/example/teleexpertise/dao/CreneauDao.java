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
        }
    }
}
