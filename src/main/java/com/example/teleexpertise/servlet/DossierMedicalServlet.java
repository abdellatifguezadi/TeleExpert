package com.example.teleexpertise.servlet;


import com.example.teleexpertise.dao.DossierMedicalDao;
import com.example.teleexpertise.dao.PatientDao;
import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.DossierMedical;
import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.Utilisateur;
import com.example.teleexpertise.service.DossierMedicalService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/infirmier/add-dossiermedical")
public class DossierMedicalServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            int patirntId = Integer.parseInt(request.getParameter("id"));
            String allergies = request.getParameter("allergies");
            String antecedents = request.getParameter("antecedents");
            String traitementEnCours = request.getParameter("traitementEnCours");

            PatientDao patientDao = new PatientDao();
            Patient patient = patientDao.getPatientById(patirntId);

            DossierMedical dossierMedical = new DossierMedical();
            dossierMedical.setPatient(patient);
            dossierMedical.setAllergies(allergies);
            dossierMedical.setTraitementEnCours(traitementEnCours);
            dossierMedical.setAntecedents(antecedents);

            DossierMedicalDao dossierMedicalDao = new DossierMedicalDao();
            DossierMedicalService dossierMedicalService = new DossierMedicalService(dossierMedicalDao);
            dossierMedicalService.saveDossierMedical(dossierMedical);



            response.sendRedirect(request.getContextPath() + "/infirmier/dashboard");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de l'enregistrement du dossier médical");
        }
    }
}
