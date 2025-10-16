package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.*;
import com.example.teleexpertise.model.*;
import com.example.teleexpertise.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;


@WebServlet("/generaliste/reserve-creneau")
public class DemandeExpertiseServlet extends HttpServlet {

    private IDemandeExpertiseService demandeExpertiseService;
    private IConsultationService consultationService;
    private ICreneauService creneauService;
    private IMedecinSpecialisteService medecinSpecialisteService;

    @Override
    public void init() {
        IDemandeExpertiseDao demandeExpertiseDao = new DemandeExpertiseDao();
        IConsultationDao consultationDao = new ConsultationDao();
        ICreneauDao creneauDao = new CreneauDao();
        IMedecinSpecialisteDao medecinSpecialisteDao = new MedecinSpecialisteDao();

        demandeExpertiseService = new DemandeExpertiseService(demandeExpertiseDao);
        consultationService = new ConsultationService(consultationDao);
        creneauService = new CreneauService(creneauDao);
        medecinSpecialisteService = new MedecinSpecialisteService(medecinSpecialisteDao);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String creneauIdStr = request.getParameter("creneauId");
            String specialisteIdStr = request.getParameter("specialisteId");
            String question = request.getParameter("question");
            String prioriteStr = request.getParameter("priorite");
            String consultationIdStr = request.getParameter("consultationId");



            Long creneauId = Long.parseLong(creneauIdStr);
            Long specialisteId = Long.parseLong(specialisteIdStr);
            Long consultationId = consultationIdStr != null ? Long.parseLong(consultationIdStr) : null;
            MedecinSpecialiste specialiste = medecinSpecialisteService.findById(specialisteId);
            Consultation  consultation = consultationService.getConsultationById(consultationId);

           // response.getWriter().println("Creneau ID: " + creneauId + ", Specialiste ID: " + specialisteId + ", Consultation ID: " + consultationId);


            DemandeExpertise demandeExpertise = new DemandeExpertise();
            demandeExpertise.setConsultation(consultation);
            demandeExpertise.setMedecinSpecialiste(specialiste);
            demandeExpertise.setQuestion(question != null ? question : "Demande d'avis médical");
            demandeExpertise.setPriorite(DemandeExpertise.Priorite.valueOf(prioriteStr.toUpperCase()));
            demandeExpertise.setStatus(DemandeExpertise.Status.EN_ATTENTE);
            demandeExpertise.setDateDemande(LocalDateTime.now());

            demandeExpertiseService.saveDemandeExpertise(demandeExpertise);
            creneauService.updateCreneauStatus(creneauId, "RESERVE");
            consultationService.updateConsultationStatus(consultation.getId(), "EN_ATTENTE_AVIS_SPECIALISTE");

            response.sendRedirect(request.getContextPath() + "/generaliste/SpecialisteList?success=reservation");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameter format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the reservation");
        }
    }
}
