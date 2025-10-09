package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.SignesVitaux;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

public class SignesVitauxDao {

    public void saveSignesVitaux(SignesVitaux signesVitaux) {
        EntityManager em = HibernateUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(signesVitaux);
        em.getTransaction().commit();
        em.close();
    }




}
