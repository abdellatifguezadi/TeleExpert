package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Utilisateur;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;


public class UtilisateurDao {

    public void save(Utilisateur utilisateur) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try{
            entityManager.getTransaction().begin();
            entityManager.persist(utilisateur);
            entityManager.getTransaction().commit();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            entityManager.close();
        }
    }

    public Utilisateur findByEmail(String email) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            Utilisateur utilisateur = em.createQuery("SELECT u FROM Utilisateur u WHERE u.email = :email", Utilisateur.class)
                    .setParameter("email", email)
                    .getSingleResult();
            em.close();
            return utilisateur;
        } catch (NoResultException e) {
            em.close();
            return null;
        }
    }
}
