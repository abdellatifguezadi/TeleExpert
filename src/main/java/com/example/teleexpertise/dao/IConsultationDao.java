package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public interface IConsultationDao {
    void saveConsultation(Consultation consultation);
    List<Consultation> getConsultationsByPatientAndMedecin(long patientId, long medecinId) ;
    Consultation getConsultationById(Long id) ;
    List<Consultation> getConsultationsById(long id) ;
    void updateConsultation(Consultation consultation);

}

