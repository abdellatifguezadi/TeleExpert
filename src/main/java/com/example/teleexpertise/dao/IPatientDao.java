package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public interface IPatientDao {
    public void savePatient(Patient patient) ;


    public List<Patient> getAllPatients();

    public Patient getPatientById(int id);

    public List<Patient> getPatientsEnAttente();
}
