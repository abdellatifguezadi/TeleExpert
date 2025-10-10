package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.DossierMedical;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

public class DossierMedicalDao {

    public void saveDossierMedical(DossierMedical dossierMedical) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try{
            entityManager.getTransaction().begin();
            entityManager.persist(dossierMedical);
            entityManager.getTransaction().commit();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            entityManager.close();
        }
    }

}
