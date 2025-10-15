package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.IPatientDao;
import com.example.teleexpertise.dao.IConsultationDao;
import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public class PatientServices implements IPatientServices {

    private IPatientDao patientDao;
    private IConsultationDao consultationDao;

    public PatientServices(IPatientDao patientDao, IConsultationDao consultationDao) {
        this.patientDao =  patientDao;
        this.consultationDao = consultationDao;
    }

    public List<Patient> getAllPatients() {
        List<Patient> patients = patientDao.getAllPatients();

        if (patients.isEmpty()) {
            System.out.println("No patients found");
        }
        return patients;
    }


    public void savePatient(Patient patient) {
        patientDao.savePatient(patient);
    }


    public List<Patient> getAllPatientsEnAttente() {
        List<Patient> patients = patientDao.getPatientsEnAttente();

        if (patients.isEmpty()) {
            System.out.println("No patients found");
        }
        return patients;
    }

    @Override
    public void changeStatus(Patient patient) {
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


    public Patient getPatientById(int id){
        return patientDao.getPatientById(id);
    }

}
