package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.PatientDao;
import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.SignesVitaux;
import com.example.teleexpertise.model.DossierMedical;
import com.example.teleexpertise.service.SignesVitauxService;
import com.example.teleexpertise.dao.SignesVitauxDao;
import com.example.teleexpertise.dao.DossierMedicalDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/infirmier/add-signesvitaux")
public class SignesVitauxServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int patientId = Integer.parseInt(request.getParameter("id"));
            String tension = request.getParameter("tension");
            Integer frequenceCardiaque = Integer.parseInt(request.getParameter("frequenceCardiaque"));
            Integer frequenceRespiratoire = Integer.parseInt(request.getParameter("frequenceRespiratoire"));
            Double temperature = Double.parseDouble(request.getParameter("temperature"));
            Double poids = Double.parseDouble(request.getParameter("poids"));
            Double taille = Double.parseDouble(request.getParameter("taille"));
            LocalDateTime dateSaisie = LocalDateTime.now();


            PatientDao patientDao = new PatientDao();
            Patient patient = patientDao.getPatientById(patientId);

            SignesVitaux signesVitaux = new SignesVitaux();
            signesVitaux.setPatient(patient);
            signesVitaux.setTension(tension);
            signesVitaux.setFrequenceCardiaque(frequenceCardiaque);
            signesVitaux.setFrequenceRespiratoire(frequenceRespiratoire);
            signesVitaux.setTemperature(temperature);
            signesVitaux.setPoids(poids);
            signesVitaux.setTaille(taille);
            signesVitaux.setDateSaisie(dateSaisie);

            SignesVitauxDao signesVitauxDao = new SignesVitauxDao();
            SignesVitauxService signesVitauxService = new SignesVitauxService(signesVitauxDao);
            signesVitauxService.enregistrerSignesVitaux(signesVitaux);

            response.sendRedirect(request.getContextPath() + "/infirmier/dashboard");


        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de l'enregistrement des signes vitaux");
        }
    }
}
