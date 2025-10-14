package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Utilisateur;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

public interface IUtilisateurDao {
     void save(Utilisateur utilisateur);
     Utilisateur findByEmail(String email);
}
