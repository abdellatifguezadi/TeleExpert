package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Utilisateur;
import com.example.teleexpertise.util.HibernateUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

public interface IUtilisateurDao {
    public void save(Utilisateur utilisateur);

    public Utilisateur findByEmail(String email);
}
