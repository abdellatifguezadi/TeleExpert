package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.ConsultationDao;
import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.model.MedecinGeneraliste;
import com.example.teleexpertise.model.Utilisateur;
import com.example.teleexpertise.service.ConsultationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/generaliste/consultation")
public class ConsultationServlet extends HttpServlet {

    private ConsultationDao consultationDao;

    @Override
    public void init() throws ServletException {
        consultationDao = new ConsultationDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String patientIdStr = request.getParameter("patientId");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("../login");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        UtilisateurDao utilisateurDao = new UtilisateurDao();
        Utilisateur utilisateur = utilisateurDao.findByEmail(userEmail);


        if (utilisateur == null || !Utilisateur.Role.GENERALISTE.toString().equals(utilisateur.getType_medecin())) {
            response.sendRedirect("../login");
            return;
        }

        MedecinGeneraliste medecin = (MedecinGeneraliste) utilisateur;
        long medecinId = medecin.getId();

        if (patientIdStr != null) {
            try {
                long patientId = Long.parseLong(patientIdStr);
                ConsultationService consultationService = new ConsultationService(consultationDao);
                List<Consultation> consultations = consultationService.getConsultationsByPatientIdAndMedecin(patientId, medecinId);
                request.setAttribute("consultations", consultations);
                request.setAttribute("patientId", patientId);
                request.getRequestDispatcher("/generaliste/details-consultation.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid patient ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Patient ID is required");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
