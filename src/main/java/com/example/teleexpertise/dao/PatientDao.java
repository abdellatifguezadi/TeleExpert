package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;
import java.util.Collections;
import java.util.List;

public class PatientDao implements IPatientDao {

    public void savePatient(Patient patient) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try{
            entityManager.getTransaction().begin();
            entityManager.persist(patient);
            entityManager.getTransaction().commit();
        }catch (Exception e){
            System.err.println("Error in savePatient: " + e.getMessage());
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
        }finally {
            entityManager.close();
        }
    }

    public List<Patient> getAllPatients() {
        EntityManager entityManager  = HibernateUtil.getEntityManager();
        try {
            return entityManager.createQuery("SELECT p FROM Patient p", Patient.class).getResultList();
        } catch (Exception e) {
            System.err.println("Error in getAllPatients: " + e.getMessage());
            return Collections.emptyList();
        } finally {
            entityManager.close();
        }
    }

    public Patient getPatientById(int id) {
        EntityManager entityManager  = HibernateUtil.getEntityManager();
        try {
            return entityManager.find(Patient.class, id);
        } catch (Exception e) {
            System.err.println("Error in getPatientById: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }

    public List<Patient> getPatientsEnAttente(){
        EntityManager entityManager  = HibernateUtil.getEntityManager();
        try {
            return entityManager.createQuery("SELECT p FROM Patient p WHERE p.fileAttente = true" , Patient.class).getResultList();
        } catch (Exception e) {
            System.err.println("Error in getPatientsEnAttente: " + e.getMessage());
            return Collections.emptyList();
        } finally {
            entityManager.close();
        }
    }
}
