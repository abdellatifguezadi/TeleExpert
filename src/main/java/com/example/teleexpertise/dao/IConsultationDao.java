package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

import java.util.List;

public interface IConsultationDao {
    public  void saveConsultation(Consultation consultation);


    public List<Consultation> getConsultationsByPatientAndMedecin(long patientId, long medecinId) ;

    public Consultation getConsultationById(Long id) ;

    public List<Consultation> getConsultationsById(long id) ;

    public void updateConsultation(Consultation consultation);

}

