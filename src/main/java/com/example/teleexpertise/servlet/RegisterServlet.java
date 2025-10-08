package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UtilisateurDao utilisateurDao;

    @Override
    public void init() {
        utilisateurDao = new UtilisateurDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String email = req.getParameter("email");
        String password = req.getParameter("motDePasse");
        String role = req.getParameter("role");

        String hash = BCrypt.hashpw(password, BCrypt.gensalt());

        Utilisateur user;
        switch (role.toUpperCase()) {
            case "INFIRMIER":
                user = new Infirmier();
                user.setType_medecin(String.valueOf(Utilisateur.Role.INFIRMIER));
                break;
            case "GENERALISTE":
                user = new MedecinGeneraliste();
                user.setType_medecin(String.valueOf(Utilisateur.Role.GENERALISTE));
                break;
            case "SPECIALISTE":
                user = new MedecinSpecialiste();
                user.setType_medecin(String.valueOf(Utilisateur.Role.SPECIALISTE));
                break;
            default:
                user = new Infirmier();
                user.setType_medecin(String.valueOf(Utilisateur.Role.INFIRMIER));
                break;
        }

        user.setNom(nom);
        user.setPrenom(prenom);
        user.setEmail(email);
        user.setMotDePasse(hash);
        user.setRole(Utilisateur.Role.valueOf(role.toUpperCase()));

        try {
            utilisateurDao.save(user);
            resp.sendRedirect("index.jsp");
        } catch (Exception e) {
            req.setAttribute("error", "Erreur lors de l'inscription: " + e.getMessage());
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}