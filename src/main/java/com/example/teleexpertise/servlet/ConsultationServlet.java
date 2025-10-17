package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.ConsultationDao;
import com.example.teleexpertise.dao.IConsultationDao;
import com.example.teleexpertise.dao.IPatientDao;
import com.example.teleexpertise.dao.PatientDao;
import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.model.MedecinGeneraliste;
import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.Utilisateur;
import com.example.teleexpertise.service.ConsultationService;
import com.example.teleexpertise.service.IConsultationService;
import com.example.teleexpertise.service.IPatientServices;
import com.example.teleexpertise.service.PatientServices;
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

    private IConsultationDao consultationDao;
    private IPatientServices patientServices;

    @Override
    public void init() throws ServletException {
        consultationDao = new ConsultationDao();
        IPatientDao patientDao = new PatientDao();
        patientServices = new PatientServices(patientDao, consultationDao);
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
                List<Consultation> consultations = consultationService.
                        getConsultationsByPatientIdAndMedecin(patientId, medecinId);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String consultationIdStr = request.getParameter("consultationId");
        String patientIdStr = request.getParameter("patientId");
        String status = request.getParameter("status");
      //response.getWriter().println(consultationIdStr+" "+ patientIdStr+" "+status);
       if (consultationIdStr != null && patientIdStr != null && status != null) {
            try {
                long consultationId = Long.parseLong(consultationIdStr);
                int patientId = Integer.parseInt(patientIdStr);

                ConsultationService consultationService = new ConsultationService(consultationDao);
                consultationService.updateConsultationStatus(consultationId, status);

                Patient patient = patientServices.getPatientById(patientId);
                patientServices.changeStatus(patient);

                response.sendRedirect(request.getContextPath() + "/generaliste/consultation?patientId=" + patientId);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid consultation or patient ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing consultation, patient ID, or status");
        }
    }
}