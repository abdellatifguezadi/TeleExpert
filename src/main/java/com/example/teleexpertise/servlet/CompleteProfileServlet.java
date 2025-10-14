package com.example.teleexpertise.servlet;

import com.example.teleexpertise.dao.UtilisateurDao;
import com.example.teleexpertise.model.MedecinSpecialiste;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/specialiste/complete-profile")
public class CompleteProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/specialiste/complete-profile.jsp").forward(request, response);
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
        MedecinSpecialiste spec = (MedecinSpecialiste) utilisateurDao.findByEmail(userEmail);

        String specialite = request.getParameter("specialite");
        String tarifStr = request.getParameter("tarif");
        String dureeStr = request.getParameter("dureeConsultation");

        //response.getWriter().println(specialite+" "+ tarifStr+" "+dureeStr +" "+ spec.getId());

        try {
            spec.setSpecialite(MedecinSpecialiste.Specialite.valueOf(specialite));
            spec.setTarif(Double.parseDouble(tarifStr));
            spec.setDureeConsultation(Integer.parseInt(dureeStr));
        } catch (Exception e) {
            request.setAttribute("error", "Valeurs invalides.");
            request.getRequestDispatcher("/specialiste/complete-profile.jsp").forward(request, response);
            return;
        }
        utilisateurDao.save(spec);
        response.sendRedirect(request.getContextPath() + "/specialiste/dashboard");
    }
}

