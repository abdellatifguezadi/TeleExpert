package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.PatientDao;
import com.example.teleexpertise.model.Patient;

import java.security.PrivateKey;
import java.util.List;

public class PatientServices {

    private PatientDao patientDao ;

    public PatientServices(PatientDao patientDao) {
        this.patientDao = patientDao;
    }

    public List <Patient> getAllPatients() {
        List<Patient> patients = patientDao.getAllPatients();

        if (patients.isEmpty()) {
            System.out.println("No patients found");
        }
        return patients;
    }


    public void savePatient(Patient patient) {
        patientDao.savePatient(patient);
    }


    public List <Patient> getAllPatientsEnAttente() {
        List<Patient> patients = patientDao.getPatientsEnAttente();

        if (patients.isEmpty()) {
            System.out.println("No patients found");
        }
        return patients;
    }

}
