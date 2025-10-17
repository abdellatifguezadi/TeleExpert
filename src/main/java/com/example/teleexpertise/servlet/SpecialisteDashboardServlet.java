package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.DemandeExpertiseDao;
import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.DemandeExpertise;
import com.example.teleexpertise.model.Utilisateur;
import com.example.teleexpertise.service.DemandeExpertiseService;
import com.example.teleexpertise.service.IDemandeExpertiseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/specialiste/dashboard")
public class SpecialisteDashboardServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("../login");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        UtilisateurDao utilisateurDao = new UtilisateurDao();
        Utilisateur utilisateur = utilisateurDao.findByEmail(userEmail);

        if (utilisateur == null || !Utilisateur.Role.SPECIALISTE.toString().equals(utilisateur.getType_medecin())) {
            response.sendRedirect("../login");
            return;
        }

        IDemandeExpertiseService demandeService = new DemandeExpertiseService(new DemandeExpertiseDao());
        Long specialisteId = utilisateur.getId();
        List<DemandeExpertise> demandes = demandeService.getDemandesForSpecialiste(specialisteId);

        request.setAttribute("demandes", demandes);
        request.setAttribute("utilisateur", utilisateur);

        request.getRequestDispatcher("/specialiste/dashboard.jsp").forward(request, response);
    }
}
