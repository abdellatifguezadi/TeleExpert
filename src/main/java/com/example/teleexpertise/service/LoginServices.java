package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.Utilisateur;
import org.mindrot.jbcrypt.BCrypt;

public class LoginServices {

    private UtilisateurDao utilisateurDao;

    public LoginServices() {
        this.utilisateurDao = new UtilisateurDao();
    }

    public boolean authenticate(String email, String password) {
        try {
            Utilisateur utilisateur = utilisateurDao.findByEmail(email);
            if (utilisateur != null) {
                return BCrypt.checkpw(password, utilisateur.getMotDePasse());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
