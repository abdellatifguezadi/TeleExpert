package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.DemandeExpertise;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

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
}

