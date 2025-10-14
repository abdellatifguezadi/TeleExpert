package com.example.teleexpertise.service;

import com.example.teleexpertise.model.Consultation;
import java.util.List;

public interface IConsultationService {
    void saveConsultation(Consultation consultation);
    List<Consultation> getConsultationsByPatientIdAndMedecin(long PatientId, long MedecinId);
    boolean updateConsultationStatus(Long consultationId, String statusStr);
}

