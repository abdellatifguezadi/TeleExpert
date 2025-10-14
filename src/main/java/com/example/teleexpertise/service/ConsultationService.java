package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.ConsultationDao;
import com.example.teleexpertise.dao.IConsultationDao;
import com.example.teleexpertise.model.Consultation;

import java.util.List;

public class ConsultationService implements IConsultationService {

    private ConsultationDao consultationDao;

   public  ConsultationService(ConsultationDao consultationDao){
         this.consultationDao = consultationDao;
   }

   public void saveConsultation(Consultation consultation){
       consultationDao.saveConsultation(consultation);
   }

   public List<Consultation> getConsultationsByPatientIdAndMedecin(long PatientId , long MedecinId){
         List<Consultation> consultations = consultationDao.getConsultationsByPatientAndMedecin(PatientId, MedecinId);

            if(consultations.isEmpty()){
                System.out.println("No consultations found ");
            }
            return consultations;
   }

   public boolean updateConsultationStatus(Long consultationId, String statusStr) {
       Consultation consultation = consultationDao.getConsultationById(consultationId);
       if (consultation == null) return false;
       try {
           Consultation.Status status = Consultation.Status.valueOf(statusStr);
           consultation.setStatus(status);
           consultationDao.updateConsultation(consultation);
           return true;
       } catch (IllegalArgumentException e) {
           System.out.println("Invalid status: " + statusStr);
           return false;
       }
   }


}
