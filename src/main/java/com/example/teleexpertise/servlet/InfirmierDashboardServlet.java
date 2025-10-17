package com.example.teleexpertise.servlet;


import com.example.teleexpertise.dao.IPatientDao;
import com.example.teleexpertise.dao.PatientDao;
import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.Utilisateur;
import com.example.teleexpertise.model.Infirmier;
import com.example.teleexpertise.service.IPatientServices;
import com.example.teleexpertise.service.PatientServices;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/infirmier/dashboard")
public class InfirmierDashboardServlet extends HttpServlet {

    private IPatientServices patientServices;

    public void init() {
        IPatientDao patientDao = new PatientDao();
        patientServices = new PatientServices(patientDao, null); // Pass null or inject as needed
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        UtilisateurDao utilisateurDao = new UtilisateurDao();
        Utilisateur utilisateur = utilisateurDao.findByEmail(userEmail);

        if (utilisateur == null || !Utilisateur.Role.INFIRMIER.toString().equals(utilisateur.getType_medecin())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        List<Patient> patients = patientServices.getAllPatients();
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("/infirmier/dashboard.jsp").forward(request, response);
    }


    protected  void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        UtilisateurDao utilisateurDao = new UtilisateurDao();
        Utilisateur utilisateur = utilisateurDao.findByEmail(userEmail);

        if (utilisateur == null || !Utilisateur.Role.INFIRMIER.toString().equals(utilisateur.getType_medecin())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String dateNaissance = request.getParameter("dateNaissance");
        String adresse = request.getParameter("adresse");
        String telephone = request.getParameter("telephone");
        String fileAttente = request.getParameter("fileAttente");
        String mutuelle = request.getParameter("mutuelle");
        String numSecu = request.getParameter("numSecu");

        Patient patient = new Patient();
        patient.setNom(nom);
        patient.setPrenom(prenom);
        patient.setDateNaissance(LocalDate.parse(dateNaissance));
        patient.setAdresse(adresse);
        patient.setTelephone(telephone);
        patient.setFileAttente(Boolean.valueOf(fileAttente));
        patient.setMutuelle(mutuelle);
        patient.setNumSecu(numSecu);
        patient.setInfirmier((Infirmier) utilisateur);

        try {
            patientServices.savePatient(patient);
            response.sendRedirect(request.getContextPath() + "/infirmier/dashboard");
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de l'ajout du patient: " + e.getMessage());
            request.getRequestDispatcher("/infirmier/dashboard.jsp").forward(request, response);
        }
    }

}