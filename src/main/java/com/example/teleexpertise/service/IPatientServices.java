package com.example.teleexpertise.service;

import com.example.teleexpertise.model.Patient;
import java.util.List;

public interface IPatientServices {
    List<Patient> getAllPatients();
    void savePatient(Patient patient);
    List<Patient> getAllPatientsEnAttente();
    void changeStatus(Patient patient);
    Patient getPatientById(int id);
}