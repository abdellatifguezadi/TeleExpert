package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Utilisateur;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;


public class UtilisateurDao implements IUtilisateurDao {

    public void save(Utilisateur utilisateur) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try{
            entityManager.getTransaction().begin();
            if (utilisateur.getId() == null) {
                entityManager.persist(utilisateur);
            } else {
                entityManager.merge(utilisateur);
            }
            entityManager.getTransaction().commit();
        }catch (Exception e){
            System.err.println("Error in save: " + e.getMessage());
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
        }finally {
            entityManager.close();
        }
    }

    public Utilisateur findByEmail(String email) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.createQuery("SELECT u FROM Utilisateur u WHERE u.email = :email", Utilisateur.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            System.err.println("Error in findByEmail: " + e.getMessage());
            return null;
        } finally {
            em.close();
        }
    }
}
