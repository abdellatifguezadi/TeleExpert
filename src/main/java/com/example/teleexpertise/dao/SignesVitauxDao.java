package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.SignesVitaux;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

public class SignesVitauxDao {

    public void saveSignesVitaux(SignesVitaux signesVitaux) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try{
            entityManager.getTransaction().begin();
            entityManager.persist(signesVitaux);
            entityManager.getTransaction().commit();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            entityManager.close();
        }
    }




}
