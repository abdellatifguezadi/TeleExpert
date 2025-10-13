package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class PatientDao {

    private ConsultationDao consultationDao = new ConsultationDao();

    public void savePatient(Patient patient) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        try{
            entityManager.getTransaction().begin();
            entityManager.persist(patient);
            entityManager.getTransaction().commit();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            entityManager.close();
        }
    }


    public List<Patient> getAllPatients() {
        EntityManager entityManager  = HibernateUtil.getEntityManager();
        List<Patient> patients = entityManager.createQuery("SELECT p FROM Patient p", Patient.class).getResultList();
        entityManager.close();
        return patients;
    }

    public Patient getPatientById(int id) {
        EntityManager entityManager  = HibernateUtil.getEntityManager();
        Patient patient = entityManager.find(Patient.class, id);
        entityManager.close();
        return patient;
    }

    public void changeStatus(Patient patient ) {
        EntityManager entityManager = HibernateUtil.getEntityManager();
        entityManager.getTransaction().begin();
        List<Consultation> consultations = consultationDao.getConsultationsById(patient.getId());
        boolean attente = false;
        for (Consultation consultation : consultations) {
            if (consultation.getStatus() != Consultation.Status.TERMINEE) {
                attente = true;
                break;
            }
        }
        patient.setFileAttente(attente);
        entityManager.merge(patient);
        entityManager.getTransaction().commit();
        entityManager.close();
    }

    public List<Patient> getPatientsEnAttente(){
        EntityManager entityManager  = HibernateUtil.getEntityManager();
        List<Patient> patients = entityManager.createQuery("SELECT p FROM Patient p WHERE p.fileAttente = true" , Patient.class).getResultList();
        entityManager.close();
        return patients;
    }
}
