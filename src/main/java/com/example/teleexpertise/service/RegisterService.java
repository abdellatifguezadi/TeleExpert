package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.CreneauDao;
import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.Creneau;
import com.example.teleexpertise.model.MedecinSpecialiste;
import com.example.teleexpertise.model.Utilisateur;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class RegisterService implements IRegisterService {
    private final UtilisateurDao utilisateurDao;
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$");

    public RegisterService() {
        this.utilisateurDao = new UtilisateurDao();
    }

    @Override
    public List<String> validateInput(String nom, String prenom, String email, String password, String role) {
        List<String> errors = new ArrayList<>();

        if (nom == null || nom.trim().length() < 2) {
            errors.add("Le nom est requis");
        }
        if (prenom == null || prenom.trim().length() < 2) {
            errors.add("Le prénom est requis");
        }
        if (email == null || email.trim().isEmpty()) {
            errors.add("L'email est requis");
        } else if (!EMAIL_PATTERN.matcher(email).matches()) {
            errors.add("Format d'email invalide");
        } else if (utilisateurDao.findByEmail(email) != null) {
            errors.add("Cet email est déjà utilisé");
        }
        if (password == null || password.isEmpty()) {
            errors.add("Le mot de passe est requis");
        } else {
            if (password.length() < 6) {
                errors.add("Le mot de passe doit contenir au moins 8 caractères");
            }
        }

        if (role == null || role.trim().isEmpty()) {
            errors.add("Le rôle est requis");
        } else {
            try {
                Utilisateur.Role.valueOf(role.toUpperCase());
            } catch (Exception e) {
                errors.add("Rôle invalide");
            }
        }

        return errors;
    }

    @Override
    public List<String> register(String nom, String prenom, String email, String password, String role) {
        List<String> errors = validateInput(nom, prenom, email, password, role);
        if (errors != null && !errors.isEmpty()) {
            return errors;
        }

        try {
            String hash = BCrypt.hashpw(password, BCrypt.gensalt());

            Utilisateur user;
            switch (role.toUpperCase()) {
                case "INFIRMIER":
                    user = new com.example.teleexpertise.model.Infirmier();
                    user.setType_medecin(String.valueOf(Utilisateur.Role.INFIRMIER));
                    break;
                case "GENERALISTE":
                    user = new com.example.teleexpertise.model.MedecinGeneraliste();
                    user.setType_medecin(String.valueOf(Utilisateur.Role.GENERALISTE));
                    break;
                case "SPECIALISTE":
                    user = new com.example.teleexpertise.model.MedecinSpecialiste();
                    user.setType_medecin(String.valueOf(Utilisateur.Role.SPECIALISTE));
                    break;
                default:
                    user = new com.example.teleexpertise.model.Infirmier();
                    user.setType_medecin(String.valueOf(Utilisateur.Role.INFIRMIER));
                    break;
            }

            user.setNom(nom);
            user.setPrenom(prenom);
            user.setEmail(email);
            user.setMotDePasse(hash);
            user.setRole(Utilisateur.Role.valueOf(role.toUpperCase()));

            utilisateurDao.save(user);

            if (user instanceof MedecinSpecialiste) {
                CreneauDao creneauDao = new CreneauDao();
                MedecinSpecialiste specialiste = (MedecinSpecialiste) user;
                LocalDate today = LocalDate.now();
                LocalTime[] startTimes = {
                        LocalTime.of(9, 0),
                        LocalTime.of(9, 30),
                        LocalTime.of(10, 0),
                        LocalTime.of(10, 30),
                        LocalTime.of(11, 0),
                        LocalTime.of(11, 30)
                };
                for (LocalTime start : startTimes) {
                    Creneau creneau = new Creneau();
                    creneau.setMedecinSpecialiste(specialiste);
                    creneau.setDateHeureDebut(LocalDateTime.of(today, start));
                    creneau.setDateHeureFin(LocalDateTime.of(today, start.plusMinutes(30)));
                    creneau.setStatus(Creneau.Status.DISPONIBLE);
                    creneauDao.save(creneau);
                }
            }

            return new ArrayList<>();
        } catch (Exception e) {
            List<String> err = new ArrayList<>();
            err.add("Erreur lors de l'inscription: " + e.getMessage());
            return err;
        }
    }
}
