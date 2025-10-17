package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.*;
import com.example.teleexpertise.model.*;
import com.example.teleexpertise.service.ConsultationService;
import com.example.teleexpertise.service.DossierMedicalService;
import com.example.teleexpertise.service.PatientServices;
import com.example.teleexpertise.service.SignesVitauxService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/generaliste/dashboard")
public class GeneralisteDashboardServlet extends HttpServlet {

    private PatientServices patientServices;
    private DossierMedicalService dossierMedicalService;
    private SignesVitauxService signesVitauxService;
    public void init() {
        IPatientDao patientDao = new PatientDao();
        IConsultationDao consultationDao = new ConsultationDao();
        patientServices = new PatientServices(patientDao, consultationDao);
        dossierMedicalService = new DossierMedicalService(new DossierMedicalDao());
        signesVitauxService = new SignesVitauxService(new SignesVitauxDao());
    }

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

        if (utilisateur == null || !Utilisateur.Role.GENERALISTE.toString().equals(utilisateur.getType_medecin())) {
            response.sendRedirect("../login");
            return;
        }

        List<Patient> patients = patientServices.getAllPatientsEnAttente();
         for (Patient patient : patients) {
             DossierMedical dossierMedical = dossierMedicalService.getDossierMedicalByPatientId(patient.getId());
             SignesVitaux signesVitaux = signesVitauxService.obtenirSignesVitauxParPatientId(patient.getId());
             patient.setDossierMedical(dossierMedical);
             patient.setSignesVitaux(signesVitaux);
         }
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("/generaliste/dashboard.jsp").forward(request, response);
    }


    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            int patientId = Integer.parseInt(request.getParameter("patientId"));
            String diagnostic = request.getParameter("diagnostic");
            String traitement = request.getParameter("traitement");
            String motif = request.getParameter("motif");
            String observations = request.getParameter("observations");
            LocalDateTime dateConsultation = LocalDateTime.now();
            PatientDao patientDao = new PatientDao();
            UtilisateurDao utilisateurDao = new UtilisateurDao();
            Consultation consultation = new Consultation();
            Patient patient = patientDao.getPatientById(patientId);

            consultation.setPatient(patient);
            consultation.setMedecinGeneraliste((MedecinGeneraliste) utilisateurDao.findByEmail((String) request.getSession().getAttribute("userEmail")));
            consultation.setDateConsultation(dateConsultation);
            consultation.setMotif(motif);
            consultation.setObservations(observations);
            consultation.setDiagnostic(diagnostic);
            consultation.setTraitement(traitement);
            consultation.setCout(150.0);
            consultation.setStatus(Consultation.Status.EN_ATTENTE);
            ConsultationDao consultationDao = new ConsultationDao();
            ConsultationService consultationService = new ConsultationService(consultationDao);
            consultationService.saveConsultation(consultation);
            response.sendRedirect(request.getContextPath() + "/generaliste/dashboard");
    }

}
