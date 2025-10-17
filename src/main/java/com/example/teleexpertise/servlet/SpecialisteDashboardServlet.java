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

        Object flash = session.getAttribute("message");
        if (flash != null) {
            request.setAttribute("message", flash.toString());
            session.removeAttribute("message");
        }

        request.setAttribute("demandes", demandes);
        request.setAttribute("utilisateur", utilisateur);

        request.getRequestDispatcher("/specialiste/dashboard.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        UtilisateurDao utilisateurDao = new UtilisateurDao();
        Utilisateur utilisateur = utilisateurDao.findByEmail(userEmail);

        if (utilisateur == null || !Utilisateur.Role.SPECIALISTE.toString().equals(utilisateur.getType_medecin())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String demandeIdStr = request.getParameter("demandeId");
        String avisMedecin = request.getParameter("avisMedecin");
        String recommandations = request.getParameter("recommandations");
        Long demandeId = Long.parseLong(demandeIdStr);

        IDemandeExpertiseService demandeService = new DemandeExpertiseService(new DemandeExpertiseDao());
        boolean ok = demandeService.respondToDemande(demandeId, utilisateur.getId(), avisMedecin, recommandations);

        if (ok) {
            session.setAttribute("message", "Réponse enregistrée et consultation mise à jour.");
        } else {
            session.setAttribute("message", "Impossible d'enregistrer la réponse (autorisation ou erreur).");
        }

        response.sendRedirect(request.getContextPath() + "/specialiste/dashboard");
    }
}
