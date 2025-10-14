package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public interface IPatientDao {
     void savePatient(Patient patient) ;
     List<Patient> getAllPatients();
     Patient getPatientById(int id);
     List<Patient> getPatientsEnAttente();
}
