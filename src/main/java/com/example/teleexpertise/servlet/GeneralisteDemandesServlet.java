package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.DemandeExpertiseDao;
import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.DemandeExpertise;
import com.example.teleexpertise.model.MedecinGeneraliste;
import com.example.teleexpertise.model.Utilisateur;
import com.example.teleexpertise.service.DemandeExpertiseService;
import com.example.teleexpertise.service.IDemandeExpertiseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/generaliste/demandes")
public class GeneralisteDemandesServlet extends HttpServlet {

    private IDemandeExpertiseService demandeService;

    @Override
    public void init() {
        this.demandeService = new DemandeExpertiseService(new DemandeExpertiseDao());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession(false) == null || request.getSession(false).getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String email = (String) request.getSession().getAttribute("userEmail");
        UtilisateurDao utilisateurDao = new UtilisateurDao();
        Utilisateur utilisateur = utilisateurDao.findByEmail(email);
        if (utilisateur == null || !Utilisateur.Role.GENERALISTE.equals(utilisateur.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        MedecinGeneraliste generaliste = (MedecinGeneraliste) utilisateur;
        List<DemandeExpertise> demandes = demandeService.getDemandesForGeneraliste(generaliste.getId(), DemandeExpertise.Status.TERMINEE);
        request.setAttribute("demandes", demandes);
        request.setAttribute("utilisateur", generaliste);
        request.getRequestDispatcher("/generaliste/demandes.jsp").forward(request, response);
    }
}

