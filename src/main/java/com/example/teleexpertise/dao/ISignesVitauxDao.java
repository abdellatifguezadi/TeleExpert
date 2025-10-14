package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.SignesVitaux;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;

public interface ISignesVitauxDao {

    public void saveSignesVitaux(SignesVitaux signesVitaux);


    public SignesVitaux getSignesVitauxByPatient(long patientId);
}
