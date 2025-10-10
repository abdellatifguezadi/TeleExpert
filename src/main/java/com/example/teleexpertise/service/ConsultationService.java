package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.ConsultationDao;
import com.example.teleexpertise.model.Consultation;

public class ConsultationService {

    private ConsultationDao consultationDao;

   public  ConsultationService(ConsultationDao consultationDao){
         this.consultationDao = consultationDao;
   }

   public void saveConsultation(Consultation consultation){
       consultationDao.saveConsultation(consultation);
   }

}
