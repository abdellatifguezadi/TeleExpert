package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.PatientDao;
import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.Utilisateur;
import com.example.teleexpertise.service.PatientServices;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/generaliste/dashboard")
public class GeneralisteDashboardServlet extends HttpServlet {

    private PatientServices patientServices;
    public void init() {
        patientServices = new PatientServices(new PatientDao());
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
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("/generaliste/dashboard.jsp").forward(request, response);
    }


    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {



    }

}
