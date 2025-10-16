package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.MedecinSpecialiste;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;
import java.util.Collections;
import java.util.List;

public class MedecinSpecialisteDao implements IMedecinSpecialisteDao {


    @Override
    public List<MedecinSpecialiste> findAll() {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            return entityManager.createQuery(
                "SELECT m FROM MedecinSpecialiste m", MedecinSpecialiste.class)
                .getResultList();
        } catch (Exception e) {
            System.err.println("Error in findAll: " + e.getMessage());
            return Collections.emptyList();
        }
    }

    @Override
    public List<MedecinSpecialiste> findBySpecialite(MedecinSpecialiste.Specialite specialite) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            return entityManager.createQuery(
                "SELECT m FROM MedecinSpecialiste m WHERE m.specialite = :specialite", MedecinSpecialiste.class)
                .setParameter("specialite", specialite)
                .getResultList();
        } catch (Exception e) {
            System.err.println("Error in findBySpecialite: " + e.getMessage());
            return Collections.emptyList();
        }
    }


    @Override
    public List<MedecinSpecialiste> findByTarif(Double tarif) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            return  entityManager.createQuery(
                "SELECT m FROM MedecinSpecialiste m WHERE m.tarif <= :tarif", MedecinSpecialiste.class)
                    .setParameter("tarif", tarif)
                    .getResultList();
        } catch (Exception e) {
            System.err.println("Error in findByTarif: " + e.getMessage());
            return Collections.emptyList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public MedecinSpecialiste findById(Long id) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try {
            return entityManager.find(MedecinSpecialiste.class, id);
        } catch (Exception e) {
            System.err.println("Error in findById: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }
}
