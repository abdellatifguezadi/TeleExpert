package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.DossierMedical;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

public class DossierMedicalDao {

    public void saveDossierMedical(DossierMedical dossierMedical) {
        EntityManager em = HibernateUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(dossierMedical);
        em.getTransaction().commit();
        em.close();
    }

}
