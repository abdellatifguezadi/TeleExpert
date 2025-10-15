package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Creneau;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;


public class CreneauDao implements ICreneauDao {
    public void save(Creneau creneau) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(creneau);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
