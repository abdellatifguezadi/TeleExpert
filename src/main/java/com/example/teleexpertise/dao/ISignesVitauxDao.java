package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.SignesVitaux;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

public interface ISignesVitauxDao {
     void saveSignesVitaux(SignesVitaux signesVitaux);
     SignesVitaux getSignesVitauxByPatient(long patientId);
}
